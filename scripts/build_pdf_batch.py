#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import zipfile
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RENDER_COVER = ROOT / "scripts" / "render_workbook_cover.py"
GENERATE_PDF = Path("/home/ubuntu/skills/typst-pdf-maker/scripts/generate_pdf.py")
VERIFY_PDF = Path("/home/ubuntu/skills/typst-pdf-maker/scripts/verify_pdf.py")


def read_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, value: dict) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def unit_payload(source: Path, material: str, edition: str) -> tuple[dict, dict]:
    data = read_json(source)
    unit = data.get("unidade", data)
    enriched = json.loads(json.dumps(data))
    enriched_unit = enriched.get("unidade", enriched)
    enriched_unit["material"] = material
    enriched_unit["edicao"] = edition
    enriched_unit["numero"] = enriched_unit.get("numero") or unit.get("codigo", "B01")[1:]
    return data, enriched


def run(command: list[str], *, cwd: Path | None = None) -> subprocess.CompletedProcess[str]:
    return subprocess.run(command, cwd=cwd, text=True, capture_output=True, check=False)


def validate_source(source: Path) -> dict:
    result = run([sys.executable, str(ROOT / "scripts" / "validate_pdf_first.py"), str(source), "--json"], cwd=ROOT)
    try:
        payload = json.loads(result.stdout)
    except json.JSONDecodeError:
        payload = {"valid": False, "errors": [result.stderr.strip() or "validação não retornou JSON"], "warnings": []}
    payload["returncode"] = result.returncode
    return payload


def pdf_pages(path: Path) -> int:
    result = run(["pdfinfo", str(path)])
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "pdfinfo falhou")
    for line in result.stdout.splitlines():
        if line.startswith("Pages:"):
            return int(line.split(":", 1)[1].strip())
    raise RuntimeError("pdfinfo não encontrou número de páginas")


def package_unit(out: Path, unit_id: str) -> Path:
    zip_path = out / f"{unit_id}-workbook-package.zip"
    with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for file in sorted(out.rglob("*")):
            if not file.is_file() or file == zip_path:
                continue
            if file.name.endswith(".typst-diagnostics.log") or "review" in file.parts:
                continue
            archive.write(file, file.relative_to(out))
    return zip_path


def validate_batch_config(batch: dict, registry: dict) -> list[str]:
    errors: list[str] = []
    if batch.get("schema_version") != "pdf-first-batch-v1":
        errors.append("schema_version deve ser pdf-first-batch-v1")
    if not isinstance(batch.get("produto"), str) or not batch["produto"].strip():
        errors.append("produto deve ser texto não vazio")
    if not isinstance(batch.get("output_label"), str) or not batch["output_label"].strip():
        errors.append("output_label deve ser texto não vazio")
    templates = registry.get("templates") if isinstance(registry, dict) else None
    if not isinstance(templates, dict):
        errors.append("registro de templates sem objeto templates")
        templates = {}
    units = batch.get("units")
    if not isinstance(units, list) or not units:
        errors.append("units deve conter pelo menos uma unidade")
        return errors
    seen: set[str] = set()
    for index, item in enumerate(units, 1):
        if not isinstance(item, dict):
            errors.append(f"units[{index}] deve ser objeto")
            continue
        unit_id = item.get("id")
        if not isinstance(unit_id, str) or not unit_id.strip():
            errors.append(f"units[{index}].id ausente")
        elif unit_id in seen:
            errors.append(f"id repetido no lote: {unit_id}")
        else:
            seen.add(unit_id)
        source = item.get("source")
        if not isinstance(source, str) or not source.strip():
            errors.append(f"units[{index}].source ausente")
        elif not (ROOT / source).is_file():
            errors.append(f"fonte inexistente: {source}")
        profile_name = item.get("template_profile")
        if profile_name not in templates:
            errors.append(f"perfil inexistente: {profile_name}")
    return errors


def build_one(batch: dict, item: dict, registry: dict, output_root: Path) -> dict:
    unit_id = item["id"]
    profile_name = item["template_profile"]
    profile = registry["templates"].get(profile_name)
    if profile is None:
        raise ValueError(f"perfil de template inexistente: {profile_name}")
    source = (ROOT / item["source"]).resolve()
    if not source.is_file():
        raise FileNotFoundError(f"fonte não encontrada: {source}")
    validation = validate_source(source)
    if not validation.get("valid"):
        raise ValueError(f"conteúdo inválido: {validation.get('errors', [])}")

    out = output_root / unit_id
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    assets = out / "assets"
    assets.mkdir()

    source_template = (ROOT / profile["source"]).resolve()
    theme = source_template.parent / "report-theme.typ"
    background = (ROOT / profile["background_asset"]).resolve()
    if not source_template.is_file() or not theme.is_file() or not background.is_file():
        raise FileNotFoundError(f"dependência ausente para o perfil {profile_name}")

    shutil.copy2(source_template, out / "workbook.typ")
    shutil.copy2(theme, out / "report-theme.typ")
    shutil.copy2(background, assets / "bg-fundo-prime.png")

    original_data, enriched_data = unit_payload(source, item["material"], item["edicao"])
    content_path = out / f"{unit_id}-content.json"
    template_content_path = out / "content.json"
    cover_content_path = out / f"{unit_id}-cover-content.json"
    write_json(content_path, original_data)
    write_json(template_content_path, original_data)
    write_json(cover_content_path, enriched_data)

    cover_path = assets / "capa-workbook.png"
    cover_result = run([
        sys.executable,
        str(RENDER_COVER),
        str(cover_content_path),
        "--output",
        str(cover_path),
    ], cwd=ROOT)
    if cover_result.returncode != 0:
        raise RuntimeError(f"renderer da capa falhou: {cover_result.stderr.strip()}")

    pdf_path = out / f"{unit_id}-workbook.pdf"
    compile_result = run([
        sys.executable,
        str(GENERATE_PDF),
        "workbook.typ",
        "--output",
        pdf_path.name,
        "--strict",
    ], cwd=out)
    if compile_result.returncode != 0:
        raise RuntimeError(f"compilação falhou: {compile_result.stdout[-1200:]} {compile_result.stderr[-1200:]}")
    diagnostics_path = out / f"{pdf_path.stem}.typst-diagnostics.log"
    if diagnostics_path.is_file() and diagnostics_path.stat().st_size == 0:
        diagnostics_path.unlink()

    verify_result = run([
        sys.executable,
        str(VERIFY_PDF),
        pdf_path.name,
        "--profile",
        "text-document",
    ], cwd=out)
    if verify_result.returncode != 0:
        raise RuntimeError(f"verificação falhou: {verify_result.stdout[-1200:]} {verify_result.stderr[-1200:]}")

    pages = pdf_pages(pdf_path)
    expected = profile["expected_pages_with_cover"]
    if pages != expected:
        raise RuntimeError(f"paginação inesperada: {pages}; esperado {expected}")

    manifest = {
        "unit_id": unit_id,
        "produto": batch["produto"],
        "source": item["source"],
        "template_profile": profile_name,
        "material": item["material"],
        "edicao": item["edicao"],
        "pages": pages,
        "audio_included": False,
        "content_validation": validation,
        "status": "pilot-ready",
        "notes": [
            "O campo audios legado do JSON é preservado apenas para compatibilidade histórica.",
            "O workbook produzido por este fluxo é visual e escrito; nenhum áudio é gerado ou incluído.",
        ],
    }
    write_json(out / "build-manifest.json", manifest)
    (out / "README.md").write_text(
        f"# Build {unit_id} — lote PDF-first\n\n"
        "Este diretório foi produzido por `scripts/build_pdf_batch.py` a partir de um manifesto de lote.\n\n"
        f"O resultado contém uma capa editorial parametrizada, seguida pelas páginas pedagógicas do perfil `{profile_name}`. "
        f"O total é de {pages} páginas A4. O lote não inclui áudio.\n\n"
        "A capa recebe do JSON o código, o título, o tipo de material, a edição, a primeira estrutura em hanzi, "
        "o pinyin e o sentido funcional.\n",
        encoding="utf-8",
    )
    package_path = package_unit(out, unit_id)
    return {
        "id": unit_id,
        "status": "PASS",
        "output": str(out),
        "pdf": str(pdf_path),
        "package": str(package_path),
        "pages": pages,
        "template_profile": profile_name,
        "audio_included": False,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Gera um lote de workbooks PDF-first a partir de um manifesto.")
    parser.add_argument("batch_manifest", type=Path)
    parser.add_argument("--output-root", type=Path, default=ROOT / "build" / "pdf-first")
    parser.add_argument("--continue-on-error", action="store_true")
    args = parser.parse_args()

    manifest_path = (ROOT / args.batch_manifest).resolve() if not args.batch_manifest.is_absolute() else args.batch_manifest.resolve()
    batch = read_json(manifest_path)
    registry_path = (ROOT / batch["template_registry"]).resolve()
    registry = read_json(registry_path)
    config_errors = validate_batch_config(batch, registry)
    if config_errors:
        print(json.dumps({"valid": False, "errors": config_errors}, ensure_ascii=False, indent=2), file=sys.stderr)
        return 1
    output_root = (ROOT / args.output_root).resolve() if not args.output_root.is_absolute() else args.output_root.resolve()
    output_root.mkdir(parents=True, exist_ok=True)

    results: list[dict] = []
    for item in batch["units"]:
        try:
            results.append(build_one(batch, item, registry, output_root))
        except Exception as exc:
            failure = {"id": item.get("id"), "status": "FAIL", "error": str(exc)}
            results.append(failure)
            if not args.continue_on_error:
                break

    report = {
        "schema_version": "pdf-first-batch-report-v1",
        "created_at": datetime.now(timezone.utc).isoformat(),
        "manifest": str(manifest_path),
        "output_root": str(output_root),
        "total": len(results),
        "passed": sum(1 for result in results if result["status"] == "PASS"),
        "failed": sum(1 for result in results if result["status"] == "FAIL"),
        "results": results,
    }
    write_json(output_root / "batch-report.json", report)
    lines = [
        f"# Lote PDF-first — {batch['output_label']}",
        "",
        f"Resultado: **{report['passed']} PASS** / **{report['failed']} FAIL**",
        "",
        "| Unidade | Status | Páginas | Perfil | PDF | Pacote |",
        "|---|---|---:|---|---|---|",
    ]
    for result in results:
        lines.append(
            f"| {result['id']} | {result['status']} | {result.get('pages', '—')} | "
            f"{result.get('template_profile', '—')} | {result.get('pdf', '—')} | {result.get('package', '—')} |"
        )
    (output_root / "batch-report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 1 if report["failed"] else 0


if __name__ == "__main__":
    raise SystemExit(main())

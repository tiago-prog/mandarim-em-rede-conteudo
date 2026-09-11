#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import validate_pdf_first_v2

ROOT = Path(__file__).resolve().parents[1]
SCHEMA = ROOT / "schema" / "pdf_first_unit_v1.schema.json"


def validate(path: Path) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    if data.get("schema_version") == "2.0":
        return validate_pdf_first_v2.validate(path)
    errors: list[str] = []
    if data.get("schema_version") != "1.0":
        errors.append("schema_version deve ser '1.0'")
    if not isinstance(data.get("produto"), str) or not data["produto"].strip():
        errors.append("produto deve ser texto não vazio")
    unit = data.get("unidade")
    if not isinstance(unit, dict):
        errors.append("unidade deve ser objeto")
        unit = {}
    required = [
        "codigo", "titulo", "nivel", "status", "objetivo_comunicativo",
        "resultado_minimo", "situacao_principal", "estruturas", "sequencia", "pacotes",
    ]
    for field in required:
        value = unit.get(field)
        if value is None or (isinstance(value, str) and not value.strip()):
            errors.append(f"unidade.{field} é obrigatório")
    if not re.fullmatch(r"[A-Z][0-9]{2}", str(unit.get("codigo", ""))):
        errors.append("unidade.codigo deve seguir o formato A01")
    if unit.get("status") not in {"draft", "revisao_linguistica", "revisao_visual", "piloto", "aprovado", "publicado"}:
        errors.append("unidade.status inválido")
    structures = unit.get("estruturas", [])
    if not isinstance(structures, list) or not 2 <= len(structures) <= 12:
        errors.append("unidade.estruturas deve conter entre 2 e 12 itens")
        structures = structures if isinstance(structures, list) else []
    for index, item in enumerate(structures, 1):
        if not isinstance(item, dict):
            errors.append(f"estruturas[{index}] deve ser objeto")
            continue
        for field in ["funcao", "mandarim", "pinyin", "sentido_funcional", "tipo"]:
            if not isinstance(item.get(field), str) or not item[field].strip():
                errors.append(f"estruturas[{index}].{field} é obrigatório")
        if item.get("tipo") not in {"fixo", "substituivel", "particula", "operador", "base"}:
            errors.append(f"estruturas[{index}].tipo inválido")
    sequence = unit.get("sequencia", [])
    if not isinstance(sequence, list) or len(sequence) < 5:
        errors.append("unidade.sequencia deve conter pelo menos 5 etapas")
    packages = unit.get("pacotes")
    if not isinstance(packages, dict) or not isinstance(packages.get("essencial"), list) or not isinstance(packages.get("extensoes"), dict):
        errors.append("unidade.pacotes deve conter essencial e extensoes")
    warnings: list[str] = []
    if "audios" in unit:
        warnings.append("unidade.audios é histórico e será ignorado no fluxo PDF-first")
    if unit.get("status") in {"aprovado", "publicado"} and warnings:
        warnings.append("unidade aprovada contém campos históricos; confirmar que o pacote final não inclui áudio")
    return {
        "valid": not errors,
        "errors": errors,
        "warnings": warnings,
        "codigo": unit.get("codigo"),
        "status": unit.get("status"),
        "schema": str(SCHEMA),
        "audio_included": False,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Valida uma unidade para o fluxo PDF-first; despacha para o contrato rico quando schema_version é 2.0.")
    parser.add_argument("json_path", type=Path)
    parser.add_argument("--json", action="store_true", dest="as_json")
    args = parser.parse_args()
    try:
        result = validate(args.json_path)
    except Exception as exc:
        result = {"valid": False, "errors": [str(exc)], "warnings": []}
    if args.as_json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        print(f"VALID={result['valid']} codigo={result.get('codigo')} status={result.get('status')}")
        for item in result["errors"]:
            print(f"ERROR: {item}")
        for item in result["warnings"]:
            print(f"WARNING: {item}")
    return 0 if result["valid"] else 1


if __name__ == "__main__":
    raise SystemExit(main())

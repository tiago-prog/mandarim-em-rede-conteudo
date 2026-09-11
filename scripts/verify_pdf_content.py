#!/usr/bin/env python3
"""Portão conteúdo↔PDF.

Confere que o PDF gerado contém o conteúdo da unidade que o originou e que não
contém formas exclusivas de outra unidade. Sem esse portão, um template com
conteúdo fixo passa na conferência de páginas mesmo imprimindo outra unidade.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

from typst_pdf import page_texts

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_LIBRARY = ROOT / "content" / "pdf_first"
NOISE = re.compile(r"[\s\u3000\u3001\u3002\uff0c\uff1f\uff01\uff1b\uff1a\u2026\u201c\u201d.,?!;:]")


def normalize(value: str) -> str:
    return NOISE.sub("", value)


def load_unit(path: Path) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    return data.get("unidade", data)


def printed_forms(unit: dict) -> set[str]:
    """Formas que o workbook obrigatoriamente imprime."""
    forms: set[str] = set()
    for item in unit.get("mapa_decisao", []):
        forms.add(item["mandarim"])
    atividades = unit.get("atividades", {})
    for item in atividades.get("reconhecimento", []):
        forms.add(item["opcao_a"])
        forms.add(item["opcao_b"])
    reorganizacao = atividades.get("reorganizacao")
    if reorganizacao:
        forms.add(reorganizacao["resultado_esperado"])
        for item in reorganizacao.get("reconstrucoes", []):
            forms.add(item["mandarim"])
    if not forms:
        forms = {item["mandarim"] for item in unit.get("estruturas", [])[:4]}
    return {normalize(form) for form in forms if normalize(form)}


def unit_forms(unit: dict) -> set[str]:
    """Todas as formas declaradas pela unidade, impressas ou não."""
    forms = {item["mandarim"] for item in unit.get("estruturas", [])}
    return printed_forms(unit) | {normalize(form) for form in forms if normalize(form)}


def unit_corpus(value: object) -> str:
    """Texto normalizado de todos os campos da unidade, para saber o que lhe pertence."""
    if isinstance(value, str):
        return normalize(value)
    if isinstance(value, dict):
        return "".join(unit_corpus(item) for item in value.values())
    if isinstance(value, list):
        return "".join(unit_corpus(item) for item in value)
    return ""


def unit_tokens(unit: dict) -> set[str]:
    tokens: set[str] = set()
    for item in unit.get("hanzi_alvo", []):
        tokens.add(item["hanzi"])
    for item in unit.get("palavras_chave", []):
        tokens.add(item["hanzi"])
    atividades = unit.get("atividades", {})
    recombinacao = atividades.get("recombinacao")
    if recombinacao:
        for item in recombinacao.get("banco", []):
            tokens.add(item["hanzi"])
    return {normalize(token) for token in tokens if normalize(token)}


def rich_fragments(unit: dict) -> set[str]:
    """Fragmentos editoriais ricos que devem aparecer no workbook."""
    fragments: set[str] = set()
    for key in ("contexto_emocional", "dificuldade_principal", "artefato_pratico"):
        value = unit.get(key)
        if isinstance(value, str) and value.strip():
            compact = normalize(value)
            fragments.add(compact if len(compact) <= 90 else compact[:45])
    criteria = unit.get("criterios_autoavaliacao", [])
    if isinstance(criteria, list):
        for value in criteria:
            if isinstance(value, str) and value.strip():
                compact = normalize(value)
                fragments.add(compact if len(compact) <= 90 else compact[:45])
    return {item for item in fragments if item}


def other_units(source: Path, library: Path, codigo: str) -> list[tuple[str, dict]]:
    units: list[tuple[str, dict]] = []
    for path in sorted(library.glob("*.json")):
        if path.resolve() == source.resolve():
            continue
        data = json.loads(path.read_text(encoding="utf-8"))
        unit = data.get("unidade")
        if not isinstance(unit, dict) or unit.get("codigo") in (None, codigo):
            continue
        units.append((unit["codigo"], unit))
    return units


def verify(pdf: Path, source: Path, library: Path) -> dict:
    unit = load_unit(source)
    text = normalize("".join(page_texts(pdf)))

    required = sorted(printed_forms(unit) | unit_tokens(unit) | rich_fragments(unit))
    missing = [item for item in required if item not in text]

    own = unit_corpus(unit)
    intruders: list[str] = []
    for codigo, other in other_units(source, library, unit.get("codigo", "")):
        exclusive = (unit_forms(other) | unit_tokens(other)) - set(required)
        for item in sorted(exclusive):
            if len(item) >= 2 and item not in own and item in text:
                intruders.append(f"{codigo}: {item}")

    errors: list[str] = []
    if missing:
        errors.append(f"conteúdo da unidade ausente no PDF: {missing}")
    if intruders:
        errors.append(f"conteúdo de outra unidade presente no PDF: {intruders}")
    return {
        "valid": not errors,
        "errors": errors,
        "codigo": unit.get("codigo"),
        "pdf": str(pdf),
        "checked_items": len(required),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Confere que o PDF contém a unidade certa e nenhuma outra.")
    parser.add_argument("pdf", type=Path)
    parser.add_argument("source", type=Path, help="JSON da unidade que originou o PDF")
    parser.add_argument("--library", type=Path, default=DEFAULT_LIBRARY, help="pasta com as demais unidades")
    args = parser.parse_args()

    report = verify(args.pdf, args.source, args.library)
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report["valid"] else 1


if __name__ == "__main__":
    sys.exit(main())

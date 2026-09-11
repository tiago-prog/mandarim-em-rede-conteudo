#!/usr/bin/env python3
"""Valida uma unidade no contrato rico pdf-first-rich-v2.

A validação tem duas camadas. O schema JSON define a forma do arquivo. As regras
editoriais deste módulo garantem que o conteúdo seja internamente coerente, para
que o template Typst não precise conhecer nenhum tópico específico.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import unicodedata
from pathlib import Path

import jsonschema

ROOT = Path(__file__).resolve().parents[1]
SCHEMA = ROOT / "schema" / "pdf_first_unit_v2.schema.json"
CONTENT_PROFILE = "pdf-first-rich-v2"
SEQUENCE = [
    "situar", "observar", "reconhecer", "ler", "recuperar",
    "escrever", "reorganizar", "recombinar", "produzir", "revisar",
]
PACKAGE_CODES = {"W1", "W2", "V1", "X1", "R1", "R2", "R3", "R4", "Q1", "R5"}
TONE_MARKS = {"\u0304", "\u0301", "\u030c", "\u0300"}
NEUTRAL_SYLLABLES = {"ma", "ne", "ba", "de", "le", "ge", "me", "zi", "a"}
HANZI = re.compile(r"[\u4e00-\u9fff]")
BUREAUCRATIC = re.compile(r"\b(observe|identifique|tente|registre|complete|ordene|reconheça|releia|repita)\w*\b", re.IGNORECASE)
SUBJECTIVE_CRITERIA = ("mantenho o sentido", "reconheço a função", "entendo a estrutura")


def strip_punctuation(value: str) -> str:
    return "".join(char for char in value if not unicodedata.category(char).startswith("P") and not char.isspace())


def has_tone_mark(pinyin: str) -> bool:
    decomposed = unicodedata.normalize("NFD", pinyin)
    if any(mark in decomposed for mark in TONE_MARKS):
        return True
    syllables = re.findall(r"[a-zA-Zü]+", pinyin.lower())
    return bool(syllables) and all(syllable in NEUTRAL_SYLLABLES for syllable in syllables)


def schema_errors(data: dict) -> list[str]:
    schema = json.loads(SCHEMA.read_text(encoding="utf-8"))
    validator = jsonschema.Draft202012Validator(schema)
    errors = []
    for error in sorted(validator.iter_errors(data), key=lambda item: list(item.absolute_path)):
        location = ".".join(str(part) for part in error.absolute_path) or "raiz"
        errors.append(f"{location}: {error.message}")
    return errors


def editorial_errors(unit: dict) -> tuple[list[str], list[str]]:
    errors: list[str] = []
    warnings: list[str] = []

    if unit.get("sequencia") != SEQUENCE:
        errors.append("unidade.sequencia deve ser exatamente o método congelado, na ordem definida")

    structures = unit.get("estruturas", [])
    forms = {strip_punctuation(item.get("mandarim", "")) for item in structures if isinstance(item, dict)}
    unit_forms = {form for form in forms if form}
    unit_hanzi = {char for form in forms for char in HANZI.findall(form)}

    for index, item in enumerate(structures, 1):
        if isinstance(item, dict) and not has_tone_mark(str(item.get("pinyin", ""))):
            warnings.append(f"estruturas[{index}].pinyin não tem marca tonal")

    for index, item in enumerate(unit.get("hanzi_alvo", []), 1):
        hanzi = item.get("hanzi", "") if isinstance(item, dict) else ""
        if hanzi and hanzi not in unit_forms and hanzi not in {item.get("hanzi", "") for item in unit.get("palavras_chave", [])}:
            errors.append(f"hanzi_alvo[{index}] ({hanzi}) não aparece integralmente em nenhuma estrutura ou palavra-chave da unidade")

    criteria = unit.get("criterios_autoavaliacao", [])
    if isinstance(criteria, list):
        for index, criterion in enumerate(criteria, 1):
            text = str(criterion).strip()
            if len(text) > 52:
                errors.append(f"criterios_autoavaliacao[{index}] excede 52 caracteres; reescreva para uma linha observável")
            lowered = text.casefold()
            if any(phrase in lowered for phrase in SUBJECTIVE_CRITERIA):
                errors.append(f"criterios_autoavaliacao[{index}] usa formulação subjetiva: {text}")
            if text.count(" e ") > 1 or text.count("/") > 1:
                warnings.append(f"criterios_autoavaliacao[{index}] pode conter mais de uma ação: {text}")

    priority_text = " ".join(
        [str(item) for item in unit.get("preparacao", [])]
        + [str(unit.get("atividades", {}).get("reorganizacao", {}).get("instrucao", ""))]
        + [str(unit.get("atividades", {}).get("recombinacao", {}).get("instrucao", ""))]
        + [str(item.get("instrucao", "")) for item in unit.get("producao", {}).get("cenarios", []) if isinstance(item, dict)]
    )
    bureaucratic = sorted(set(BUREAUCRATIC.findall(priority_text)))
    if len(bureaucratic) >= 3:
        warnings.append("linguagem prioritária ainda contém muitos comandos burocráticos: " + ", ".join(bureaucratic))

    for index, item in enumerate(unit.get("palavras_chave", []), 1):
        if not isinstance(item, dict):
            continue
        hanzi = item.get("hanzi", "")
        if hanzi and not any(hanzi in form for form in unit_forms):
            warnings.append(f"palavras_chave[{index}] ({hanzi}) não aparece em nenhuma estrutura da unidade")
        if not has_tone_mark(str(item.get("pinyin", ""))):
            warnings.append(f"palavras_chave[{index}].pinyin não tem marca tonal")

    for index, item in enumerate(unit.get("mapa_decisao", []), 1):
        form = strip_punctuation(item.get("mandarim", "")) if isinstance(item, dict) else ""
        if form and form not in forms:
            errors.append(f"mapa_decisao[{index}] aponta para uma forma que não existe em estruturas: {item.get('mandarim')}")

    activities = unit.get("atividades", {}) if isinstance(unit.get("atividades"), dict) else {}

    for index, item in enumerate(activities.get("reconhecimento", []), 1):
        if not isinstance(item, dict):
            continue
        for key in ("opcao_a", "opcao_b"):
            form = strip_punctuation(item.get(key, ""))
            if form and form not in forms:
                errors.append(f"atividades.reconhecimento[{index}].{key} não corresponde a uma estrutura da unidade")
        if strip_punctuation(item.get("opcao_a", "")) == strip_punctuation(item.get("opcao_b", "")):
            errors.append(f"atividades.reconhecimento[{index}] tem as duas opções iguais")

    reorganization = activities.get("reorganizacao", {}) if isinstance(activities.get("reorganizacao"), dict) else {}
    blocks = reorganization.get("blocos", [])
    expected = reorganization.get("resultado_esperado", "")
    if isinstance(blocks, list) and expected:
        joined = strip_punctuation("".join(str(block) for block in blocks))
        if sorted(joined) != sorted(strip_punctuation(str(expected))):
            errors.append("atividades.reorganizacao: os blocos não reconstroem o resultado esperado")
        if strip_punctuation(str(expected)) not in forms:
            warnings.append("atividades.reorganizacao.resultado_esperado não é uma estrutura declarada")
    for index, item in enumerate(reorganization.get("reconstrucoes", []), 1):
        form = strip_punctuation(item.get("mandarim", "")) if isinstance(item, dict) else ""
        if form and form not in forms:
            errors.append(f"atividades.reorganizacao.reconstrucoes[{index}] não corresponde a uma estrutura da unidade")

    recombination = activities.get("recombinacao", {}) if isinstance(activities.get("recombinacao"), dict) else {}
    for index, molde in enumerate(recombination.get("moldes", []), 1):
        if "…" not in str(molde):
            warnings.append(f"atividades.recombinacao.moldes[{index}] não marca o slot com …")
    for index, item in enumerate(recombination.get("banco", []), 1):
        hanzi = item.get("hanzi", "") if isinstance(item, dict) else ""
        if hanzi and not any(hanzi in form for form in unit_forms):
            warnings.append(f"atividades.recombinacao.banco[{index}] ({hanzi}) não aparece em nenhuma estrutura")

    scenarios = unit.get("producao", {}).get("cenarios", []) if isinstance(unit.get("producao"), dict) else []
    if scenarios and not any(item.get("apoio") == "com_apoio" for item in scenarios if isinstance(item, dict)):
        warnings.append("producao.cenarios não tem nenhum cenário com apoio")

    packages = unit.get("pacotes", {}).get("essencial", []) if isinstance(unit.get("pacotes"), dict) else []
    unknown = [code for code in packages if code not in PACKAGE_CODES]
    if unknown:
        warnings.append(f"pacotes.essencial usa códigos fora do catálogo de complementos: {', '.join(unknown)}")

    return errors, warnings


def validate(path: Path) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    unit = data.get("unidade", {}) if isinstance(data.get("unidade"), dict) else {}
    errors = schema_errors(data)
    warnings: list[str] = []
    if not errors:
        editorial, warnings = editorial_errors(unit)
        errors.extend(editorial)
    return {
        "valid": not errors,
        "errors": errors,
        "warnings": warnings,
        "codigo": unit.get("codigo"),
        "status": unit.get("status"),
        "content_profile": unit.get("content_profile", CONTENT_PROFILE),
        "schema": str(SCHEMA),
        "audio_included": False,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Valida uma unidade no contrato rico pdf-first-rich-v2.")
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

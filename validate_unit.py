#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

ALLOWED_STATUS = {"draft", "revisao_linguistica", "revisao_visual", "piloto", "aprovado", "publicado"}
ALLOWED_TYPES = {"fixo", "substituivel", "particula", "operador", "base"}
REQUIRED_CORE = {"R1", "R2", "R3", "R4", "V1"}
REQUIRED_SEQUENCES = {"ouvir", "tentar", "consultar", "reconstruir", "recombinar", "transferir"}


def validate(path: Path) -> dict:
    errors: list[str] = []
    warnings: list[str] = []
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        return {"valid": False, "errors": [f"JSON inválido: {exc}"], "warnings": []}

    if data.get("schema_version") != "1.0":
        errors.append("schema_version deve ser '1.0'.")
    if not isinstance(data.get("produto"), str) or not data["produto"].strip():
        errors.append("produto deve ser um texto não vazio.")
    unit = data.get("unidade")
    if not isinstance(unit, dict):
        errors.append("unidade deve ser um objeto.")
        return {"valid": False, "errors": errors, "warnings": warnings}

    for field in ["codigo", "titulo", "nivel", "status", "objetivo_comunicativo", "resultado_minimo", "situacao_principal"]:
        if not isinstance(unit.get(field), str) or not unit[field].strip():
            errors.append(f"unidade.{field} é obrigatório e deve ser texto não vazio.")
    if not re.fullmatch(r"[A-Z][0-9]{2}", str(unit.get("codigo", ""))):
        errors.append("unidade.codigo deve seguir o formato A01.")
    if unit.get("status") not in ALLOWED_STATUS:
        errors.append(f"unidade.status deve ser um de: {', '.join(sorted(ALLOWED_STATUS))}.")

    structures = unit.get("estruturas")
    if not isinstance(structures, list) or not 2 <= len(structures) <= 12:
        errors.append("unidade.estruturas deve conter entre 2 e 12 itens.")
        structures = structures if isinstance(structures, list) else []
    functions = set()
    for i, item in enumerate(structures, 1):
        if not isinstance(item, dict):
            errors.append(f"estruturas[{i}] deve ser um objeto.")
            continue
        for field in ["funcao", "mandarim", "pinyin", "sentido_funcional", "tipo"]:
            if not isinstance(item.get(field), str) or not item[field].strip():
                errors.append(f"estruturas[{i}].{field} é obrigatório.")
        if item.get("tipo") not in ALLOWED_TYPES:
            errors.append(f"estruturas[{i}].tipo inválido: {item.get('tipo')!r}.")
        if item.get("tipo") == "substituivel" and not item.get("slot"):
            errors.append(f"estruturas[{i}] substituível precisa de slot.")
        func = item.get("funcao")
        if func in functions:
            warnings.append(f"função repetida em estruturas: {func}")
        functions.add(func)

    sequence = unit.get("sequencia")
    if not isinstance(sequence, list):
        errors.append("unidade.sequencia deve ser uma lista.")
        sequence = []
    missing_sequence = sorted(REQUIRED_SEQUENCES - set(sequence))
    if missing_sequence:
        errors.append(f"sequência sem etapas essenciais: {', '.join(missing_sequence)}.")

    audios = unit.get("audios")
    if not isinstance(audios, list) or len(audios) < 3:
        errors.append("unidade.audios deve conter pelo menos 3 faixas.")
        audios = audios if isinstance(audios, list) else []
    for i, audio in enumerate(audios, 1):
        for field in ["faixa", "titulo", "objetivo"]:
            if not isinstance(audio, dict) or not isinstance(audio.get(field), str) or not audio[field].strip():
                errors.append(f"audios[{i}].{field} é obrigatório.")

    packages = unit.get("pacotes")
    if not isinstance(packages, dict):
        errors.append("unidade.pacotes deve ser um objeto.")
    else:
        essential = set(packages.get("essencial", []))
        missing_core = sorted(REQUIRED_CORE - essential)
        if missing_core:
            errors.append(f"pacote essencial sem páginas: {', '.join(missing_core)}.")
        extensions = packages.get("extensoes", {})
        if not isinstance(extensions, dict):
            errors.append("pacotes.extensoes deve ser um objeto.")

    if unit.get("status") in {"aprovado", "publicado"} and warnings:
        warnings.append("unidade aprovada contém avisos; revisar antes de publicar.")

    return {"valid": not errors, "errors": errors, "warnings": warnings, "codigo": unit.get("codigo"), "status": unit.get("status")}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("json_path", type=Path)
    parser.add_argument("--json", action="store_true", dest="as_json")
    args = parser.parse_args()
    result = validate(args.json_path)
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
    sys.exit(main())

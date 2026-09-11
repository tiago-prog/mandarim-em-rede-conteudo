#!/usr/bin/env python3
"""Compilação e verificação de PDF sem depender de scripts fora do repositório.

O binário do Typst é resolvido por `TYPST_BIN` ou pelo `typst` do PATH.
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

from pypdf import PdfReader

INSTALL_HINT = (
    "Typst não encontrado. Instale com `cargo install --locked typst-cli`, "
    "baixe o binário em https://github.com/typst/typst/releases "
    "ou aponte a variável TYPST_BIN para o executável."
)


def typst_binary() -> str:
    configured = os.environ.get("TYPST_BIN")
    if configured:
        if not Path(configured).is_file():
            raise FileNotFoundError(f"TYPST_BIN aponta para caminho inexistente: {configured}")
        return configured
    found = shutil.which("typst")
    if found is None:
        raise FileNotFoundError(INSTALL_HINT)
    return found


def compile_pdf(source: Path, output: Path, cwd: Path | None = None) -> str:
    command = [typst_binary(), "compile", str(source), str(output)]
    font_path = os.environ.get("TYPST_FONT_PATH")
    if font_path:
        command.extend(["--font-path", font_path])
    result = subprocess.run(command, cwd=cwd, text=True, capture_output=True, check=False)
    if result.returncode != 0:
        raise RuntimeError(f"compilação Typst falhou: {result.stdout[-1200:]} {result.stderr[-1200:]}")
    return result.stderr.strip()


def page_texts(pdf_path: Path) -> list[str]:
    reader = PdfReader(str(pdf_path))
    return [page.extract_text() or "" for page in reader.pages]


def verify_pdf(pdf_path: Path, expected_pages: int | None = None) -> dict:
    errors: list[str] = []
    texts = page_texts(pdf_path)
    pages = len(texts)
    if pages == 0:
        errors.append("PDF sem páginas")
    if expected_pages is not None and pages != expected_pages:
        errors.append(f"paginação inesperada: {pages}; esperado {expected_pages}")
    empty = [index for index, text in enumerate(texts[1:], start=2) if not text.strip()]
    if empty:
        errors.append(f"páginas sem texto extraível: {empty}")
    return {"valid": not errors, "errors": errors, "pages": pages}


def main() -> int:
    parser = argparse.ArgumentParser(description="Compila ou verifica um PDF do pipeline PDF-first.")
    sub = parser.add_subparsers(dest="command", required=True)
    build = sub.add_parser("compile", help="compila um arquivo Typst")
    build.add_argument("source", type=Path)
    build.add_argument("--output", type=Path, required=True)
    check = sub.add_parser("verify", help="verifica um PDF gerado")
    check.add_argument("pdf", type=Path)
    check.add_argument("--expected-pages", type=int)
    args = parser.parse_args()

    if args.command == "compile":
        warnings = compile_pdf(args.source, args.output)
        print(json.dumps({"valid": True, "output": str(args.output), "warnings": warnings}, ensure_ascii=False, indent=2))
        return 0

    report = verify_pdf(args.pdf, args.expected_pages)
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report["valid"] else 1


if __name__ == "__main__":
    sys.exit(main())

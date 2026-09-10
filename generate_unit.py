#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import zipfile
from pathlib import Path

from validate_unit import validate

ROOT = Path(__file__).resolve().parent
SOURCE_MVP = Path('/home/ubuntu/mvp')
BUILD_ROOT = ROOT / 'build'


def render_audio(unit: dict) -> str:
    title = unit['titulo']
    lines = [f"# Roteiros de áudio — {unit['codigo']}\n", f"## {title}\n", "O áudio vem antes do mapa. As pausas permitem que o estudante tente recuperar e produzir.\n"]
    for audio in unit['audios']:
        lines.append(f"## Faixa {audio['faixa']} — {audio['titulo']}\n")
        lines.append(f"**Objetivo:** {audio['objetivo']}.\n")
        lines.append("**Roteiro:**\n\n")
        if audio['faixa'] == '01':
            lines.append("Apresentar a situação e o diálogo principal sem tradução imediata.\n")
        elif audio['faixa'] == '02':
            lines.append("Fazer perguntas com pausas de 4–5 segundos para a primeira tentativa.\n")
        elif audio['faixa'] == '03':
            lines.append("Repetir as estruturas principais com apoio reduzido.\n")
        elif audio['faixa'] == '04':
            lines.append(f"Produzir em uma situação nova: {unit['situacao_principal']}\n")
        else:
            lines.append(f"Produzir novamente e verificar: {unit['resultado_minimo']}\n")
        lines.append("\n")
    lines.append("## Notas para gravação\n\nManter ritmo claro, pausas intencionais e ausência de tradução durante a primeira exposição.\n")
    return ''.join(lines)


def render_facilitator(unit: dict) -> str:
    rows = ["| Função | Mandarim | Pinyin | Sentido funcional |", "|---|---|---|---|"]
    for item in unit['estruturas']:
        rows.append(f"| {item['funcao']} | {item['mandarim']} | {item['pinyin']} | {item['sentido_funcional']} |")
    return f"""# Guia do facilitador — {unit['codigo']}

## {unit['titulo']}

### Finalidade

{unit['objetivo_comunicativo']}

### Resultado mínimo

{unit['resultado_minimo']}

### Situação principal

{unit['situacao_principal']}

## Sequência de aplicação

1. Ouvir antes da consulta.
2. Fazer uma primeira tentativa.
3. Liberar o mapa completo.
4. Reconstruir com apoio reduzido.
5. Recombinar um elemento.
6. Transferir para uma situação nova.
7. Registrar a independência alcançada.

## Gabarito funcional

{chr(10).join(rows)}

## Observação

O validador confirma a estrutura do pacote, mas a naturalidade do mandarim, a pronúncia, a dificuldade e a adequação pedagógica ainda precisam de revisão humana.
"""


def render_validation(unit: dict, validation: dict) -> str:
    ext = unit['pacotes']['extensoes']
    enabled = [name for name, value in ext.items() if value]
    return f"""# Manifesto de produção — {unit['codigo']}

| Campo | Valor |
|---|---|
| Status | {unit['status']} |
| Pacote essencial | {', '.join(unit['pacotes']['essencial'])} |
| Extensões ativas | {', '.join(enabled) if enabled else 'nenhuma'} |
| Validação estrutural | {'PASS' if validation['valid'] else 'FAIL'} |
| Erros | {len(validation['errors'])} |
| Avisos | {len(validation['warnings'])} |

## Regra de publicação

A compilação bem-sucedida não substitui a revisão linguística, visual e pedagógica. O estado atual deve ser respeitado antes de qualquer publicação.
"""


def main() -> int:
    parser = argparse.ArgumentParser(description='Gera um pacote Mandarim em Rede a partir de JSON.')
    parser.add_argument('json_path', type=Path)
    parser.add_argument('--output-root', type=Path, default=BUILD_ROOT)
    args = parser.parse_args()

    validation = validate(args.json_path)
    if not validation['valid']:
        print(json.dumps(validation, ensure_ascii=False, indent=2))
        return 1

    data = json.loads(args.json_path.read_text(encoding='utf-8'))
    unit = data['unidade']
    code = unit['codigo']
    out = args.output_root / code
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)

    # The v1 workbook uses the approved B01 layout as a stable regression base.
    # Parameterization of all pages is the next generator increment after B01.
    shutil.copy2(SOURCE_MVP / 'main.typ', out / 'main.typ')
    shutil.copy2(SOURCE_MVP / 'report-theme.typ', out / 'report-theme.typ')
    assets = out / 'assets'
    assets.mkdir()
    shutil.copy2(SOURCE_MVP / 'assets/bg-fundo-prime.png', assets / 'bg-fundo-prime.png')

    (out / f'{code}-conteudo.json').write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    (out / f'{code}-roteiros-audio.md').write_text(render_audio(unit), encoding='utf-8')
    (out / f'{code}-guia-facilitador.md').write_text(render_facilitator(unit), encoding='utf-8')
    (out / f'{code}-manifesto.md').write_text(render_validation(unit, validation), encoding='utf-8')
    (out / 'validation.json').write_text(json.dumps(validation, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')

    pdf_path = out / f'{code}-workbook.pdf'
    subprocess.run(['typst', 'compile', '--root', str(out), str(out / 'main.typ'), str(pdf_path)], check=True)
    zip_path = out / f'{code}-pacote.zip'
    with zipfile.ZipFile(zip_path, 'w', compression=zipfile.ZIP_DEFLATED) as zf:
        for file in sorted(out.rglob('*')):
            if file.is_file() and file != zip_path:
                zf.write(file, file.relative_to(out))
    print(json.dumps({
        'codigo': code,
        'status': unit['status'],
        'output': str(out),
        'pdf': str(pdf_path),
        'zip': str(zip_path),
        'validation': validation,
        'note': 'v1 usa o workbook aprovado como base de regressão; parametrização completa do conteúdo visual é a próxima etapa.',
    }, ensure_ascii=False, indent=2))
    return 0


if __name__ == '__main__':
    sys.exit(main())

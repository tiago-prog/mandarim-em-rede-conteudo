#!/usr/bin/env python3
from __future__ import annotations
import json, os, subprocess, sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
BUILD=Path(os.environ.get('BUILD_ROOT', '/tmp/mandarim-impl-rich10'))
units=[]
for source in sorted((ROOT/'content/pdf_first').glob('B[0-9][0-9]-*.json')):
    data=json.loads(source.read_text(encoding='utf-8')); u=data['unidade']
    units.append((source,u))
errors=[]
for source,u in units:
    criteria=u['criterios_autoavaliacao']
    if not (4 <= len(criteria) <= 5): errors.append(f'{u["codigo"]}: critérios fora de 4–5')
    if any(len(x)>52 for x in criteria): errors.append(f'{u["codigo"]}: critério acima de 52 caracteres')
    if any(not x.strip() for x in criteria): errors.append(f'{u["codigo"]}: critério vazio')
    pdf=BUILD/u['codigo']/f'{u["codigo"]}-workbook.pdf'
    if not pdf.exists(): errors.append(f'{u["codigo"]}: PDF ausente') ; continue
    result=subprocess.run(['pdftotext','-layout',str(pdf),'-'],capture_output=True,text=True,check=True)
    text=result.stdout
    required=['ESCRITA DE HANZI','Fale primeiro. Escreva depois.','ARTEFATO PRÁTICO','PRÓXIMA RECUPERAÇÃO']
    for token in required:
        if token not in text: errors.append(f'{u["codigo"]}: label ausente: {token}')
    if 'banco completo' in text.lower(): errors.append(f'{u["codigo"]}: texto proibido de banco completo detectado')
    if text.count('Fale primeiro. Escreva depois.') < 2: errors.append(f'{u["codigo"]}: cue oral não aparece em recuperação e produção')
    if 'gabarito' in text.lower(): errors.append(f'{u["codigo"]}: possível gabarito na saída')
print(json.dumps({'units':len(units),'errors':errors,'valid':not errors},ensure_ascii=False,indent=2))
sys.exit(1 if errors else 0)

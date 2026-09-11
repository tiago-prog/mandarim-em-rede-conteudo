#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, re, sys
from pathlib import Path
import jsonschema

ROOT = Path(__file__).resolve().parents[1]
UNIT_RE = re.compile(r'^[A-Z][0-9]{2}$')

def load(path): return json.loads(Path(path).read_text(encoding='utf-8'))
def schema_validate(data, schema_path):
    schema = load(schema_path)
    return [e.message for e in jsonschema.Draft202012Validator(schema).iter_errors(data)]

def validate_batch(path):
    data = load(path); errors = schema_validate(data, ROOT/'schema/pdf_first_rich_batch_v2.schema.json')
    seen = set()
    for item in data.get('units', []):
        if item.get('id') in seen: errors.append(f"id repetido no lote: {item.get('id')}")
        seen.add(item.get('id'))
        source = ROOT/item.get('source','')
        if not source.is_file(): errors.append(f"fonte inexistente: {item.get('source')}"); continue
        unit = load(source).get('unidade', {})
        if unit.get('content_profile') != data.get('content_profile'): errors.append(f"{item.get('id')}: perfil de conteúdo incompatível")
        if unit.get('codigo') != item.get('id'): errors.append(f"{item.get('id')}: id do lote difere de unidade.codigo")
        if unit.get('colecao') != data.get('colecao'): errors.append(f"{item.get('id')}: coleção incompatível")
    policy = data.get('expected_pages_policy')
    if policy == 'range' and data.get('min_pages', 0) > data.get('max_pages', 0): errors.append('min_pages não pode ser maior que max_pages')
    return errors

def validate_collection(path):
    data = load(path); errors = schema_validate(data, ROOT/'schema/collection_map_v1.schema.json')
    units = data.get('unidades', []); codes = {u.get('codigo') for u in units}; orders = []
    for u in units:
        orders.append(u.get('ordem'))
        if u.get('ordem') != len(orders): errors.append('ordem das unidades deve ser contínua começando em 1')
        for relation in ('pre_requisitos','prepara'):
            for code in u.get(relation, []):
                if code not in codes and code not in {x.get('codigo') for x in units}: errors.append(f"{u.get('codigo')}: relação {relation} aponta para {code} inexistente")
        if u.get('codigo') in u.get('pre_requisitos', []): errors.append(f"{u.get('codigo')}: não pode ser pré-requisito de si mesma")
    if len(orders) != len(set(orders)): errors.append('ordens repetidas no mapa da coleção')
    return errors

def validate_vocab(path):
    data = load(path); errors = schema_validate(data, ROOT/'schema/cumulative_vocabulary_v1.schema.json')
    seen = set()
    for e in data.get('entradas', []):
        key = (e.get('hanzi'), e.get('pinyin'))
        if key in seen: errors.append(f"entrada lexical repetida: {e.get('hanzi')} / {e.get('pinyin')}")
        seen.add(key)
        if e.get('primeira_unidade') in e.get('reciclar_em', []): errors.append(f"{e.get('hanzi')}: primeira unidade não pode ser reciclagem")
    return errors

def main():
    p = argparse.ArgumentParser()
    p.add_argument('kind', choices=['batch','collection','vocab'])
    p.add_argument('path', type=Path)
    a = p.parse_args()
    fn = {'batch': validate_batch, 'collection': validate_collection, 'vocab': validate_vocab}[a.kind]
    errors = fn(a.path)
    print(json.dumps({'valid': not errors, 'errors': errors, 'kind': a.kind, 'path': str(a.path)}, ensure_ascii=False, indent=2))
    return 1 if errors else 0
if __name__ == '__main__': raise SystemExit(main())

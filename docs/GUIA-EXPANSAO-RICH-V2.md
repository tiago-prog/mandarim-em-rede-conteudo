# Guia de expansão `pdf-first-rich-v2`

## Contratos ativos

O conteúdo de uma unidade usa `schema/pdf_first_unit_v2.schema.json`. Os lotes rich usam `schema/pdf_first_rich_batch_v2.schema.json`. A progressão da coleção usa `schema/collection_map_v1.schema.json`. O vocabulário cumulativo usa `schema/cumulative_vocabulary_v1.schema.json`.

O contrato v1 continua disponível para regressão e unidades históricas. Novas unidades devem usar `schema_version = "2.0"` e `content_profile = "pdf-first-rich-v2"`.

## Fluxo recomendado

```text
unidade JSON
→ validate_pdf_first_v2.py
→ matriz de coleção
→ vocabulário cumulativo
→ manifesto rich batch v2
→ validate_rich_contracts.py
→ build_pdf_batch.py
→ portão conteúdo↔PDF
→ revisão linguística
→ revisão pedagógica
→ revisão visual
```

## Comandos

Validar uma unidade:

```bash
python3 scripts/validate_pdf_first_v2.py \
  content/pdf_first/B02-perguntar-responder-e-devolver.json --json
```

Validar lote, coleção e vocabulário:

```bash
python3 scripts/validate_rich_contracts.py batch \
  content/pdf_first/b-family_rich_v2_batch.json

python3 scripts/validate_rich_contracts.py collection \
  content/catalogo/colecao_01_matriz.json

python3 scripts/validate_rich_contracts.py vocab \
  content/catalogo/vocabulario_cumulativo.json
```

Gerar um lote rich:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/b-family_rich_v2_batch.json \
  --output-root build/pdf-first-rich-v2
```

## Política de páginas

O manifesto rich v2 declara `expected_pages_policy`:

- `fixed`: exige exatamente `expected_pages`;
- `range`: aceita páginas entre `min_pages` e `max_pages`;
- `adaptive`: verifica que o PDF possui páginas e não contém páginas vazias, sem impor quantidade fixa.

O uso de `adaptive` não substitui revisão visual. Ele serve para unidades cuja densidade editorial legitimamente varia.

## Regras de escala

Uma unidade só deve entrar em um lote depois de passar pela validação individual. Um lote só deve ser produzido depois que a matriz de coleção e o índice lexical forem válidos.

O teste de quantidade deve incluir unidades semanticamente diferentes. Copiar a mesma unidade e trocar apenas o código mede apenas a infraestrutura, não a qualidade editorial.

## Conteúdo lexical

Cada `hanzi_alvo` deve aparecer integralmente em uma estrutura ou palavra-chave autorizada. Interseção por caractere isolado não é suficiente.

A unidade deve manter coerência entre hanzi, pinyin, sentido e função. O validador automático detecta forma, cardinalidade e relações básicas; a aprovação linguística permanece humana.

## Overflow

Textos longos podem gerar uma página adicional. Antes de aprovar uma unidade, testar títulos, instruções, critérios e situações próximas aos limites editoriais.

Não truncar texto automaticamente. Se o conteúdo ultrapassar a capacidade do layout, escolher entre reduzir a redação, dividir a unidade ou adotar política de páginas adaptativa.

## Compatibilidade

O builder mantém o fluxo v1 e despacha unidades rich v2 pelo `schema_version`. O template e os assets continuam registrados em `templates/registry.json`.

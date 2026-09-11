# Pipeline PDF-first — Mandarim em Rede

Este repositório transforma unidades de conteúdo JSON em workbooks visuais e escritos de mandarim. O fluxo ativo usa JSON, schemas, templates Typst, renderização de capa, verificação de PDF e empacotamento ZIP.

## Organização do repositório

```text
mandarim-em-rede-conteudo/
├── content/                  # conteúdo ativo em JSON e Markdown
│   └── pdf_first/            # manifestos e unidades do fluxo PDF-first
├── templates/                # templates ativos e registro de perfis
│   ├── b01/                  # template específico validado do B01
│   └── b-family/             # template parametrizado da família B
├── schema/                   # contratos JSON do fluxo ativo
├── scripts/                  # validação, capa e geração de lotes
├── build/                    # builds reproduzíveis e saídas de produção
├── docs/                     # guias, estratégia e roadmap técnico
├── references/               # materiais de consulta e análises
│   ├── material/             # PDFs, SVGs e outras referências externas
│   └── repository-notes/     # análises e revisões do projeto
├── archive/                  # arquivos históricos fora do fluxo ativo
│   ├── legacy-content/       # conteúdo da arquitetura anterior
│   ├── audio-scripts/        # roteiros de áudio históricos
│   ├── build-legacy/         # builds antigos
│   ├── prototypes/           # protótipos e auditorias anteriores
│   └── snapshots/            # cópias compactadas e snapshots
├── requirements.txt          # dependências Python do pipeline
├── generate_unit.py          # gerador legado mantido para regressão
└── validate_unit.py          # validador legado mantido para regressão
```

## Fluxo ativo PDF-first

Valide uma unidade:

```bash
python3 scripts/validate_pdf_first.py \
  content/pdf_first/B02-perguntar-responder-e-devolver.json \
  --json
```

Gere o piloto da família B:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/b-family_pilot_batch.json \
  --output-root build/pdf-first
```

Gere o lote atual da coleção:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/colecao_01_batch.json \
  --output-root build/pdf-first
```

O pipeline valida o JSON, localiza o perfil em `templates/registry.json`, gera a capa, compila o Typst, verifica o PDF, confere a paginação e cria o pacote ZIP.

## Templates ativos

O perfil `b01-cumprimentos-v2` usa `templates/b01/B01-workbook.typ` e preserva o protótipo específico do B01.

O perfil `b-family-workbook-v1` usa `templates/b-family/B-family-workbook.typ` e foi validado com o B02. Ele gera uma capa e dez páginas pedagógicas, totalizando 11 páginas A4.

Um template novo deve ser registrado antes de aparecer em um manifesto de lote. O layout de uma unidade não deve ser aplicado automaticamente a outro tópico sem compilação, verificação e revisão visual próprias.

## Referências e arquivo histórico

Materiais externos e análises ficam em `references/`. O PDF lexical enviado como referência está em `references/material/`, e os achados da análise estão em `references/repository-notes/`.

Arquivos antigos permanecem em `archive/`. Eles são preservados para rastreabilidade e regressão, mas não fazem parte do fluxo PDF-first atual. Os roteiros em `archive/audio-scripts/` são históricos; o produto atual é visual e escrito e não inclui áudio.

## Validação editorial

A compilação do PDF não equivale à aprovação linguística ou pedagógica. A unidade deve passar por revisão linguística, revisão visual e teste de uso antes da publicação.

## Estado atual

B01 possui um template específico validado. B02 possui um piloto no template parametrizado da família B. B03 e B04 ainda precisam de adaptação editorial e validação próprias antes da produção em massa.

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

O pipeline valida o JSON, localiza o perfil em `templates/registry.json`, gera a capa, compila o Typst, verifica o PDF, confere a paginação, aplica o portão conteúdo↔PDF e cria o pacote ZIP.

O build precisa do Typst no PATH ou da variável `TYPST_BIN` apontando para o executável, além das dependências de `requirements.txt`. Nenhum script fora do repositório é necessário.

## Contrato de conteúdo

Unidades novas usam o contrato rico `pdf-first-rich-v2` (`schema/pdf_first_unit_v2.schema.json`), em que todo o conteúdo pedagógico vem do JSON: mapa de decisão, hanzi-alvo, banco de palavras, atividades de reconhecimento, reorganização e recombinação, cenários de produção e critérios de autoavaliação. O prompt de geração correspondente está em `docs/prompt_unidade_rica_v2.md`.

Unidades antigas continuam válidas no contrato `1.0`. O validador decide o contrato pelo campo `schema_version`:

```bash
python3 scripts/validate_pdf_first.py content/pdf_first/B03-identificar-pessoas-e-objetos.json --json
```

Além do schema, o validador v2 confere a coerência entre conteúdo e atividades: hanzi-alvo e palavras que não aparecem nas estruturas, opções de reconhecimento inventadas, blocos que não reconstroem o resultado esperado e pinyin sem marca tonal.

## Portão conteúdo↔PDF

Paginação correta não prova conteúdo correto: um template com frases fixas gera 11 páginas válidas imprimindo outra unidade. O portão extrai o texto do PDF e reprova quando falta conteúdo da unidade ou quando aparece uma forma exclusiva de outra unidade.

```bash
python3 scripts/verify_pdf_content.py \
  build/pdf-first/B03/B03-workbook.pdf \
  content/pdf_first/B03-identificar-pessoas-e-objetos.json
```

## Templates ativos

O perfil `b01-cumprimentos-v2` usa `templates/b01/B01-workbook.typ` e preserva o protótipo específico do B01.

O perfil `b-family-workbook-v1` usa `templates/b-family/B-family-workbook.typ` e foi validado com o B02 e o B03. Ele gera uma capa e dez páginas pedagógicas, totalizando 11 páginas A4. O template não contém hanzi, frases nem cenários fixos: tudo vem do JSON da unidade.

Um template novo deve ser registrado antes de aparecer em um manifesto de lote. O layout de uma unidade não deve ser aplicado automaticamente a outro tópico sem compilação, verificação e revisão visual próprias.

## Referências e arquivo histórico

Materiais externos e análises ficam em `references/`. O PDF lexical enviado como referência está em `references/material/`, e os achados da análise estão em `references/repository-notes/`.

Arquivos antigos permanecem em `archive/`. Eles são preservados para rastreabilidade e regressão, mas não fazem parte do fluxo PDF-first atual. Os roteiros em `archive/audio-scripts/` são históricos; o produto atual é visual e escrito e não inclui áudio.

## Validação editorial

A compilação do PDF não equivale à aprovação linguística ou pedagógica. A unidade deve passar por revisão linguística, revisão visual e teste de uso antes da publicação.

## Estado atual

B01 possui um template específico validado. B02 e B03 estão migrados para o contrato rico e passam no template parametrizado da família B com o portão conteúdo↔PDF. B04 ainda precisa de migração editorial e validação própria antes da produção em massa.

O conteúdo em mandarim das unidades migradas continua marcado como `draft`: a revisão linguística humana é obrigatória antes da publicação.

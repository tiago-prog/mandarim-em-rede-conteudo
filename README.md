# Pipeline v1 — Mandarim em Rede

Este diretório transforma uma unidade JSON aprovada em um pacote visual e escrito distribuível. A unidade JSON é a fonte de conteúdo; o tema Typst controla a tipografia e o layout; o gerador cria workbook, complementos, guia, manifesto e ZIP.

Para começar, consulte o [Guia de produção em massa](docs/guia_producao_pdf_em_massa.md) e o [Prompt para gerar JSONs com IA](docs/prompt_para_gerar_json_pdf_first.md). As dependências Python estão em `requirements.txt`.

## Estrutura

```text
mvp_pipeline/
├── content/                 # unidades JSON
├── docs/                    # estratégia e roteiro-mestre do produto
├── audio_scripts/           # roteiros de áudio por tópico
├── schema/                  # contrato de dados
├── templates/               # futuras extensões de templates
├── prototypes/              # workbooks Typst e PDFs de validação
├── scripts/                 # capa parametrizada e geração em lote
├── content/pdf_first/       # manifestos de lotes PDF-first
├── requirements.txt         # dependências Python do fluxo PDF-first
├── build/                   # pacotes gerados
├── validate_unit.py         # validação antes da compilação
└── generate_unit.py         # geração e empacotamento
```

## Gerar uma unidade legada

```bash
python3 generate_unit.py content/B01-iniciar-interacao.json
```

O comando antigo continua disponível para regressão e para unidades ainda ligadas ao schema v1. O resultado aparece em `build/B01/`. Ele não é o fluxo recomendado para a nova coleção PDF-first porque ainda preserva a arquitetura histórica de áudio e usa o workbook B01 como base fixa.

## Gerar um lote PDF-first

O fluxo recomendado para produção em massa usa um manifesto de lote e um registro de perfis de template:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/colecao_01_batch.json \
  --output-root build/pdf-first
```

Para cada unidade, o script valida o JSON, cria a capa a partir dos campos do conteúdo, copia o perfil Typst correto, compila o workbook, executa a verificação determinística, confirma o número esperado de páginas e gera um ZIP distribuível. O lote atual produz o B01 com **13 páginas físicas: uma capa e doze páginas pedagógicas**.

O comando aceita `--continue-on-error` quando for necessário processar uma coleção inteira e registrar falhas sem interromper os demais itens. O relatório consolidado aparece em `build/pdf-first/batch-report.json` e `build/pdf-first/batch-report.md`.

## Roteiros de áudio

Os roteiros B01–B04 ficam em `audio_scripts/` como arquivo histórico para uma futura edição ou produção externa. O produto atual não inclui áudio. A oferta é totalmente visual e escrita, com hanzi, pinyin, palavras, mapas, recuperação, escrita e produção guiada.

## Validar sem gerar

```bash
python3 validate_unit.py content/B01-iniciar-interacao.json --json
```

## Estados editoriais

Uma unidade deve passar por `draft`, `revisao_linguistica`, `revisao_visual`, `piloto`, `aprovado` e `publicado`. O gerador pode compilar uma unidade em revisão, mas o manifesto registra o estado para evitar que um rascunho seja confundido com produto final.

## Regra de aprovação

O pipeline valida campos, tipos, pacotes, sequência e, quando presentes, referências históricas de áudio. No fluxo PDF-first, o áudio não é gerado nem incluído. O pipeline não substitui a revisão linguística do mandarim nem a decisão pedagógica. Uma unidade só deve ser publicada depois de revisão humana.

## Escopo seguro da v1

A v1 valida o JSON, registra o estado editorial, gera o guia, o manifesto e recompila o workbook aprovado da B01 como caso de regressão. O fluxo PDF-first v2 adiciona capa parametrizada, registro de templates e geração em lote. B02–B04 ainda precisam de perfis Typst próprios; o sistema não deve aplicar o layout B01 a conteúdos diferentes apenas para produzir arquivos rapidamente.

## Roteiro-mestre atual

O catálogo e a arquitetura vigentes estão documentados em `docs/roteiro_mestre_produto_visual_mandarim_em_rede.md`. O plano completo prevê 24 tópicos em quatro coleções. A primeira coleção comercial terá oito tópicos, começando por fundamentos, aeroporto, hotel, transporte e restaurante.

## Estado atual do protótipo B01

O workbook B01 de 12 páginas está implementado em `prototypes/B01-pdf-first/`. O PDF passou por compilação estrita, verificação de estrutura, inspeção visual completa e teste de conteúdo denso. As correções funcionais encontradas na auditoria foram aplicadas e registradas em `auditoria_estresse_B01.md`.

## Próxima evolução

A próxima etapa é testar o B01 com um aluno real e, em seguida, criar um perfil de template por família de tópico. A coleção só deve ser liberada em massa quando cada perfil tiver sido compilado, verificado e revisado visualmente pelo menos uma vez.

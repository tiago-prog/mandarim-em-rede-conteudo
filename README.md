# Pipeline v1 — Mandarim em Rede

Este diretório transforma uma unidade JSON aprovada em um pacote visual e escrito distribuível. A unidade JSON é a fonte de conteúdo; o tema Typst controla a tipografia e o layout; o gerador cria workbook, complementos, guia, manifesto e ZIP.

## Estrutura

```text
mvp_pipeline/
├── content/                 # unidades JSON
├── docs/                    # estratégia e roteiro-mestre do produto
├── audio_scripts/           # roteiros de áudio por tópico
├── schema/                  # contrato de dados
├── templates/               # futuras extensões de templates
├── prototypes/              # workbooks Typst e PDFs de validação
├── build/                   # pacotes gerados
├── validate_unit.py         # validação antes da compilação
└── generate_unit.py         # geração e empacotamento
```

## Gerar uma unidade

```bash
python3 generate_unit.py content/B01-iniciar-interacao.json
```

O resultado aparece em `build/B01/` e inclui o PDF do workbook, o guia, uma cópia do JSON e um ZIP da unidade. Os roteiros de áudio podem ser mantidos separadamente como material opcional.

## Roteiros de áudio

Os roteiros B01–B04 ficam em `audio_scripts/` como arquivo histórico para uma futura edição ou produção externa. O produto atual não inclui áudio. A oferta é totalmente visual e escrita, com hanzi, pinyin, palavras, mapas, recuperação, escrita e produção guiada.

## Validar sem gerar

```bash
python3 validate_unit.py content/B01-iniciar-interacao.json --json
```

## Estados editoriais

Uma unidade deve passar por `draft`, `revisao_linguistica`, `revisao_visual`, `piloto`, `aprovado` e `publicado`. O gerador pode compilar uma unidade em revisão, mas o manifesto registra o estado para evitar que um rascunho seja confundido com produto final.

## Regra de aprovação

O pipeline valida campos, tipos, pacotes, sequência e, quando presentes, referências de áudio. Ele não substitui a revisão linguística do mandarim nem a decisão pedagógica. Uma unidade só deve ser publicada depois de revisão humana.

## Escopo seguro da v1

A v1 valida o JSON, registra o estado editorial, gera o guia, o manifesto e recompila o workbook aprovado da B01 como caso de regressão. Os roteiros de áudio são arquivos de referência e não bloqueiam o produto PDF-first. O pipeline ainda não substitui automaticamente todos os textos do workbook pelas estruturas de uma nova unidade. Isso é intencional: evita que B02–B04 sejam produzidas com um layout correto, mas conteúdo visual incorreto.

## Roteiro-mestre atual

O catálogo e a arquitetura vigentes estão documentados em `docs/roteiro_mestre_produto_visual_mandarim_em_rede.md`. O plano completo prevê 24 tópicos em quatro coleções. A primeira coleção comercial terá oito tópicos, começando por fundamentos, aeroporto, hotel, transporte e restaurante.

## Estado atual do protótipo B01

O workbook B01 de 12 páginas está implementado em `prototypes/B01-pdf-first/`. O PDF passou por compilação estrita, verificação de estrutura, inspeção visual completa e teste de conteúdo denso. As correções funcionais encontradas na auditoria foram aplicadas e registradas em `auditoria_estresse_B01.md`.

## Próxima evolução

A próxima etapa é testar o B01 com um aluno real. Se o piloto confirmar a compreensão das instruções, a arquitetura poderá ser parametrizada e replicada na primeira coleção de oito tópicos.

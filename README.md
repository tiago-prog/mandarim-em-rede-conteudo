# Pipeline v1 — Mandarim em Rede

Este diretório transforma uma unidade JSON aprovada em um pacote distribuível. A unidade JSON é a fonte de conteúdo; o tema Typst controla a tipografia e o layout; o gerador cria workbook, roteiros, guia, manifesto e ZIP.

## Estrutura

```text
mvp_pipeline/
├── content/                 # unidades JSON
├── schema/                  # contrato de dados
├── templates/               # futuras extensões de templates
├── build/                   # pacotes gerados
├── validate_unit.py         # validação antes da compilação
└── generate_unit.py         # geração e empacotamento
```

## Gerar uma unidade

```bash
python3 generate_unit.py content/B01-iniciar-interacao.json
```

O resultado aparece em `build/B01/` e inclui o PDF do workbook, os roteiros, o guia, uma cópia do JSON e um ZIP da unidade.

## Validar sem gerar

```bash
python3 validate_unit.py content/B01-iniciar-interacao.json --json
```

## Estados editoriais

Uma unidade deve passar por `draft`, `revisao_linguistica`, `revisao_visual`, `piloto`, `aprovado` e `publicado`. O gerador pode compilar uma unidade em revisão, mas o manifesto registra o estado para evitar que um rascunho seja confundido com produto final.

## Regra de aprovação

O pipeline valida campos, tipos, pacotes, sequência e áudios. Ele não substitui a revisão linguística do mandarim nem a decisão pedagógica. Uma unidade só deve ser publicada depois de revisão humana.

## Escopo seguro da v1

A v1 já valida o JSON, registra o estado editorial, gera os roteiros, o guia, o manifesto e recompila o workbook aprovado da B01 como caso de regressão. Ela ainda não substitui automaticamente todos os textos do workbook pelas estruturas de uma nova unidade. Isso é intencional: evita que B02–B04 sejam produzidas com um layout correto, mas conteúdo visual incorreto.

## Próxima evolução

A próxima implementação deve separar o workbook em templates de página e parametrizar título, objetivo, estruturas, mapa lacunado, situação de transferência e autoavaliação. Depois da validação desse template parametrizado com B02–B04, os complementos P1, W1, W2, X1, S1, Q1, N1 e R5 podem ser ativados no campo `pacotes.extensoes` e passar a gerar páginas adicionais.

# Organização do repositório

## Objetivo

O repositório foi separado por função para evitar que referências, protótipos antigos e conteúdo ativo sejam confundidos durante a produção.

## Áreas principais

| Área | Uso |
|---|---|
| `content/` | Conteúdo ativo dos módulos e manifestos PDF-first |
| `templates/` | Templates Typst ativos e registro de perfis |
| `schema/` | Contratos JSON ativos |
| `scripts/` | Geração, validação e renderização do fluxo atual |
| `build/` | Saídas reproduzíveis do pipeline |
| `docs/` | Guias, estratégia e documentação de produção |
| `references/` | Materiais de referência e análises do projeto |
| `archive/` | Conteúdo antigo, áudio histórico, protótipos e snapshots |

## Referências

Materiais enviados ou usados como inspiração ficam em `references/material/`. As análises, revisões e achados ficam em `references/repository-notes/`. Esses arquivos orientam decisões, mas não são entradas automáticas do gerador.

## Arquivo histórico

A pasta `archive/` preserva materiais fora do fluxo atual:

- `archive/legacy-content/`: arquivos da arquitetura anterior;
- `archive/audio-scripts/`: roteiros de áudio históricos;
- `archive/build-legacy/`: build antigo do B01;
- `archive/prototypes/`: protótipos e auditorias anteriores;
- `archive/snapshots/`: cópias compactadas do repositório.

## Verificações após a reorganização

O registry de templates foi atualizado para usar `templates/b01/B01-workbook.typ`. O build B01 continuou funcionando com 13 páginas, e o build B02 continuou funcionando com 11 páginas. Os manifests e assets registrados também foram verificados quanto à existência dos caminhos.

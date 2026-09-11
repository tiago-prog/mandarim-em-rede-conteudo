# Conteúdo planejado — B01 a B04

Este diretório reúne a primeira coleção de quatro tópicos do Mandarim em Rede. Cada tópico possui duas fontes:

- um Markdown pedagógico, com o conteúdo previsto para os PDFs;
- um JSON estrutural, compatível com o validador do pipeline.

## Ordem da coleção

| Ordem | Código | Tópico | Markdown | JSON |
|---:|---|---|---|---|
| 1 | B01 | Cumprimentos em contexto | `markdown/B01-cumprimentos-em-contexto.md` | `B01-cumprimentos-em-contexto.json` |
| 2 | B02 | Perguntar, responder e devolver | `markdown/B02-perguntar-responder-e-devolver.md` | `B02-perguntar-responder-e-devolver.json` |
| 3 | B03 | Identificar pessoas e objetos | `markdown/B03-identificar-pessoas-e-objetos.md` | `B03-identificar-pessoas-e-objetos.json` |
| 4 | B04 | Posse e especificação | `markdown/B04-posse-e-especificacao.md` | `B04-posse-e-especificacao.json` |

## Estrutura prevista em cada Markdown

Cada arquivo descreve o objetivo comunicativo, o resultado mínimo, a situação principal, as estruturas linguísticas, o conteúdo da arquitetura anterior e os complementos. Esses conteúdos estão em migração para o novo modelo de dez páginas visuais por tópico, com hanzi, palavras, leitura, escrita, recombinação e produção. Os roteiros de áudio ficam arquivados e não fazem parte da oferta atual.

## Estado editorial

Os quatro JSONs estão em `revisao_linguistica`. Isso significa que a arquitetura e o conteúdo de trabalho estão definidos, mas o mandarim ainda deve passar por revisão humana antes da renderização final.

O gerador atual consegue validar a estrutura JSON. A substituição automática de todo o conteúdo do workbook ainda não deve ser feita sem templates de página parametrizados e sem revisão linguística concluída.

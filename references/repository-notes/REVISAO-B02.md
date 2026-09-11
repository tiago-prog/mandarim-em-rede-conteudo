# Revisão do B02 — Perguntar, responder e devolver

## Problemas encontrados

A revisão do PDF anterior identificou três divergências principais. O quadro **Banco de palavras** mostrava chamadas Typst literais em vez das oito entradas lexicais. O **Mapa de decisão** apontava a terceira estrutura do JSON para “devolver a pergunta”, embora a estrutura correta fosse `你呢？`, a sétima entrada. A atividade de reconhecimento também misturava estruturas de pergunta, resposta e devolução de forma pouco coerente com o objetivo do módulo.

## Correções aplicadas

O template `templates/b-family/B-family-workbook.typ` foi corrigido para renderizar de fato as oito entradas lexicais: `我`, `是`, `学生`, `老师`, `吗`, `呢`, `好` e `忙`, cada uma com pinyin, sentido e uso.

O mapa de decisão agora usa `你呢？` para a função “devolver a pergunta”. A atividade de reconhecimento passou a usar a estrutura correta de resposta negativa como alternativa de contraste e a estrutura `你呢？` como forma de devolução.

Também foram incluídas referências às estruturas quinta, sexta e sétima para evitar que o template fique limitado às quatro primeiras entradas do JSON.

## Validação final

| Verificação | Resultado |
|---|---|
| Build PDF-first do B02 | PASS |
| Paginação | 11 páginas A4 |
| Verificador determinístico | `VERIFY PASS`, 6 pass, 0 warn, 0 fail |
| Banco de palavras | Renderizado corretamente |
| Mapa de decisão | `Perguntar → 你是学生吗？`; `Responder → 我是学生。`; `Devolver → 你呢？` |
| Texto literal de código | Não encontrado na extração final |
| Inspeção visual da página lexical | Aprovada; sem transbordamento |
| Pacote ZIP | Regerado e persistido |

O PDF corrigido está em `build/pdf-first/B02-family-pilot/`. A revisão deixa o B02 tecnicamente consistente com seu JSON atual, embora a próxima evolução ainda deva mover o banco lexical e as atividades fixas para campos estruturados do conteúdo.

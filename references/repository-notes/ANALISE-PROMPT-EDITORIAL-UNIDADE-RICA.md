# Análise do prompt editorial de unidade rica

## Origem

Arquivo recebido em 11 de setembro de 2026 e preservado em `references/material/prompt-editorial-unidade-rica-v2.txt`.

## O que o prompt acrescenta

O prompt exige de 6 a 10 estruturas e introduz campos editoriais importantes: `contexto_emocional`, `dificuldade_principal`, `hanzi_alvo`, `palavras_chave`, `artefato_pratico` e `criterios_autoavaliacao`. Ele também torna obrigatória uma sequência pedagógica de dez etapas e explicita critérios de validade, adequação ao iniciante e mensurabilidade do resultado.

Esses campos são coerentes com a evolução planejada dos templates, porque permitem gerar páginas de hanzi, banco lexical, produção prática e autoavaliação com dados reais do módulo, em vez de manter esses elementos fixos no Typst.

## Implementação realizada

A especificação foi implementada como contrato `pdf-first-rich-v2` com `schema_version = "2.0"`. O perfil é identificado pelo campo `unidade.content_profile = "pdf-first-rich-v2"`.

Foram criados:

- `schema/pdf_first_unit_v2.schema.json`;
- `scripts/validate_pdf_first_v2.py`;
- `docs/prompt_para_gerar_json_pdf_first_v2.md`.

O B02 foi migrado para o perfil rico. O template da família B agora consome as palavras-chave, os hanzi-alvo, o contexto emocional, a dificuldade principal e os critérios de autoavaliação.

## Incompatibilidades e decisão

| Ponto | Prompt recebido | Implementação |
|---|---|---|
| Quantidade de estruturas | 6–10 | Obrigatória no schema v2 |
| Campos de riqueza | Obrigatórios | Implementados no schema v2 |
| Propriedades extras da unidade | Várias | Permitidas somente no contrato rico definido |
| `audios` | Proibido | Rejeitado no validador v2 |
| Categorias lexicais | pessoa, objeto, acao, lugar, informacao, estado e quantidade | Aceitas no schema e no validador v2 |
| Comentários no exemplo | Presentes no texto original | Removidos do prompt de produção v2 |
| Unidades antigas | Schema v1 | Continuam usando o validador v1 |

## Validação do piloto

O B02 v2 foi validado com sucesso, compilado em 11 páginas A4 e aprovado pelo verificador de PDF. A inspeção visual confirmou a renderização do banco de palavras e da seção de hanzi-alvo. O B01 v1 também foi recompilado com sucesso para confirmar compatibilidade retroativa.

O próximo passo é migrar B03 e B04 individualmente, revisando as estruturas linguísticas e ajustando os dados ricos antes de colocá-los em produção.

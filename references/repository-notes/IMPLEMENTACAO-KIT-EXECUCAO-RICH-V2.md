# Implementação do Kit de Execução — rich v2

## Escopo

Esta rodada aplicou as correções de prioridade P0 e P1 previstas no kit mestre em B02–B11, preservando a identidade visual e a arquitetura metodológica da família B.

## Alterações realizadas

### Template

- Autoavaliação com critérios mais curtos, células com padding controlado e leitura visual estável.
- Separação explícita entre `ARTEFATO PRÁTICO · O QUE VOCÊ PRODUZIU` e `PRÓXIMA RECUPERAÇÃO · O QUE VEM DEPOIS`.
- Cue oral reutilizável nas páginas de recuperação e produção:
  `Fale primeiro. Escreva depois. Consulte o mapa só depois da tentativa.`
- Bloco nomeado de prática de hanzi com quatro caracteres-alvo por unidade.
- Checklist de recuperação com linguagem mais comportamental.

### Conteúdo

- Reescrita em lote de preparação, reorganização, recombinação e produção.
- Critérios de autoavaliação reescritos como comportamentos observáveis.
- Remoção da maior parte da linguagem burocrática dominante.
- Status das unidades atualizado para `revisao_visual`.

### Contratos e pipeline

- Validador rich v2 ampliado com gates de comprimento e subjetividade dos critérios.
- Builder corrigido para usar `validate_pdf_first_v2.py` em manifestos rich v2.
- Perfil `b-family-workbook-v2` registrado separadamente do perfil piloto anterior.
- Manifesto de dez tópicos atualizado para o perfil refined v2.
- Gate automatizado `scripts/audit_kit_acceptance.py` criado.

## Limites desta rodada

- Matching imagem↔texto e mini-cenas ainda não foram ativados em lote. O kit recomenda esses componentes, mas eles exigem curadoria de assets e licenciamento.
- O PDF permanece com 11 páginas por unidade. A prática de hanzi foi integrada à página lexical para não sacrificar a página de produção.
- O modo consolidado com capa global e divisórias compactas ainda é uma etapa posterior.
- A revisão linguística humana completa continua pendente antes da publicação comercial definitiva.

## Resultados de validação

- 10/10 unidades passaram no validador rich v2.
- 10/10 unidades passaram na compilação em lote.
- 10/10 unidades mantiveram 11 páginas.
- 10/10 unidades passaram no portão conteúdo↔PDF.
- 10/10 unidades passaram no gate de aceite do kit.
- Nenhum warning editorial foi emitido pelo validador após a migração.
- Inspeção visual manual realizada em B02 nas páginas de hanzi, recuperação e fechamento.

## Próxima etapa recomendada

Implementar o modo consolidado, executar revisão linguística humana e testar matching visual seletivamente em B02 e B08 antes de propagar qualquer asset externo para toda a coleção.

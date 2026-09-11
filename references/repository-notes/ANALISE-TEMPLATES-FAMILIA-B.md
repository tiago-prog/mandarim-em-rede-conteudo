# Análise e expansão dos templates Typst — Família B

**Data:** 11 de setembro de 2026  
**Base:** repositório `mandarim-em-rede-conteudo` e PDF de referência enviado pelo usuário  
**Implementação validada:** B02 — Perguntar, responder e devolver

## Decisão consolidada

A melhor estratégia é manter o B01 como **protótipo visual de referência** e criar uma segunda camada de templates reutilizáveis por família de tópico. A primeira implementação dessa estratégia foi criada em `templates/b-family/B-family-workbook.typ`.

O novo template usa o mesmo tema visual premium do B01, mas reorganiza o workbook em dez páginas pedagógicas mais uma capa parametrizada. O conteúdo principal é carregado de `content.json`, e os elementos centrais do módulo — título, objetivo, situação, resultado mínimo, estruturas e próxima unidade — são obtidos do JSON.

O perfil foi registrado como `b-family-workbook-v1` em `templates/registry.json` e testado com o B02.

## O que foi aproveitado do PDF de referência

O PDF enviado apresenta um formato lexical claro e repetível. Cada entrada contém número, hanzi, pinyin, classe ou função, frase em pinyin, frase em hanzi e tradução em português. O material é eficiente como consulta de vocabulário e como fonte de exemplos.

Esse padrão foi incorporado conceitualmente à página **Banco de palavras** e à página **Frases de exemplo**. A diferença é intencional: o Mandarim em Rede não deve apenas reproduzir uma lista lexical. A referência foi transformada em um componente de aprendizagem que também inclui recuperação, escrita, reorganização, recombinação e produção.

| Padrão da referência | Adaptação no Mandarim em Rede |
|---|---|
| Hanzi em destaque | Hanzi dominante nos cartões e estruturas |
| Pinyin sob a forma chinesa | Pinyin como apoio visual secundário |
| Classe ou função da palavra | Rótulo funcional da estrutura |
| Frase de exemplo | Cartões de frases e uso em cenário |
| Tradução em português | Sentido funcional orientado à situação |
| Lista linear de consulta | Banco lexical ligado a tarefas |
| Baixa interatividade | Áreas de recuperação, escolha e escrita |

## Arquitetura implementada

O novo perfil possui as seguintes páginas:

| Página | Função |
|---:|---|
| Capa | Identidade, código, título e primeira estrutura |
| 1 | Situação, objetivo, resultado mínimo e preparação |
| 2 | Mapa de linguagem e decisão funcional |
| 3 | Banco de palavras com hanzi, pinyin, sentido e uso |
| 4 | Frases de exemplo derivadas das estruturas do JSON |
| 5 | Reconhecimento de pergunta, resposta e situação |
| 6 | Recuperação de formas, hanzi e conferência |
| 7 | Reorganização de blocos e sequência |
| 8 | Recombinação controlada de slots |
| 9 | Produção prática com apoio e sem apoio |
| 10 | Autoavaliação, revisão em 24 horas, revisão em 7 dias e próximo tópico |

O template também introduz helpers reutilizáveis para `cjk`, `label`, `section`, `panel`, `card`, `check`, `writebox`, `structure-card` e `word-row`. Esses componentes concentram as decisões de hierarquia, bordas, cores, espaçamento e tipografia.

## Alterações no pipeline

O gerador passou a escrever também um arquivo estável `content.json` dentro de cada diretório de build. Os arquivos nomeados por unidade, como `B02-content.json`, continuam sendo preservados para rastreabilidade. Essa alteração permite que um template parametrizado seja compilado sem conhecer previamente o código da unidade.

O registro de templates agora contém dois perfis:

| Perfil | Uso | Paginação esperada | Estado |
|---|---|---:|---|
| `b01-cumprimentos-v2` | Protótipo específico do B01 | 13 páginas | Pilot |
| `b-family-workbook-v1` | Base parametrizada para a família B | 11 páginas | Pilot |

Também foi criado o manifesto `content/pdf_first/b-family_pilot_batch.json`, que processa B02 com o novo perfil.

## Resultado do teste B02

O teste foi executado em ambiente limpo de saída e passou nas seguintes etapas:

| Verificação | Resultado |
|---|---|
| Validação do conteúdo JSON | Aprovada |
| Renderização da capa | Aprovada |
| Compilação Typst estrita | Aprovada |
| Paginação | 11 páginas A4 |
| Verificador determinístico do PDF | `VERIFY PASS`, 6 verificações aprovadas, 0 avisos |
| Texto extraído | Sem restos de código ou helpers literais após a correção final |
| Pacote ZIP | Gerado pelo pipeline |
| Inspeção visual | Aprovada em contato das 11 páginas |

Durante a implementação foram encontrados e corrigidos problemas de sintaxe Typst relacionados a modos de código e conteúdo, interpolação de campos e inclusão da capa. O teste final passou sem falhas.

## Limites atuais da implementação

O template já é parametrizado para os campos principais da unidade, mas ainda contém alguns elementos pedagógicos específicos da família B02, como o banco lexical fixo de oito itens, algumas situações textuais e parte dos blocos de recombinação. Portanto, ele deve ser tratado como **template de família em piloto**, não como gerador universal de qualquer módulo.

Para usar o mesmo perfil em B03 e B04 com qualidade editorial, é necessário evoluir o contrato JSON com campos explícitos para:

- banco de palavras;
- hanzi-alvo;
- hanzi de reconhecimento ou reciclados;
- frases de exemplo;
- slots substituíveis;
- situações de reconhecimento;
- blocos de reorganização;
- cenários de produção;
- critérios de autoavaliação.

Essa extensão deve ser feita no schema antes de copiar o template para vários módulos. Caso contrário, o layout será reutilizável, mas o conteúdo continuará parcialmente hardcoded.

## Próxima expansão recomendada

A próxima etapa deve ser uma **versão `b-family-workbook-v2` orientada por dados**. O trabalho deve seguir esta ordem:

1. Expandir `pdf_first_unit_v1.schema.json` com uma seção editorial opcional e compatível com os módulos existentes.
2. Migrar o B02 para preencher banco lexical, exemplos e slots diretamente no JSON.
3. Remover do Typst os conteúdos B02 que ainda estão fixos no código.
4. Compilar B02 novamente como teste de regressão.
5. Adaptar o mesmo perfil para B03, que trabalha demonstrativos, identificação e interrogativos.
6. Adaptar o perfil para B04, que trabalha posse, `的` e especificação.
7. Comparar visualmente os três PDFs para garantir consistência sem forçar a mesma atividade quando a estrutura linguística exigir outra tarefa.

A adaptação deve ser permitida. O objetivo não é fazer todos os módulos parecerem idênticos. O objetivo é preservar a mesma gramática visual, a mesma progressão pedagógica e os mesmos critérios de qualidade, enquanto as atividades mudam conforme a função linguística.

## Recomendação final

A implementação atual deve ser mantida como uma **prova de arquitetura**, não como produto final fechado. Ela comprova que é possível transformar um módulo JSON em um workbook parametrizado de 11 páginas, mantendo a identidade visual do projeto e incorporando a clareza lexical do PDF de referência.

A decisão correta agora é investir na modelagem editorial dos campos faltantes antes de gerar B03 e B04 em escala. Isso evita que o projeto troque o problema de “um template B01 fixo” por outro problema de “um template B02 com dados fixos”.

## Arquivos criados ou atualizados

- `templates/b-family/B-family-workbook.typ`
- `templates/b-family/report-theme.typ`
- `templates/b-family/bg-fundo-prime.png`
- `templates/registry.json`
- `content/pdf_first/b-family_pilot_batch.json`
- `scripts/build_pdf_batch.py`
- `REFERENCIA-PDF-ACHADOS.md`

## Referências

[1]: https://github.com/tiago-prog/mandarim-em-rede-conteudo "Repositório Mandarim em Rede — Conteúdo"
[2]: /home/ubuntu/upload/conteudo-para-usar-como-referencia(1).pdf "PDF de referência enviado pelo usuário"

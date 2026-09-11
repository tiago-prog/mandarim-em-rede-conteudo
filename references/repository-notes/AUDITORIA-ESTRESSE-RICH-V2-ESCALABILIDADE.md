# Auditoria de estresse do contrato `pdf-first-rich-v2`

## 1. Veredito executivo

O sistema **passa como protótipo técnico de produção repetível**, mas **ainda não está aprovado para produzir dezenas de unidades editoriais reais sem uma etapa de endurecimento**.

A infraestrutura já demonstra quatro capacidades importantes:

1. uma unidade rica pode ser validada por schema e por regras editoriais;
2. o mesmo template Typst pode consumir unidades diferentes;
3. o lote consegue compilar múltiplas unidades sem copiar manualmente o template;
4. o portão conteúdo↔PDF evita que um workbook seja gerado com formas centrais de outra unidade.

Os testes executados confirmaram que 30 unidades sintéticas foram validadas e compiladas com sucesso, em 11 páginas cada, em 1 minuto e 11 segundos. Isso prova escalabilidade operacional básica.

Entretanto, o teste de limites revelou duas falhas de produção relevantes:

- uma unidade válida no schema, com textos no limite superior, gerou 12 páginas quando o template esperava 11;
- um `hanzi_alvo` lexicalmente inadequado foi aceito porque compartilhava apenas um caractere com uma forma declarada.

Portanto, o sistema deve ser classificado como:

```text
PROTÓTIPO DE PIPELINE: APROVADO
ESCALA TÉCNICA: APROVADA COM RESSALVAS
ESCALA EDITORIAL REAL: NÃO APROVADA AINDA
```

A expansão para dezenas de unidades é viável, desde que o projeto trate **progressão, densidade, revisão linguística, overflow e contrato de lote** como partes do sistema, não como verificações manuais ocasionais.

---

## 2. Escopo auditado

Foram auditados:

- `schema/pdf_first_unit_v2.schema.json`;
- `scripts/validate_pdf_first_v2.py`;
- despacho v1/v2 em `scripts/validate_pdf_first.py`;
- `scripts/build_pdf_batch.py`;
- `scripts/verify_pdf_content.py`;
- `templates/b-family/B-family-workbook.typ`;
- unidades B02 e B03;
- manifesto `b-family_pilot_batch.json`;
- regras de pacotes e perfis de template.

Foram executados quatro grupos de teste:

1. validação de unidades válidas e inválidas;
2. lote sintético de 30 unidades;
3. teste de cardinalidade máxima e textos longos;
4. teste semântico de hanzi parcialmente coincidente.

---

## 3. Resultados dos testes executados

### 3.1 Validação de 30 unidades sintéticas

Foram geradas 30 unidades sintéticas baseadas no contrato rico v2, com códigos de B04 a B33. Todas foram submetidas ao validador dedicado.

| Métrica | Resultado |
|---|---:|
| Unidades geradas | 30 |
| Unidades válidas | 30 |
| Unidades rejeitadas indevidamente | 0 |
| Tempo de validação | 5,361 s |
| Conteúdo com áudio | 0 |

O resultado mostra que o schema e as regras editoriais suportam repetição em quantidade sem degradação perceptível do validador.

### 3.2 Casos inválidos

Foram criados sete casos de falha intencional.

| Caso | Resultado esperado | Resultado |
|---|---|---|
| Campo rico ausente | rejeitar | passou no teste |
| Sequência fora da ordem | rejeitar | passou no teste |
| Mapa aponta para forma inexistente | rejeitar | passou no teste |
| Estrutura substituível sem `slot` | rejeitar | passou no teste |
| Campo extra não permitido | rejeitar | passou no teste |
| Campo `audios` presente | rejeitar | passou no teste |
| Hanzi lexicalmente inadequado | rejeitar | **falhou: foi aceito** |

O contrato é forte contra erros estruturais, mas ainda não é suficientemente forte contra erros de conteúdo linguístico.

### 3.3 Lote de 30 unidades

As 30 unidades foram compiladas com o mesmo perfil `b-family-workbook-v1`.

| Métrica | Resultado |
|---|---:|
| Total do lote | 30 |
| Builds aprovados | 30 |
| Builds falhos | 0 |
| Páginas por unidade | 11 |
| Tempo total | 1 min 11 s |
| Pacote ZIP por unidade | gerado |
| Inclusão de áudio | não |

Isso confirma que o pipeline é operacionalmente capaz de processar um lote grande para o estágio atual.

A limitação é que as unidades eram sintéticas e estruturalmente semelhantes. Esse teste prova o funcionamento do pipeline, mas não prova variedade pedagógica, naturalidade linguística ou adequação comercial.

### 3.4 Teste de fronteira de conteúdo

Foi criada uma unidade com cardinalidades próximas do máximo permitido:

- 10 estruturas;
- 5 itens de mapa de decisão;
- 8 hanzi-alvo;
- 12 palavras-chave;
- 5 atividades de reconhecimento;
- 4 reconstruções;
- 6 itens no banco de recombinação;
- 4 moldes;
- 3 cenários de produção;
- 6 instruções de preparação;
- 5 critérios de autoavaliação;
- textos longos em títulos, instruções e critérios.

O JSON foi validado, mas a compilação falhou no portão de paginação:

```text
paginação inesperada: 12; esperado 11
```

Isso é uma falha real de escalabilidade visual. O schema permite o conteúdo, mas o template não possui política para crescimento de texto.

### 3.5 Teste de hanzi parcialmente coincidente

Foi inserido um hanzi-alvo composto por caracteres parcialmente presentes em outras formas da unidade. O validador aceitou o item.

A regra atual verifica se **algum caractere** do hanzi aparece em alguma estrutura. Isso é insuficiente para validar unidade lexical. O correto é exigir uma correspondência de palavra, expressão ou caractere definido pela política editorial, e não mera interseção de caracteres.

---

## 4. Achados críticos

### P0 — O template não possui política de overflow

A unidade rica v2 define limites de itens, mas não define limites de comprimento textual. Uma unidade pode ser válida no schema e ainda quebrar o PDF.

O template espera 11 páginas. Quando o conteúdo cresce, o Typst cria uma página adicional e o build falha.

#### Impacto

- bloqueia unidades legítimas;
- exige edição manual sem diagnóstico preciso;
- pode incentivar o editor a reduzir conteúdo de forma arbitrária;
- impede produção em escala previsível.

#### Correção necessária

Criar uma política explícita para conteúdo longo:

1. limites de caracteres por campo;
2. limites de palavras por instrução;
3. truncamento proibido;
4. quebra controlada em páginas adicionais;
5. perfil `expected_pages` flexível por densidade;
6. relatório de qual bloco causou overflow;
7. testes de renderização com conteúdo máximo.

A recomendação é não simplesmente aumentar o número esperado de páginas. Primeiro deve-se definir se a página adicional é editorialmente aceitável ou se o conteúdo deve ser dividido.

### P0 — Validação lexical de hanzi é fraca

A regra atual aceita um hanzi-alvo se qualquer caractere dele aparecer em qualquer estrutura. Isso pode validar uma expressão que não está realmente ensinada.

#### Correção necessária

Usar uma destas regras explícitas:

- `hanzi_alvo.hanzi` deve ser exatamente igual a uma palavra-chave, uma forma estrutural ou um caractere-alvo presente em estrutura;
- ou o campo deve declarar `origem`, apontando para `estrutura`, `palavra_chave` ou `caractere`;
- para compostos, cada composto deve aparecer integralmente em algum campo linguístico autorizado;
- validar consistência entre hanzi, pinyin e sentido por revisão humana ou ferramenta linguística especializada.

A interseção por caractere deve ser removida como regra de aprovação. No máximo, pode permanecer como alerta auxiliar.

### P1 — O contrato de lote continua v1

O contrato de unidade foi elevado para rich v2, mas o manifesto ainda é:

```text
pdf-first-batch-v1
```

O build despacha a unidade para o validador correto por `schema_version`, mas o lote não declara explicitamente:

- perfil de conteúdo esperado;
- versão do contrato;
- coleção;
- módulo;
- ordem pedagógica;
- política de páginas;
- compatibilidade entre template e contrato.

#### Correção necessária

Criar `pdf-first-rich-batch-v2`, com:

```json
{
  "schema_version": "pdf-first-rich-batch-v2",
  "content_profile": "pdf-first-rich-v2",
  "colecao": "...",
  "modulo": "...",
  "expected_pages_policy": "fixed|range|adaptive",
  "units": []
}
```

O builder deve rejeitar uma unidade v1 em lote rich v2, salvo se houver uma migração explícita.

### P1 — Não existe contrato de progressão entre unidades

O schema conhece `proxima_unidade_sugerida`, mas não conhece:

- pré-requisitos;
- vocabulário reciclado;
- estruturas introduzidas;
- estruturas consolidadas;
- dependências quebradas;
- repetição excessiva;
- carga cumulativa;
- posição da unidade no módulo.

Isso significa que dezenas de JSONs podem ser válidos isoladamente e formar uma coleção pedagogicamente ruim.

#### Correção necessária

Criar um catálogo de coleção com relações explícitas:

```json
{
  "codigo": "B04",
  "ordem": 4,
  "pre_requisitos": ["B01", "B02"],
  "recicla": ["吗", "呢"],
  "introduz": ["这", "那"],
  "prepara": ["B05"],
  "vocabulario_novo_maximo": 6
}
```

O catálogo deve ser validado antes do lote.

### P1 — O portão conteúdo↔PDF não cobre todos os campos ricos

O verificador confere formas impressas, tokens de hanzi, banco e exclusividade entre unidades. Ele não confirma integralmente se aparecem no PDF:

- todos os critérios de autoavaliação;
- contexto emocional;
- dificuldade principal;
- artefato prático;
- todos os itens de preparação;
- todas as instruções de produção;
- campos longos que possam ter sido cortados.

#### Correção necessária

Adicionar um `render_manifest` ao template ou ao build, registrando blocos esperados:

```json
{
  "sections": [
    "objetivo_comunicativo",
    "resultado_minimo",
    "contexto_emocional",
    "dificuldade_principal",
    "palavras_chave",
    "criterios_autoavaliacao"
  ]
}
```

O verificador deve exigir presença textual mínima de cada bloco ou de um identificador editorial invisível/auxiliar.

### P1 — A validação atual não prova qualidade linguística

O validador verifica presença de marca tonal, mas não prova:

- se o tom está correto;
- se o pinyin corresponde ao hanzi;
- se a tradução corresponde à expressão;
- se a partícula foi usada naturalmente;
- se a frase é realmente HSK 1–2;
- se a situação é culturalmente natural.

#### Correção necessária

Separar claramente:

```text
validação automática estrutural
→ revisão linguística humana
→ revisão pedagógica humana
→ revisão visual
```

O status `revisao_linguistica` deve exigir um registro de revisão, não apenas uma mudança de string no JSON.

### P1 — A coleção não possui índice lexical cumulativo

Sem vocabulário global, o sistema não detecta se uma palavra aparece como “nova” várias vezes, se foi usada antes de ser ensinada ou se desapareceu sem reciclagem.

#### Correção necessária

Criar um índice cumulativo com:

- primeira unidade;
- unidades de reciclagem;
- prioridade;
- categoria;
- pinyin aprovado;
- sentido aprovado;
- status de revisão.

### P2 — O código de unidade limita a nomenclatura

O padrão atual é:

```regex
^[A-Z][0-9]{2}$
```

Ele suporta B01–B99, mas não B100 nem códigos compostos como `B01-R`. Isso é suficiente para dezenas, mas pode se tornar restritivo em uma coleção longa ou em módulos paralelos.

#### Correção necessária

Não alterar imediatamente o v2. Primeiro definir a taxonomia editorial. Uma possível v3 poderia usar:

```text
B01
B01.1
B01-R
M1-B01
```

A alteração deve ser versionada, nunca feita silenciosamente.

### P2 — O catálogo de pacotes gera warnings inconsistentes

O boundary test utilizou `R2`, `R3` e `R4`, mas o validador advertiu que esses códigos não estão em `PACKAGE_CODES`, embora façam parte do sistema editorial rico.

Isso indica que o catálogo de pacotes e o prompt não estão totalmente sincronizados.

#### Correção necessária

Criar uma única fonte de verdade para códigos de pacote e importá-la pelo validador e pela documentação.

### P2 — O status não inclui revisão pedagógica explícita

O fluxo recomendado prevê `revisao_pedagogica`, mas o schema aceita apenas:

```text
draft
revisao_linguistica
revisao_visual
piloto
aprovado
publicado
```

A revisão pedagógica está implícita, o que aumenta o risco de um conteúdo semanticamente válido passar direto para revisão visual.

#### Correção necessária

Adicionar `revisao_pedagogica` em uma futura versão de schema ou criar um arquivo de gate externo obrigatório.

---

## 5. O que o teste de 30 unidades provou e o que não provou

### Provou

- o validador aceita múltiplas unidades válidas;
- o builder processa lotes de 30;
- o template é reutilizável;
- o pacote por unidade é gerado;
- o portão de conteúdo não falha com unidades estruturalmente semelhantes;
- a ausência de áudio é mantida.

### Não provou

- qualidade das frases;
- naturalidade do português;
- correção dos tons;
- progressão entre tópicos;
- equilíbrio de vocabulário novo e reciclado;
- variedade de cenários;
- ausência de conteúdo repetido demais;
- legibilidade de textos máximos em todas as páginas;
- desempenho com unidades realmente diferentes;
- facilidade de revisão por uma segunda pessoa;
- qualidade comercial do PDF.

O lote sintético deve ser interpretado como teste de infraestrutura, não como validação pedagógica da coleção.

---

## 6. Modelo seguro de expansão para dezenas de unidades

A expansão deve ocorrer em cinco contratos coordenados:

```text
1. contrato de unidade rich v2
2. contrato de lote rich v2
3. contrato de catálogo/progressão
4. contrato de vocabulário cumulativo
5. contrato de revisão e release
```

### Contrato de unidade

Descreve uma unidade isolada, seus campos ricos e seus exercícios.

### Contrato de lote

Descreve quais unidades serão compiladas juntas, com qual perfil e política de páginas.

### Contrato de catálogo

Descreve ordem, pré-requisitos, reciclagem, introduções e módulo.

### Contrato lexical

Descreve a história de cada palavra, hanzi, pinyin e sentido.

### Contrato de release

Descreve quais revisões foram concluídas, quais PDFs foram gerados e qual pacote pode ser publicado.

---

## 7. Plano de correção prioritário

### Fase P0 — impedir falhas de produção

1. Corrigir a validação de `hanzi_alvo` para exigir correspondência integral.
2. Criar teste automatizado de conteúdo longo.
3. Definir política de overflow e paginação.
4. Fazer o builder relatar qual seção provocou a página extra.
5. Atualizar o catálogo de pacotes para eliminar warnings inconsistentes.

### Fase P1 — controlar a coleção

6. Criar `pdf-first-rich-batch-v2`.
7. Criar matriz de progressão da coleção.
8. Criar vocabulário cumulativo.
9. Adicionar pré-requisitos e relações entre unidades.
10. Expandir o portão conteúdo↔PDF para os campos ricos.

### Fase P2 — endurecer a governança editorial

11. Criar registro de revisão linguística.
12. Criar registro de revisão pedagógica.
13. Definir convenção de códigos de unidade.
14. Criar uma unidade adversarial real por módulo.
15. Criar testes de regressão para cada template.

---

## 8. Critério de aprovação para produção em massa

O sistema só deve ser liberado para dezenas de unidades reais quando conseguir:

- validar 30 unidades semanticamente diversas;
- compilar 30 unidades com política de páginas definida;
- rejeitar hanzi e pinyin inconsistentes;
- detectar texto que excede a capacidade do layout;
- validar o manifesto rico do lote;
- verificar os campos ricos no PDF;
- detectar repetição e dependências quebradas;
- registrar revisão linguística e pedagógica;
- preservar retrocompatibilidade com B01 v1;
- gerar relatório de build completo e reprodutível.

O número “30” deve representar pelo menos cinco funções comunicativas diferentes, não 30 cópias estruturais da mesma unidade.

---

## 9. Próximo lote recomendado para validação real

A próxima validação deve usar quatro unidades editorialmente diferentes:

```text
B01 — cumprimentos em contexto
B02 — perguntar, responder e devolver
B03 — identificar pessoas e objetos
B04 — pedir algo de forma simples
```

B04 deve ser criado como unidade rica real, não cópia sintética. O lote deve testar:

- pergunta e resposta;
- identificação;
- pedido;
- reciclagem de formas anteriores;
- novos hanzi;
- novas palavras-chave;
- cenários diferentes;
- variação de comprimento de conteúdo.

Depois, criar B05 e B06 para testar transição de módulo e consolidação.

---

## 10. Veredito final

A ideia é tecnicamente boa e pode sustentar dezenas de unidades. O contrato rico v2 é uma base válida porque desloca o conteúdo para JSON, permite templates reutilizáveis e cria um portão de validação mais forte do que o v1.

O sistema ainda não é uma linha editorial totalmente industrializada. As falhas atuais não invalidam a ideia; elas identificam exatamente o trabalho necessário para transformá-la em produto entregável:

```text
schema rico
+ catálogo de progressão
+ vocabulário cumulativo
+ lote versionado
+ política de overflow
+ revisão linguística
+ revisão pedagógica
+ portão conteúdo↔PDF ampliado
```

A decisão recomendada é **continuar**, mas não avançar diretamente para dezenas de unidades. Primeiro endurecer P0, produzir B04 real, validar o lote B01–B04 e somente então aumentar a escala.

> **O pipeline já provou que consegue repetir páginas. Agora precisa provar que consegue repetir qualidade.**

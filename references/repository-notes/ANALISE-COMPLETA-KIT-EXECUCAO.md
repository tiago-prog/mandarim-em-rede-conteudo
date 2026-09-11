# Análise completa do Kit de Execução — Mandarim em Rede

## 1. Conclusão executiva

O ZIP recebido não é apenas uma coleção de ideias. Ele funciona como um **briefing mestre de correção de produto**, com políticas editoriais, componentes prioritários, limites visuais, fontes de assets e critérios de aceite.

A direção é consistente com o estado atual do projeto: **não se deve reconstruir o produto**, trocar sua identidade ou aumentar a densidade de modo indiscriminado. A próxima versão deve preservar o método `mapa → recuperação → reorganização → recombinação → produção` e corrigir principalmente a experiência de uso.

O repositório atual já possui a base técnica necessária para começar:

- contrato JSON rich v2;
- template parametrizado de família B;
- lote de dez tópicos B02–B11;
- validador estrutural e editorial;
- portão conteúdo↔PDF;
- pipeline de compilação em lote;
- fonte SVG para prática de escrita de hanzi.

Entretanto, a maior parte das mudanças do kit ainda não está implementada no template ou no conteúdo. O estado real é:

```text
Base técnica: pronta
Identidade visual: preservada
Correção P0: pendente
Políticas editoriais: parcialmente aplicadas
Componentes de prazer visual: ainda não incorporados
Modo consolidado com divisórias: pendente
Acessibilidade de capas: pendente
Revisão linguística humana: pendente
```

A implementação deve ocorrer em duas frentes coordenadas:

1. **Template e pipeline**, para corrigir layout, separações e novos componentes.
2. **Conteúdo JSON**, para reescrever instruções, critérios de domínio e metadados editoriais.

Não é seguro corrigir apenas o Typst. Se os critérios continuarem longos e subjetivos no JSON, o template ficará mais resistente, mas o produto continuará editorialmente abaixo do objetivo.

---

## 2. Escopo do kit recebido

O ZIP contém doze arquivos de direção distribuídos em seis blocos:

| Bloco | Conteúdo | Função |
|---|---|---|
| Entrada | `00-LEIA-PRIMEIRO.md` | Ordem e limites de execução |
| Briefing | Auditoria consolidada e análise de stress | Diagnóstico e prioridades |
| Políticas | Autoavaliação, linguagem, separação | Regras obrigatórias |
| Componentes | Componentes prioritários | Mudanças de experiência |
| Assets/fontes | Fontes aprovadas | Limites de identidade e licenciamento |
| Exemplos/aceite | Reescritas e checklist | Padrão editorial e gate final |
| Mestre | `MESTRE-COMPLETO.md` | Versão condensada de execução |

O kit tem uma decisão central inequívoca:

> **Manter o método, corrigir o que quebra, aumentar o prazer de uso e proteger a recuperação ativa.**

---

## 3. Estado atual real do repositório

### 3.1 O que já existe

O repositório `mandarim-em-rede-conteudo` já contém:

- dez unidades rich v2 em `content/pdf_first/`;
- catálogo de coleção em `content/catalogo/colecao_01_matriz.json`;
- vocabulário cumulativo em `content/catalogo/vocabulario_cumulativo.json`;
- template principal em `templates/b-family/B-family-workbook.typ`;
- registro de templates em `templates/registry.json`;
- builder de lote em `scripts/build_pdf_batch.py`;
- validador v2 em `scripts/validate_pdf_first_v2.py`;
- verificador de presença conteúdo↔PDF em `scripts/verify_pdf_content.py`;
- fonte SVG de prática de escrita em `references/material/PRATICA-DE-ESCRITA.svg`.

### 3.2 O que o template atual realmente produz

O template atual gera:

1. capa rasterizada;
2. abertura;
3. mapa de linguagem;
4. banco de palavras;
5. frases de exemplo;
6. reconhecimento;
7. recuperação;
8. reorganização;
9. recombinação;
10. produção prática;
11. autoavaliação, revisão, artefato e continuidade.

Isso totaliza 11 páginas com capa.

### 3.3 Lacuna estrutural mais importante

O kit propõe uma distribuição de 11 páginas que inclui uma página visível de prática de hanzi ou bloco visual forte antes da autoavaliação. O template atual **não possui essa página**. A prática de escrita de hanzi existe apenas como recurso SVG no repositório, mas não está conectada ao schema, ao template ou ao builder.

Há três caminhos possíveis:

| Caminho | Resultado | Avaliação |
|---|---|---|
| Adicionar uma página | 12 páginas por unidade | Melhor para preservar todas as funções |
| Comprimir produção e escrita na mesma página | Mantém 11 páginas | Risco de reduzir espaço de produção |
| Inserir escrita dentro da recuperação/recombinação | Mantém 11 páginas | Menor impacto visual, mas componente menos forte |

**Recomendação:** adotar 12 páginas nos PDFs individuais durante a evolução do template, com uma página de escrita ou bloco visual forte dedicado. No consolidado, implementar divisórias compactas e avaliar a possibilidade de manter 11 páginas por unidade somente após validar o uso real. Se a decisão comercial exigir exatamente 11 páginas, a melhor compressão é incorporar uma faixa de escrita de hanzi na página 4 ou 5, sem sacrificar a página de produção.

O kit não resolve explicitamente essa tensão. Ela precisa ser decidida antes da implementação final.

---

## 4. Matriz de conformidade do kit

| Exigência do kit | Estado atual | Severidade | Ação necessária |
|---|---|---:|---|
| Corrigir tabela de autoavaliação | Não conforme | P0 | Alterar template e conteúdo |
| Critérios observáveis | Parcial | P0 | Reescrever B02–B11 |
| Critérios de no máximo uma linha | Parcial | P0 | Encurtar e criar teste de comprimento |
| Separar artefato e próximo tópico | Não conforme | P0 | Criar dois painéis distintos |
| Separar consulta, produção e resposta | Parcialmente conforme | P0 | Auditar cada página e formalizar gate |
| Remover apoio completo da produção | Conforme no template atual | P0 | Criar teste automático para preservar |
| Reescrever voz das instruções | Não conforme em grande parte | P1 | Alterar JSON B02–B11 |
| Nomear espaços vazios | Não conforme | P1 | Criar componente reutilizável |
| Instrução oral recorrente | Parcial | P1 | Adicionar a recuperação e produção |
| Prática de hanzi | Recurso existe, não integrado | P1 | Integrar schema, template e conteúdo |
| Matching imagem↔texto | Não implementado | P1 | Definir asset e componente |
| Mini-cena/balão | Não implementado | P1 | Implementar somente após P0 |
| Checklist de conquista | Parcial | P1 | Reescrever e tornar observável |
| Divisórias no consolidado | Não implementado | P2 | Alterar política de compilação |
| Acessibilidade das capas | Não conforme | P2 | Adicionar camada textual/metadados |
| Otimização de assets/fontes | Não feita | P2 | Otimizar depois da estabilidade |
| Portão conteúdo↔PDF | Conforme | P0 | Preservar e ampliar |
| Revisão visual em escala real | Feita na edição atual | P2 | Repetir na nova edição |
| Revisão linguística humana | Pendente | P2 crítico de publicação | Criar fluxo separado |

---

## 5. P0 — Alterações obrigatórias antes de qualquer melhoria decorativa

### 5.1 Autoavaliação: correção de template

O problema está explícito no código atual:

```typst
#table(columns: (1.6fr, 1fr, 1fr, 1fr), ...
  ..criteria.map(item => ([#item], [☐], [☐], [☐])).flatten()
)
```

O template joga os critérios diretamente em uma tabela de altura implícita, mas não controla adequadamente o comportamento de linhas longas. O kit recomenda altura adaptativa, mas a solução não deve depender apenas do aumento da altura.

A correção deve conter quatro camadas:

1. **Reescrever o conteúdo** para critérios curtos.
2. **Aumentar padding vertical mínimo** das células.
3. **Garantir quebra controlada** na coluna de critério.
4. **Adicionar teste de regressão visual** com critérios curtos, médios e longos.

A fonte não deve ser reduzida como primeira resposta. Isso apenas esconderia o problema e reduziria legibilidade.

### 5.2 Autoavaliação: correção de conteúdo

O schema atual permite de 4 a 5 critérios, mas não impõe comprimento, observabilidade ou ausência de múltiplas ideias. O validador também não verifica essas regras.

É necessário adicionar regras editoriais no validador:

- quantidade entre 4 e 5;
- frase comportamental;
- proibição de formulações subjetivas conhecidas;
- comprimento máximo configurável;
- alerta para critérios acima da largura estimada;
- alerta para duas conjunções ou duas ações no mesmo item;
- presença de pelo menos um critério de produção sem mapa.

O comprimento não deve ser tratado apenas por número de caracteres, porque hanzi e acentos ocupam larguras diferentes. A solução mais segura é usar uma combinação:

```text
hard gate: máximo de caracteres
soft warning: renderização real em Typst
visual gate: inspeção das dez páginas finais
```

### 5.3 Separação Artefato Prático × Próximo Tópico

O template atual coloca os dois conceitos no mesmo painel:

```typst
#section("PRÓXIMO TÓPICO", color: ochre)
#panel(...)[
  #label("ARTEFATO PRÁTICO")
  #small[#unit.artefato_pratico]
  #small[#unit.proxima_unidade_sugerida]
  ...
]
```

Isso é semanticamente incorreto na apresentação. O artefato pertence ao fechamento da unidade atual. O próximo tópico é continuidade.

A nova estrutura deve ser:

```text
REVISAR E CONTINUAR
├── AUTOAVALIAÇÃO
├── REVISÃO PROGRAMADA
├── ARTEFATO PRÁTICO · O QUE VOCÊ PRODUZIU
└── PRÓXIMA RECUPERAÇÃO · O QUE VEM DEPOIS
```

O artefato deve ter maior peso visual. A continuidade deve ser menor e não competir com a conquista da unidade.

O schema já possui os dois campos separados:

- `artefato_pratico`;
- `proxima_unidade_sugerida`.

Portanto, esta alteração é principalmente de template e talvez de nomenclatura editorial, não de contrato estrutural.

### 5.4 Separação Consulta × Produção × Resposta

#### Estado atual conforme

A produção prática atual contém cenário, campos de escrita e checklist. Não mostra o banco completo, mapa completo ou gabarito. Isso está de acordo com a política.

A recombinação mostra um banco específico de slots na mesma página. Isso é permitido pelo kit como apoio mínimo controlado, mas não deve crescer para banco completo.

#### Riscos que precisam ser auditados

- a página de recuperação usa `mapa_decisao` para criar linhas de função, o que pode ser apoio suficiente para alguns alunos;
- a página de reorganização mostra os blocos completos antes da produção, o que é adequado para reorganização, mas não para recuperação sem apoio;
- a página de frases possui exemplos completos e deve continuar separada das páginas de produção;
- não há gabarito explícito no PDF atual, mas o pipeline deve garantir que respostas não sejam introduzidas em novos componentes;
- qualquer matching deve evitar colocar a solução na mesma página.

A nova política deve ser implementada como um contrato de páginas:

| Página | Pode conter | Não pode conter |
|---|---|---|
| Consulta | mapa, banco, frases | resposta do exercício |
| Reconhecimento | situação e alternativas | gabarito |
| Recuperação | função e campo de resposta | banco completo, resposta |
| Reorganização | blocos embaralhados | sequência correta |
| Recombinação | molde e banco mínimo | banco lexical completo |
| Produção | cenário, molde mínimo e campo | mapa completo, banco completo, exemplos traduzidos |
| Fechamento | autoavaliação e artefato | gabarito do exercício |

Também será necessário criar um teste que procure no texto das páginas de produção por todas as palavras-chave do tópico e sinalize se a densidade de apoio ultrapassar um limite.

---

## 6. P1 — Alterações editoriais e de experiência

### 6.1 Reescrita da voz

A auditoria dos dados atuais confirma que a voz ainda contém muitos verbos burocráticos. Exemplos encontrados:

- `Observe`;
- `Identifique`;
- `Tente`;
- `Registre`;
- `Ordene`;
- `Mantenha`;
- `Escreva` usado como comando neutro;
- `Leia` usado sem desafio ou contexto.

Esses verbos não precisam ser banidos em absoluto. O problema é dominarem a experiência.

A reescrita deve operar em três camadas:

1. **Labels de seção:** mais curtos e mais ativos.
2. **Instruções de execução:** uma ação por frase.
3. **Checklists:** comportamento observável e sensação de conquista.

Exemplos de substituição:

| Estado atual | Direção do kit |
|---|---|
| Observe quem faz a pergunta | Quem está falando? |
| Identifique o que deve ser respondido | O que essa pessoa quer saber? |
| Tente antes de consultar o mapa | Feche o mapa. Tente sozinho. |
| Complete a forma | Escreva sua resposta. |
| Ordene os blocos | Monte a frase na ordem certa. |
| Produza três trocas | Crie 3 trocas suas. |
| Leia em voz alta | Fale em voz alta. |
| Registre a dúvida | O que ainda ficou estranho? |

A reescrita deve ser feita no JSON, não diretamente no Typst, sempre que o texto for específico da unidade.

### 6.2 Diagnóstico dos dados atuais

A análise das dez unidades mostrou:

| Unidade | Critérios | Critérios longos estimados | Instrução oral explícita nas prioridades |
|---|---:|---:|---|
| B02 | 5 | 1 | Não |
| B03 | 5 | 1 | Não |
| B04 | 4 | 0 | Parcial |
| B05 | 4 | 0 | Parcial |
| B06 | 4 | 0 | Parcial |
| B07 | 4 | 1 | Parcial |
| B08 | 4 | 0 | Parcial |
| B09 | 4 | 0 | Parcial |
| B10 | 4 | 0 | Parcial |
| B11 | 4 | 0 | Parcial |

A conclusão é clara: B02 e B03 precisam de reescrita mais intensa, mas todas as unidades devem passar por uma revisão uniforme.

A busca também encontrou vocabulário burocrático em todas as unidades nas instruções de reorganização, preparação ou produção. Mesmo quando há uma instrução oral, ela não é uma política recorrente visível em todas as páginas.

### 6.3 Instrução de oralidade

A frase oficial do kit deve virar um componente reutilizável:

> **Fale primeiro. Escreva depois. Consulte o mapa só depois da tentativa.**

Ela deve aparecer, com pequenas variações permitidas, em:

- página de recuperação;
- página de produção prática;
- página de hanzi writing quando houver frase ou palavra a ser verbalizada;
- opcionalmente na recombinação.

A frase não deve ser apenas um texto decorativo. Deve estar próxima do campo que o aluno usará.

### 6.4 Nomeação do espaço vazio

O template usa `#v(...)` em vários pontos para separar blocos. Espaçamento vertical é necessário, mas o kit exige que áreas realmente generosas tenham função explícita.

A solução não é rotular cada intervalo de 4–8 pt. A regra operacional deve distinguir:

- **espaçamento estrutural:** continua sem rótulo;
- **área de escrita/prática:** recebe painel, label e instrução;
- **área vazia decorativa:** permanece apenas se não competir com uma função pedagógica.

Componentes recomendados:

```typst
#let named-space(title, instruction: none, height: 18mm, color: teal) = ...
#let oral-cue(text: "Fale primeiro. Escreva depois.") = ...
#let victory-check(items) = ...
```

Rótulos prioritários:

- `FALE PRIMEIRO · ESCREVA DEPOIS`;
- `MINHA TENTATIVA SEM OLHAR`;
- `O QUE AINDA CONFUNDO`;
- `SEGUNDA RODADA SEM MAPA`;
- `MEU EXEMPLO PRÓPRIO`;
- `NOTA DE TOM / PRONÚNCIA`.

### 6.5 Componentes de prazer visual

O kit recomenda quatro componentes. Eles devem ser implementados com moderação e repetição consistente.

#### Prática de escrita de hanzi

O SVG já existe, o que reduz o risco técnico. Ainda faltam:

- modelo de dados para 4–6 hanzi-alvo;
- decisão sobre quantos quadrados por hanzi;
- integração do SVG como asset do template;
- espaço para cópia;
- linha de produção de memória;
- teste de legibilidade impressa.

O schema já possui `hanzi_alvo`, mas contém apenas hanzi, pinyin, sentido e prioridade. O template pode usar esse campo diretamente para renderizar os caracteres. Para completar o componente, será útil adicionar configuração opcional de prática:

```json
"pratica_hanzi": {
  "incluir": true,
  "quantidade": 4,
  "modo": "modelo_e_memoria"
}
```

#### Matching imagem↔texto

O repositório não possui ainda banco de imagens por tópico. O kit autoriza Pexels, Unsplash e Openverse, mas isso não significa que assets devem ser baixados automaticamente sem curadoria.

Antes de implementar matching, será necessário definir:

- imagem ou ilustração por item;
- licença e atribuição;
- recorte e resolução;
- relação com o vocabulário;
- ausência de texto embutido na imagem;
- solução sem gabarito na mesma página.

Recomendação: começar com **matching baseado em ícones ou ilustrações vetoriais simples**, usando Lucide/Phosphor/Tabler quando o conceito permitir. Usar fotos somente quando uma foto realmente aumentar a compreensão.

#### Mini-cena/balão

É útil para B02, B03, B08 e B09, mas não precisa aparecer em todos os tópicos na primeira rodada. Deve ser tratado como componente opcional por unidade, para não forçar uma cena artificial em tópicos de horário ou rotina.

#### Checklist de conquista

Já existem checkboxes no template, mas muitos textos são retrospectivos ou subjetivos. O componente deve ser reescrito como resultado:

- `Falei sem olhar.`
- `Troquei só o slot.`
- `Usei a pergunta certa.`
- `Mantive a ordem.`

---

## 7. P2 — Alterações de publicação e infraestrutura

### 7.1 Modo individual versus consolidado

O registro atual define o perfil `b-family-workbook-v1` com 11 páginas e capa completa. O kit recomenda:

- PDF individual: capa completa;
- PDF consolidado: uma capa global e divisórias compactas.

O builder atual compila unidades individualmente e gera pacotes, mas não possui um modo consolidado nativo. O PDF de 110 páginas foi montado posteriormente com `pdfunite`.

Para implementar corretamente, o sistema precisa de:

1. manifesto de compilação com `mode: individual|consolidated`;
2. renderer de capa global;
3. componente de divisória compacta;
4. política de incluir/excluir capa completa por unidade;
5. relatório de paginação por modo;
6. teste de ordem e separação dos tópicos.

A mudança não deve ser feita antes dos P0, porque a nova paginação dificultaria isolar regressões.

### 7.2 Acessibilidade das capas

As capas atuais são imagens rasterizadas. A solução correta é manter o visual, mas sobrepor ou gerar texto vivo para:

- Mandarim em Rede;
- código da unidade;
- título;
- subtítulo;
- primeira estrutura em hanzi;
- pinyin;
- sentido funcional.

Isso permite pesquisa e melhora leitores de tela. A camada textual deve ser invisível ou visualmente alinhada, sem duplicar a aparência.

### 7.3 Otimização de assets e fontes

O arquivo consolidado possui repetição de imagens e subconjuntos de fontes por unidade. A otimização deve ocorrer somente depois da estabilidade visual.

Possíveis ações:

- reutilizar assets com nomes idênticos no fluxo consolidado;
- evitar reempacotar a mesma textura em cada unidade;
- reduzir raster apenas se a impressão permanecer nítida;
- manter fontes CJK incorporadas;
- verificar PDFs em impressão e zoom 100% antes e depois.

Não se deve sacrificar caracteres chineses ou contraste em nome de uma redução de megabytes.

---

## 8. Análise dos assets aprovados

### 8.1 Fontes e identidade

O kit exige reutilizar:

- ornamentos atuais;
- barras de seção;
- cores atuais;
- tipografia atual;
- estrutura visual da família B.

Isso é compatível com o template existente. Não há necessidade de trocar fontes.

### 8.2 Ícones

A ordem recomendada é:

1. Lucide;
2. Phosphor;
3. Tabler;
4. Heroicons.

Os ícones devem ser finos, minimalistas e monocromáticos ou derivados da paleta existente. Os usos prioritários são fala, escrita, mapa, atenção, seta e conquista.

### 8.3 Imagens

Pexels, Unsplash e Openverse são fontes aprovadas, mas a execução deve registrar:

- URL da fonte;
- autor quando aplicável;
- licença;
- data de acesso;
- arquivo local usado;
- unidade e item lexical relacionado.

Sem esse registro, o produto fica com risco de licenciamento e inconsistência editorial.

### 8.4 Hanzi writing

O SVG existente é o asset mais seguro para a primeira implementação. Ele é vetorial e já pertence ao repositório. Deve ser integrado antes de buscar qualquer imagem externa.

---

## 9. Alterações necessárias por arquivo

### 9.1 Template

Arquivo principal:

```text
templates/b-family/B-family-workbook.typ
```

Alterações:

- corrigir autoavaliação;
- separar artefato e continuidade;
- adicionar componente de oralidade;
- adicionar componente de espaço nomeado;
- adicionar checklist de conquista;
- integrar escrita de hanzi;
- opcionalmente integrar matching/cena;
- avaliar modo de paginação com 12 páginas;
- garantir que a página de produção continue sem banco completo e sem gabarito.

### 9.2 Schema

Arquivo principal:

```text
schema/pdf_first_unit_v2.schema.json
```

Alterações recomendadas:

- adicionar `pratica_hanzi` opcional;
- adicionar `matching` opcional;
- adicionar `mini_cena` opcional;
- adicionar `prompts_oralidade` opcional ou gerar componente fixo no template;
- adicionar campos de nomes para espaços quando a função variar por unidade;
- adicionar configuração de `modo_visual` por unidade;
- manter compatibilidade com unidades existentes usando defaults.

Não é necessário adicionar todos os novos campos em um único passo. Para o primeiro ciclo, `pratica_hanzi` e `modo_visual` são suficientes.

### 9.3 Conteúdo JSON

Arquivos:

```text
content/pdf_first/B02-*.json
...
content/pdf_first/B11-*.json
```

Alterações:

- reescrever `preparacao`;
- reescrever instrução de reorganização;
- reescrever instrução de recombinação;
- reescrever instruções dos cenários;
- reescrever `criterios_autoavaliacao`;
- revisar artefato prático;
- revisar continuidade;
- definir hanzi de escrita por unidade;
- marcar o componente visual escolhido.

### 9.4 Validador

Arquivo:

```text
scripts/validate_pdf_first_v2.py
```

Alterações:

- gate de critérios observáveis;
- gate de critérios curtos;
- warnings para verbos burocráticos excessivos;
- validação de `pratica_hanzi` contra `hanzi_alvo`;
- validação de componente visual por unidade;
- validação de oralidade na recuperação/produção;
- validação de separação de artefato e próximo tópico;
- verificação de slots em moldes;
- warnings de itens lexicais sem reaparição.

### 9.5 Portão conteúdo↔PDF

Arquivo:

```text
scripts/verify_pdf_content.py
```

Alterações:

- verificar hanzi de escrita renderizados;
- verificar labels de oralidade;
- verificar artefato e continuidade em posições diferentes;
- detectar palavras-chave completas na página de produção;
- verificar ausência de gabarito textual nas páginas de prática;
- verificar títulos e códigos das capas na camada acessível, quando implementada.

### 9.6 Builder e manifestos

Arquivo principal:

```text
scripts/build_pdf_batch.py
```

Alterações:

- suportar `individual` e `consolidated`;
- copiar e reutilizar assets corretamente;
- registrar modo de compilação no manifesto;
- atualizar política de páginas;
- gerar relatório consolidado;
- preservar pacotes individuais.

Manifestos que precisam ser revisados:

```text
content/pdf_first/colecao_01_rich_10_topicos.json
content/pdf_first/b-family_rich_v2_batch.json
```

### 9.7 Registro de templates

Arquivo:

```text
templates/registry.json
```

Após a correção, registrar um novo perfil em vez de sobrescrever o piloto:

```text
b-family-workbook-v2
```

Manter `b-family-workbook-v1` para regressão histórica.

---

## 10. Plano de implementação recomendado

### Fase 0 — Contrato visual e decisão de paginação

Antes de editar dez unidades, decidir:

- 11 ou 12 páginas por PDF individual;
- escrita de hanzi em página própria ou bloco integrado;
- matching obrigatório ou opcional;
- política de capa individual e consolidado.

A decisão recomendada é:

```text
individual: capa completa + 10/11 páginas pedagógicas
consolidado: capa global + divisórias compactas
hanzi writing: componente obrigatório, mas com página ou bloco definido por família
matching: componente opcional por unidade na primeira rodada
```

### Fase 1 — P0 de template

Implementar somente:

- autoavaliação adaptativa;
- critérios curtos;
- dois painéis finais;
- separação consulta/produção;
- teste com conteúdo atual.

Executar B02 como regressão antes de tocar B03–B11.

### Fase 2 — P0 de conteúdo e voz

Reescrever os dez JSONs:

- preparação;
- reorganização;
- recombinação;
- produção;
- autoavaliação.

Executar o validador e revisar o texto extraído.

### Fase 3 — Oralidade e espaços nomeados

Adicionar:

- cue de oralidade na recuperação;
- cue de oralidade na produção;
- segunda tentativa sem mapa;
- espaço de dúvida ou tom;
- labels de tentativa.

### Fase 4 — Delight visual controlado

Adicionar primeiro escrita de hanzi, por ser o componente com asset local e menor risco de identidade. Depois testar matching em duas unidades-piloto, preferencialmente B02 e B08.

Não implementar simultaneamente escrita, matching, mini-cena e novo sistema de conquista em todas as unidades. Isso dificultaria atribuir efeitos e aumentaria a superfície de falhas.

### Fase 5 — Consolidado e acessibilidade

Depois de todas as unidades passarem:

- criar capa global;
- criar divisórias compactas;
- adicionar camada textual às capas;
- otimizar assets;
- recompilar o workbook consolidado;
- comparar com a edição atual.

### Fase 6 — Validação humana

Executar:

- inspeção visual a 100% em todas as páginas finais;
- impressão de amostra;
- teste em escala de cinza;
- teste com 1–2 alunos iniciantes;
- revisão de mandarim por falante competente/nativo;
- revisão comercial de desejo e completude.

---

## 11. Matriz de teste de stress necessária

### 11.1 Conteúdo

| Teste | Critério |
|---|---|
| Critério curto | Cabe em uma linha e mantém clareza |
| Critério médio | Não sobrepõe caixas |
| Critério longo adversarial | É rejeitado ou adaptado corretamente |
| Hanzi raro/complexo | Continua legível na grade |
| Pinyin com tons | Não perde acentos |
| Palavra longa em português | Não quebra a tabela |
| Cenário com três campos | Mantém espaço de escrita |
| Tópico com dois cenários | Não gera excesso de espaço vazio |

### 11.2 Separação

| Teste | Critério |
|---|---|
| Banco na produção | Deve ser rejeitado ou gerar alerta |
| Mapa na produção | Deve ser rejeitado ou gerar alerta |
| Frase traduzida na produção | Deve ser rejeitada |
| Gabarito na prática | Deve ser rejeitado |
| Molde mínimo | Permitido |
| Banco mínimo na recombinação | Permitido |

### 11.3 Layout

- dez páginas finais comparadas;
- títulos longos B05, B07, B08 e B10;
- critérios com hanzi e pontuação;
- cartões em duas colunas;
- tabela com 4 e 5 critérios;
- escrita de 4, 5 e 6 hanzi;
- matching com imagens em tamanhos pequeno e médio;
- impressão em A4;
- zoom de 100%.

### 11.4 Pipeline

- validação individual;
- build individual;
- conteúdo↔PDF;
- build consolidado;
- ordem B02–B11;
- relatório de páginas;
- pacotes ZIP;
- git diff limpo de artefatos temporários.

---

## 12. Itens que não devem ser feitos agora

O kit é explícito e deve ser respeitado:

- não criar nova identidade visual;
- não trocar o skin atual;
- não infantilizar;
- não criar personagens novos;
- não adicionar gamificação complexa;
- não encher páginas de decoração;
- não baixar pacotes enormes de imagens;
- não colocar gabarito junto do exercício;
- não colocar banco completo na produção;
- não transformar o mapa em atividade fofa;
- não reduzir a área de escrita para aumentar densidade;
- não fazer uma grande refatoração de conteúdo sem revisão linguística.

---

## 13. Decisões que o kit deixa em aberto

Antes de executar a alteração em lote, existem cinco decisões que precisam ser fixadas no plano técnico:

### 13.1 11 ou 12 páginas

O kit menciona 11 páginas, mas inclui escrita de hanzi como página 10 e fechamento como página 11, além das funções existentes. O template atual já usa as 10 páginas internas. É necessário decidir se haverá compressão ou aumento de páginas.

**Recomendação:** 12 páginas individuais na primeira edição refinada, ou escrita integrada na página 4/5 se a política comercial exigir 11.

### 13.2 Matching obrigatório ou opcional

O kit considera matching prioridade visual, mas não fornece banco de imagens pronto. Torná-lo obrigatório agora cria risco de assets inconsistentes.

**Recomendação:** escrever o componente no template, mas habilitá-lo primeiro em B02 e B08; usar hanzi writing como componente universal inicial.

### 13.3 Resposta/gabarito

O kit diz que gabarito deve ficar no final da unidade ou apêndice, mas o produto atual não possui gabarito. É preciso decidir se haverá gabarito separado em uma edição posterior.

**Recomendação:** não adicionar gabarito nesta rodada se a proposta continuar focada em recuperação. Caso seja necessário, gerar um arquivo separado ou apêndice não intercalado.

### 13.4 Critério de uma linha

“Uma linha” depende do tamanho final, fonte e largura. Deve ser definido por renderização, não apenas por caracteres.

**Recomendação:** máximo editorial aproximado + gate visual obrigatório.

### 13.5 Revisão linguística

O kit corretamente deixa a revisão linguística como etapa posterior, mas o material não deve ser publicado comercialmente como definitivo antes dela.

**Recomendação:** marcar as unidades como `revisao_linguistica` até que hanzi, pinyin, tons, traduções e naturalidade sejam revisados.

---

## 14. Critérios de aceite consolidados

A nova versão só deve ser aprovada quando todos os grupos abaixo estiverem verdes.

### P0

- nenhuma autoavaliação colapsa;
- todos os critérios são observáveis;
- os critérios são curtos e legíveis;
- artefato e continuidade estão separados;
- não há gabarito na página de prática;
- não há banco completo na produção;
- não há mapa completo na produção;
- consulta, produção e resposta estão em locais diferentes.

### P1

- voz ativa e adulta;
- espaços principais nomeados;
- cue oral em recuperação e produção;
- pelo menos um componente de prazer por unidade;
- hanzi writing ou matching legível;
- produção continua com campos generosos;
- identidade visual não foi alterada;
- critérios de conquista são verificáveis.

### P2

- compilação individual e consolidada documentadas;
- capas pesquisáveis/acessíveis;
- assets otimizados;
- inspeção visual humana feita;
- teste com aluno iniciante realizado;
- revisão linguística concluída antes de publicação.

---

## 15. Veredito final

O kit está bem construído e não contradiz a arquitetura principal do projeto. Ele transforma observações visuais em políticas executáveis e dá direção suficiente para uma nova rodada de produção.

A mudança mais importante não é estética. É **editorial e de interação**:

```text
antes: página bonita + tarefa correta
agora: página bonita + tarefa correta + ação clara + conquista visível
```

A ordem correta de execução é:

```text
1. corrigir autoavaliação
2. separar artefato e continuidade
3. formalizar consulta × produção × resposta
4. reescrever voz e critérios
5. nomear espaços e oralidade
6. integrar hanzi writing
7. testar matching seletivamente
8. criar consolidado com divisórias
9. validar visual, linguístico e com alunos
```

Não se deve começar baixando imagens, redesenhando capas ou gerando uma nova edição completa. O primeiro lote de trabalho deve ser um **protótipo corrigido do B02**, seguido de B03 e B08 como testes de diversidade. Somente depois disso a alteração deve ser propagada para B04–B11.

> **O projeto não precisa de mais conteúdo agora. Precisa de uma camada de execução mais clara, mais prazerosa e mais resistente a variação de comprimento.**

## Referências internas

- `kit-execucao/00-LEIA-PRIMEIRO.md`
- `kit-execucao/MESTRE-COMPLETO.md`
- `kit-execucao/01-briefing/AUDITORIA-CONSOLIDADA-DIRECAO-PRODUTO.md`
- `kit-execucao/01-briefing/ANALISE-ESTRESSE-WORKBOOK-10-TOPICOS.md`
- `kit-execucao/02-politicas/politica-autoavaliacao.md`
- `kit-execucao/02-politicas/politica-linguagem.md`
- `kit-execucao/02-politicas/politica-separacao-consulta-producao.md`
- `kit-execucao/03-componentes/componentes-prioritarios.md`
- `kit-execucao/04-assets-fontes/fontes-aprovadas.md`
- `kit-execucao/05-exemplos/exemplos-reescrita-instrucoes.md`
- `kit-execucao/06-criterios-aceite/criterios-aceite.md`
- `templates/b-family/B-family-workbook.typ`
- `schema/pdf_first_unit_v2.schema.json`
- `scripts/validate_pdf_first_v2.py`
- `scripts/build_pdf_batch.py`

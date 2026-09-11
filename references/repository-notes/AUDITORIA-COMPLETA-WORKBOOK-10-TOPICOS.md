# Auditoria completa do PDF — Workbook de 10 tópicos

## 1. Conclusão executiva

O PDF consolidado está **tecnicamente estável e visualmente coerente**, mas ainda não está em estado de publicação final. A geração passou pelos portões estruturais e de conteúdo, porém a inspeção visual revelou um problema de layout importante na tabela de autoavaliação e oportunidades claras de melhoria na densidade, na função dos espaços vazios, na separação entre artefato prático e próximo tópico e na acessibilidade das capas.

O principal achado não é uma falha de identidade visual. A identidade está consistente. O principal achado é que o sistema atual aplica uma grade fixa a conteúdos com comprimento variável. Quando os critérios de autoavaliação ficam mais longos, o texto quebra dentro de linhas que não crescem adequadamente.

### Veredito

```text
Conteúdo declarado presente no PDF: APROVADO
Paginação e ausência de páginas vazias: APROVADO
Margens e ausência de cortes detectáveis: APROVADO
Consistência visual entre tópicos: APROVADO
Ergonomia da autoavaliação: REQUER CORREÇÃO
Densidade e uso do espaço: REQUER OTIMIZAÇÃO
Acessibilidade textual das capas: REQUER MELHORIA
Revisão linguística humana: AINDA PENDENTE
```

A recomendação é corrigir primeiro a autoavaliação, depois decidir uma política de densidade e somente então gerar uma nova edição consolidada.

---

## 2. Objeto e método da auditoria

O objeto analisado foi o arquivo consolidado:

```text
/home/ubuntu/mandarim-em-rede-workbook-10-topicos.pdf
```

O arquivo possui 110 páginas e reúne dez unidades de onze páginas cada, correspondentes a B02–B11.

A auditoria combinou quatro métodos:

1. **Inspeção textual de todas as páginas**, usando extração com layout e busca por títulos, frases, pinyin, instruções e termos de exercício.
2. **Conferência conteúdo↔PDF por unidade**, verificando formas impressas, palavras-chave, tokens de hanzi e fragmentos ricos.
3. **Medição programática do PDF**, incluindo tamanho, fontes incorporadas, caixas de texto, margens, alturas aparentes, caracteres inválidos e páginas com pouco ou nenhum texto.
4. **Inspeção visual de páginas representativas e de risco**, incluindo capas, abertura, mapa, frases, recuperação, recombinação, produção e as dez páginas finais de autoavaliação.

Foram inspecionadas visualmente as páginas 1, 2, 3, 5, 7, 9, 10, 11, 12, 23, 34, 35, 45, 56, 67, 78, 89, 100 e 110, além de uma folha de contato das dez páginas de fechamento.

---

## 3. Métricas gerais do arquivo

| Métrica | Resultado | Interpretação |
|---|---:|---|
| Páginas | 110 | Dez tópicos de onze páginas |
| Tamanho do arquivo | 15 MB | Aceitável para distribuição digital |
| Unidades | 10 | B02–B11 |
| Páginas por unidade | 11 | Uniformidade alta |
| Páginas sem texto extraível | 10 | Correspondem às capas rasterizadas |
| Violação de margem detectável | 0 | Nenhum texto ultrapassou a área observada |
| Caracteres de substituição ou ilegíveis na extração | 0 | Nenhum `�` ou marcador equivalente |
| Altura aparente mínima de palavra | 8,5 | Não há texto extremamente pequeno na camada extraída |
| Altura aparente mediana | 12,26 | Corpo geralmente confortável em impressão |
| Altura aparente máxima | 22,8 | Compatível com títulos e hanzi destacados |
| Espaçamento vertical mediano entre linhas | 16,9 | Hierarquia vertical generosa |

As alturas são medidas das caixas extraídas pelo Poppler e funcionam como indicadores comparativos, não como substitutas de pontos tipográficos do arquivo fonte.

---

## 4. Auditoria de conteúdo e palavras

### 4.1 Conferência automática de presença

Cada unidade passou pela conferência conteúdo↔PDF. O verificador checou entre 18 e 25 itens por unidade, incluindo formas do mapa, palavras-chave, hanzi-alvo, banco de recombinação e fragmentos editoriais ricos.

| Unidade | Resultado | Itens verificados |
|---|---|---:|
| B02 | PASS | 25 |
| B03 | PASS | 23 |
| B04 | PASS | 20 |
| B05 | PASS | 20 |
| B06 | PASS | 20 |
| B07 | PASS | 19 |
| B08 | PASS | 19 |
| B09 | PASS | 18 |
| B10 | PASS | 20 |
| B11 | PASS | 20 |

Não foram encontradas formas centrais ausentes, formas de outra unidade intrusas ou divergências detectáveis entre o JSON de origem e o PDF correspondente.

### 4.2 Resultado linguístico versus resultado de presença

A conferência comprova que as palavras declaradas foram posicionadas no PDF. Ela não comprova, sozinha, que cada palavra esteja correta em mandarim, que o tom esteja adequado ou que a tradução seja natural em português brasileiro.

A distinção é essencial:

> **Presença no PDF não equivale a correção linguística.**

A revisão de cada palavra deve ainda verificar:

- hanzi simplificado correto;
- pinyin com tom correto;
- correspondência entre hanzi e pinyin;
- sentido funcional em português;
- naturalidade da frase completa;
- adequação ao nível iniciante;
- posição da partícula;
- consistência entre forma ensinada e recombinação.

O PDF está pronto para revisão linguística, não para ser considerado linguisticamente publicado sem essa revisão.

### 4.3 Posicionamento das palavras

O posicionamento geral é consistente. As palavras aparecem em três camadas recorrentes:

1. estruturas centrais e mapa de linguagem;
2. banco lexical e cartões de frases;
3. exercícios de recuperação e recombinação.

Essa repetição é pedagogicamente adequada. O problema não é a repetição em si. O risco é a repetição visual muito semelhante, que pode transformar recuperação ativa em simples releitura. Para melhorar, parte das ocorrências deve ser apresentada sem pinyin ou sem tradução, com recuperação antes da consulta.

---

## 5. Auditoria tipográfica

### 5.1 Famílias utilizadas

O PDF incorpora seis variantes principais, repetidas por unidade:

- `NotoSans-Regular`;
- `NotoSans-Bold`;
- `NotoSansCJKsc-Regular`;
- `NotoSansCJKsc-Bold`;
- `LibertinusSerif-Bold`;
- `NotoSansSymbols2-Regular`.

A combinação é funcional. O corpo sem serifa é legível, o hanzi CJK possui uma fonte apropriada e os títulos serifados produzem contraste editorial.

### 5.2 Hierarquia

A hierarquia é uma das forças do material:

- título principal em serifada escura;
- subtítulo em sans discreta;
- barras de seção em azul-marinho, teal e ocre;
- hanzi em escala maior;
- pinyin em cor de apoio;
- tradução em cinza.

A ordem visual é compreensível mesmo antes da leitura integral da página.

### 5.3 Espaçamento entre letras

Não há evidência de problema sistêmico de tracking ou de letras comprimidas. O espaçamento do corpo é confortável. A recomendação não é aumentar globalmente a distância entre letras, porque isso reduziria densidade sem corrigir o problema principal.

Ajustes pontuais recomendados:

| Elemento | Recomendação |
|---|---|
| Labels em caixa alta | Aumentar levemente o tracking apenas se a impressão real parecer fechada |
| Pinyin | Preservar espaçamento atual; priorizar tamanho e contraste |
| Títulos longos | Usar uma largura máxima e quebra controlada, não tracking negativo |
| Tabelas | Aumentar padding vertical antes de alterar tracking |
| Hanzi | Não reduzir tamanho; manter o destaque atual |

### 5.4 Pinyin e tons

O pinyin aparece visualmente separado do hanzi e usa cor própria. Isso favorece a associação entre forma e apoio. A cor vermelha deve ser testada em impressão monocromática ou baixa saturação, pois parte da distinção depende do contraste cromático.

Recomendação: manter cor, mas acrescentar uma distinção de peso ou posição suficientemente clara para que o material continue funcional em escala de cinza.

---

## 6. Auditoria de layout e espaçamento

### 6.1 Problema P0 — tabela de autoavaliação

A página 11 do B02 apresenta o problema mais importante da auditoria. A coluna `Critério` recebe textos longos, mas a altura das linhas não cresce de maneira suficiente. O resultado é quebra vertical excessiva, aproximação entre linhas e perda de leitura.

O problema é visível em critérios como:

- “Reconheço a função de 吗 e 呢”;
- “Pergunto sobre uma pergunta e uma resposta”;
- “Devolvo a pergunta sem encerrar a conversa”;
- “Escrevo uma variação trocando apenas o slot”.

Nas demais unidades, a situação varia. A folha de contato mostra que algumas tabelas funcionam melhor, mas várias ainda dependem de linhas curtas. Portanto, o defeito é sistêmico em potencial, embora apareça com maior severidade quando o critério cresce.

#### Correção recomendada

A tabela deve adotar uma destas soluções:

1. **Altura de linha adaptativa**, permitindo que cada critério cresça verticalmente.
2. **Critérios mais curtos**, escritos como comportamentos observáveis de uma linha.
3. **Tabela vertical**, com cada critério em um bloco e três caixas de autoavaliação abaixo ou ao lado.
4. **Dois grupos de critérios**, reduzindo a densidade da tabela.

A solução preferida é combinar critérios mais curtos com altura adaptativa. Não se deve resolver o problema reduzindo a fonte.

### 6.2 Espaço vazio

O material possui bastante espaço vazio em várias páginas:

- abertura do tópico;
- cartões de frases;
- recuperação;
- recombinação;
- produção prática após as caixas;
- autoavaliação após o bloco de fechamento.

Esse espaço não é necessariamente desperdício. Em um workbook, espaço vazio pode ser área de escrita e pausa cognitiva. O problema é que parte dele não está nomeada nem funcionalmente orientada.

#### Melhor uso do espaço

O espaço deve ser transformado em uma função explícita, por exemplo:

- “Fale antes de escrever”;
- “Minha tentativa sem pinyin”;
- “O que eu ainda confundo”;
- “Segunda tentativa sem olhar”;
- “Produção oral — registre palavras-chave”;
- “Exemplo próprio”;
- “Nota de tom ou pronúncia”.

Reduzir todo o espaço vazio produziria páginas mais densas, mas não necessariamente mais pedagógicas.

### 6.3 Repetição de capas

Cada tópico começa com uma capa completa. Isso facilita separar e imprimir unidades individualmente, mas o workbook consolidado contém dez capas e dez repetições da mesma identidade.

Há duas opções válidas:

| Estratégia | Vantagem | Custo |
|---|---|---|
| Manter dez capas | Permite separar módulos fisicamente | Aumenta repetição e volume |
| Criar uma capa global + divisórias | Workbook mais contínuo e eficiente | Menor autonomia de cada tópico |
| Capa completa no PDF individual e divisória no consolidado | Melhor equilíbrio | Exige dois modos de compilação |

Recomendação: manter capas completas nos PDFs individuais e usar divisórias mais compactas no workbook consolidado.

### 6.4 Separação entre artefato prático e próximo tópico

Na página final, o bloco identificado como `PRÓXIMO TÓPICO` contém o `ARTEFATO PRÁTICO` e, em seguida, a sugestão de continuidade. Visualmente, a transição entre os dois conteúdos é discreta.

Recomendação:

- separar em dois painéis;
- usar uma barra secundária `PRÓXIMA RECUPERAÇÃO`;
- deixar o artefato claramente como produto da unidade atual;
- mover a sugestão futura para um rodapé de continuidade.

---

## 7. Auditoria dos exercícios e instruções

### 7.1 Pontos fortes

As instruções têm verbos operacionais claros, como:

- observe;
- identifique;
- tente;
- escreva;
- ordene;
- mantenha;
- troque;
- produza;
- revise.

A sequência das páginas também é coerente com recuperação, reorganização, recombinação e produção.

A página de produção prática é particularmente funcional. Ela oferece cenário, nível de apoio, campos para resposta e checklist de autonomia.

### 7.2 Problema de orientação oral

Embora o produto seja alinhado à produção oral, muitas caixas de resposta são apresentadas como escrita sem uma instrução explícita e recorrente de falar antes de escrever.

A instrução ideal deve aparecer em todas as páginas de produção:

> **Fale primeiro. Escreva depois. Consulte o mapa somente após a tentativa.**

Isso reduziria o risco de o aluno usar o workbook como apostila de cópia.

### 7.3 Critérios de domínio

As caixas de autoavaliação são úteis, mas precisam ser mais observáveis. Um critério como “Mantenho o sentido” pode ser subjetivo. É melhor escrever:

- “Produzo a pergunta sem olhar o mapa.”
- “Troco o slot sem alterar o restante da estrutura.”
- “Respondo em até cinco segundos.”
- “Uso o tom indicado em três tentativas.”
- “Faço duas variações sem consultar a tradução.”

A autoavaliação deve medir desempenho, não apenas percepção.

### 7.4 Comprimento das instruções

As instruções são geralmente legíveis, mas algumas combinam situação, objetivo e restrição na mesma frase. Para iniciantes, uma estrutura de três passos seria mais clara:

```text
1. Escolha o referente.
2. Produza a pergunta.
3. Responda sem olhar o mapa.
```

Essa forma reduz carga verbal e melhora a execução independente.

---

## 8. Auditoria de páginas por função

| Página funcional | Avaliação | Melhoria principal |
|---|---|---|
| Capa | Visualmente forte | Adicionar texto vivo ou camada acessível |
| Abertura | Clara, mas espaçosa | Nomear o espaço de preparação/reflexão |
| Mapa de linguagem | Boa síntese | Diferenciar melhor “fixo” e “substituível” |
| Banco de palavras | Legível | Indicar quais itens serão recuperados sem apoio |
| Frases de exemplo | Forte visualmente | Acrescentar uma tentativa sem tradução |
| Reconhecimento | Funcional | Tornar o contraste entre alternativas mais explícito |
| Recuperação | Boa área de escrita | Adicionar instrução oral antes da escrita |
| Reorganização | Clara | Incluir critério de autocorreção sem resposta pronta |
| Recombinação | Muito boa ergonomia | Usar o espaço inferior para segunda rodada sem apoio |
| Produção prática | Melhor página pedagógica | Registrar oralidade, tempo ou nível de autonomia |
| Revisão e continuidade | Boa intenção | Corrigir tabela de critérios e separar artefato de próximo tópico |

---

## 9. Teste de estresse visual e editorial

### 9.1 Resultado técnico

Todos os dez PDFs individuais passaram pelo builder e pelo portão conteúdo↔PDF. O consolidado possui 110 páginas, sem páginas vazias e sem margens ultrapassadas detectáveis pela extração de caixas.

### 9.2 Resultado visual

A identidade se manteve estável entre B02 e B11. Não foram observados:

- elementos cortados;
- bordas quebradas;
- colisões entre painéis;
- títulos fora da área;
- páginas com overflow visível nas amostras;
- inconsistência de ornamentos.

Foi observado um problema de sobreposição na tabela de autoavaliação do B02, relacionado ao comprimento dos critérios.

### 9.3 Resultado de densidade

A densidade é baixa a moderada. Isso favorece escrita e leitura, mas deixa oportunidades de uso pedagógico sem rótulo. O próximo ciclo deve decidir uma densidade-alvo por página, em vez de preencher espaço vazio indiscriminadamente.

### 9.4 Resultado de acessibilidade

As capas são imagens rasterizadas. As dez páginas de capa possuem aproximadamente um caractere de texto extraível, enquanto as páginas internas possuem camada textual extraível.

Isso significa que:

- visualmente, as capas funcionam;
- para busca, leitores de tela e indexação, elas são limitadas;
- títulos e códigos das capas deveriam existir como texto vivo ou metadados acessíveis.

### 9.5 Resultado de fontes e arquivo

O PDF contém seis variantes de fonte principais, com subconjuntos repetidos por unidade. Isso não produziu falha visual, mas indica uma oportunidade de otimização do arquivo consolidado.

A otimização de fontes e assets pode reduzir o tamanho final e melhorar distribuição, sem alterar o layout.

---

## 10. Priorização das melhorias

### P0 — Corrigir antes da próxima edição

1. Corrigir a altura das linhas da tabela de autoavaliação.
2. Testar os critérios mais longos de todas as dez unidades, não apenas B02.
3. Garantir que nenhuma linha invada outra ou comprima as caixas de seleção.
4. Separar visualmente artefato prático e próximo tópico.

### P1 — Corrigir na mesma rodada de template

5. Adicionar “fale primeiro, escreva depois” às páginas de recuperação e produção.
6. Transformar espaços vazios principais em áreas nomeadas de tentativa, revisão ou produção oral.
7. Tornar critérios de domínio observáveis e mensuráveis.
8. Adicionar uma versão de divisória compacta para o workbook consolidado.
9. Criar uma camada textual acessível para as capas.

### P2 — Otimizar depois da validação pedagógica

10. Reduzir repetição de assets e subconjuntos de fontes no PDF consolidado.
11. Testar impressão em escala de cinza.
12. Testar leitura em tela pequena e impressão doméstica.
13. Criar variações de template para pedidos, localização, horários e preferências.
14. Adicionar uma aula formal de consolidação após B11.

---

## 11. Critérios objetivos para aprovação da próxima versão

A próxima versão deve ser aprovada somente se:

- nenhuma tabela apresentar sobreposição em critérios curtos, médios e longos;
- todas as caixas de resposta tiverem função explícita;
- cada página de produção indicar fala antes da escrita;
- os títulos e códigos das capas forem pesquisáveis no PDF;
- a conferência conteúdo↔PDF continuar passando para todas as unidades;
- a revisão linguística humana registrar decisões por palavra e frase;
- pelo menos um aluno iniciante conseguir executar as instruções sem explicação oral externa;
- o PDF consolidado for visualmente revisado em escala real de impressão.

---

## 12. Veredito final

O workbook é uma **base visual forte, coerente e tecnicamente reproduzível**. O design não precisa ser reconstruído. Ele precisa ser refinado em torno de três princípios:

```text
menos repetição ornamental
+ mais função explícita para o espaço vazio
+ tabelas adaptáveis ao comprimento real do conteúdo
```

A prioridade absoluta é a tabela de autoavaliação. A segunda prioridade é transformar o espaço vazio em espaço pedagógico intencional. A terceira é reforçar a oralidade nas instruções.

> **O PDF já parece um produto premium. A próxima versão precisa fazer cada centímetro trabalhar melhor para a aprendizagem.**

## Referências

[1]: /home/ubuntu/mandarim-em-rede-workbook-10-topicos.pdf "Workbook consolidado de 10 tópicos analisado"
[2]: /home/ubuntu/mandarim-em-rede-conteudo/scripts/verify_pdf_content.py "Portão conteúdo↔PDF do repositório"
[3]: /home/ubuntu/mandarim-em-rede-conteudo/scripts/validate_pdf_first_v2.py "Validador rich v2 do repositório"
[4]: /home/ubuntu/mandarim-em-rede-conteudo/templates/b-family/B-family-workbook.typ "Template visual da família B"

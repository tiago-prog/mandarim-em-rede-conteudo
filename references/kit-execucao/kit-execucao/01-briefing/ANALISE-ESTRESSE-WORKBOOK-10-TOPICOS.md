# Análise de Estresse + Reanálise Completa
## Workbook Consolidado de 10 Tópicos (B02–B11)
**Mandarim em Rede — Sistema Visual e Escrito**

**Data:** 11 de setembro de 2026  
**Arquivo analisado:** `mandarim-em-rede-workbook-10-topicos.pdf` (110 páginas)  
**Auditoria anterior:** `Auditoria_completa_do_PDF_—_Workbook_de_10_tópicos.pdf`  
**Objetivo deste documento:** Fornecer uma análise consolidada, crítica e acionável para correção do template e do fluxo de produção, com foco no que o consumidor final realmente valoriza.

---

## 1. Veredito Executivo

O workbook consolidado **já possui identidade visual premium, consistência técnica e sequência pedagógica sólida**.  
Ele passa nos portões estruturais e de conteúdo. A geração em massa funciona.

Porém, **ainda não está pronto para publicação comercial final**.

Os problemas reais não são de “identidade quebrada”. São problemas de:

1. **Ergonomia da tabela de autoavaliação** (P0 crítico)
2. **Espaço vazio sem função pedagógica explícita**
3. **Falta de instruções de oralidade recorrentes**
4. **Mistura visual entre Artefato Prático e Próximo Tópico**
5. **Critérios de domínio ainda subjetivos demais**

O material transmite qualidade. O que falta é fazer **cada centímetro trabalhar a favor da aprendizagem e da percepção de valor**.

---

## 2. Análise da Auditoria Anterior

A auditoria feita por outra IA foi, em grande parte, correta e útil. Ela identificou o problema principal e organizou prioridades.

### O que a auditoria acertou

| Ponto | Avaliação |
|-------|-----------|
| Problema da tabela de autoavaliação | Correto e bem diagnosticado |
| Densidade baixa/moderada | Correto |
| Espaço vazio sem função | Correto |
| Separação fraca entre artefato e próximo tópico | Correto |
| Capas rasterizadas (acessibilidade) | Correto |
| Ausência de “fale antes de escrever” | Correto |
| Priorização P0 → P1 → P2 | Boa estrutura |

### O que a auditoria subestimou ou errou

| Ponto | Correção necessária |
|-------|---------------------|
| Tratamento do espaço vazio | Espaço vazio em workbook **não é desperdício**. É valor. O problema é não nomeá-lo. |
| Ênfase excessiva em “refinar densidade” | O consumidor quer **espaço para escrever + volume de prática**. Densidade alta demais reduz valor percebido. |
| Critérios de autoavaliação | Não basta “tornar mais curtos”. Precisam ser **observáveis e mensuráveis**. |
| Capas | A recomendação de divisória no consolidado é boa, mas precisa de política clara de compilação (individual vs consolidado). |
| Valor comercial | A auditoria focou muito em problemas técnicos e pouco no que o aluno **sente** ao usar o material. |

**Conclusão sobre a auditoria:**  
Ela é uma boa base técnica. Esta reanálise complementa com o olhar do consumidor final e com critérios de “material vendável”.

---

## 3. Análise Visual Real (Inspeção Direta)

### 3.1 Problema P0 — Tabela de Autoavaliação

**Severidade:** Crítica  
**Impacto:** Quebra a última página de todas as unidades e transmite “template quebrado”.

**Evidência visual:**
- Página 11 (B02): critérios longos colapsam, texto sobrescreve linhas.
- Página 22 (B03): mesmo padrão.
- Páginas 33, 44, 55, 66, 77, 88, 99 e 110: o problema se repete sempre que o critério passa de ~1 linha.

**Causa raiz:**  
A tabela usa altura de linha fixa (ou insuficiente). Quando o texto do critério cresce, a linha não se expande e o conteúdo invade a linha seguinte.

**Soluções possíveis (em ordem de preferência):**

1. **Altura de linha adaptativa** no Typst + critérios reescritos para no máximo 1 linha.
2. Transformar a tabela em **blocos verticais** (critério + 3 checkboxes abaixo).
3. Dividir em dois grupos de critérios (reduz densidade da tabela).
4. Reduzir fonte (última opção — não recomendado).

**Regra editorial obrigatória:**  
Todo critério de autoavaliação deve ser:
- Observável
- Mensurável
- Escrito como comportamento (não como percepção)
- Máximo 1 linha

**Exemplos de reescrita:**

| Antes (subjetivo / longo) | Depois (observável / curto) |
|---------------------------|-----------------------------|
| Reconheço a função de 吗 e de 呢 | Distingo 吗 de 呢 na pergunta |
| Devolvo a pergunta sem encerrar a conversa | Devolvo a pergunta com 呢 |
| Escrevo uma variação trocando apenas o slot | Troco só o slot e mantenho o resto |
| Mantenho o sentido | Produzo a frase sem mudar a estrutura |
| Leio minha produção em voz alta | Leio em voz alta sem consultar o mapa |

### 3.2 Densidade e Espaço Vazio

**Diagnóstico:**  
A densidade é baixa a moderada. Há espaço generoso em:

- Página de abertura
- Recuperação
- Recombinação
- Produção prática
- Autoavaliação

**Isso não é erro.** Em um workbook de prática, espaço em branco é área de escrita e pausa cognitiva.  
O erro é deixar esse espaço **sem rótulo e sem função**.

**Princípio correto:**  
> Espaço vazio sem nome = desperdício percebido  
> Espaço vazio com função = valor percebido

**Rótulos recomendados (aumentam sensação de completude):**

- “Fale primeiro — escreva depois”
- “Minha tentativa sem olhar o mapa”
- “O que eu ainda confundo”
- “Segunda rodada sem apoio”
- “Produção oral — anote palavras-chave”
- “Meu exemplo próprio”
- “Nota de tom / pronúncia”
- “Correção rápida”

### 3.3 Capas

**Pontos positivos:**
- Identidade visual forte e consistente
- Funcionam bem em PDFs individuais

**Pontos negativos:**
- São imagens rasterizadas (quase sem texto extraível)
- No consolidado de 110 páginas, 10 capas completas geram repetição visual excessiva
- Prejudicam busca e leitores de tela

**Política recomendada:**

| Modo de compilação | Solução |
|--------------------|---------|
| PDF individual (1 tópico) | Capa completa |
| PDF consolidado (10 tópicos) | 1 capa global + divisórias compactas |

### 3.4 Página de Produção Prática

É a **melhor página pedagógica** do material.

Pontos fortes:
- Cenário claro
- Nível de apoio explícito
- Campos de escrita generosos
- Checklist de autonomia

Melhorias de alto impacto:
- Adicionar a instrução fixa: **“Fale primeiro. Escreva depois. Consulte o mapa somente após a tentativa.”**
- Campo opcional para registrar tempo ou nível real de autonomia
- Segunda tentativa sem apoio (quando houver espaço)

### 3.5 Separação Artefato Prático × Próximo Tópico

Na página final os dois conteúdos estão visualmente misturados.

**Problema:**  
O aluno não distingue claramente “o que eu produzi nesta unidade” do “o que vem depois”.

**Correção:**
- Dois painéis distintos
- Barra secundária “PRÓXIMA RECUPERAÇÃO” ou “CONTINUIDADE”
- Artefato Prático permanece como produto da unidade atual
- Sugestão de próximo tópico vai para rodapé ou painel secundário

---

## 4. Análise de Estresse (Stress Test das Ideias)

### 4.1 O que acontece se corrigirmos só a tabela de autoavaliação?

- O PDF deixa de parecer “quebrado”
- A última página de cada unidade volta a ser legível
- Ainda sobra o problema de espaço sem função e falta de oralidade

**Resultado:** Melhora técnica significativa, mas o material ainda não atinge o máximo de valor percebido.

### 4.2 O que acontece se nomearmos os espaços vazios?

- O aluno entende o que fazer em cada área
- A sensação de “material completo” sobe
- A densidade visual aumenta sem aumentar a densidade de texto
- O workbook passa a parecer mais “profissional de aprendizagem” e menos “template bonito”

**Resultado:** Alto impacto comercial com baixo risco técnico.

### 4.3 O que acontece se adicionarmos “Fale primeiro” em todas as páginas de produção/recuperação?

- Reduz o risco de o aluno usar o material como apostila de cópia
- Alinha o produto com a proposta de “da leitura à produção”
- Custa quase zero de layout

**Resultado:** Melhoria pedagógica de alto impacto e baixo custo.

### 4.4 O que acontece se mantivermos critérios longos e só aumentarmos a altura da linha?

- A tabela funciona tecnicamente
- Mas a página final fica visualmente pesada
- O aluno demora mais para se autoavaliar

**Resultado:** Solução incompleta. Critérios curtos + altura adaptativa é superior.

### 4.5 O que acontece se aumentarmos drasticamente a densidade de todas as páginas?

- O material fica “mais cheio”
- Mas perde a sensação de espaço para prática
- Pode parecer mais “apostila densa” do que “workbook premium”

**Resultado:** Risco de reduzir o valor percebido. Não recomendado como política global.

### 4.6 Cenário ideal de correção (recomendado)

1. Corrigir tabela de autoavaliação (altura adaptativa + critérios curtos e observáveis)
2. Nomear os principais espaços vazios
3. Adicionar instrução de oralidade em recuperação e produção
4. Separar visualmente Artefato e Próximo Tópico
5. Manter a densidade atual (baixa/moderada) e transformar o espaço em função

Esse cenário resolve os problemas reais sem destruir a identidade visual nem a proposta de workbook.

---

## 5. O que o Consumidor Final Realmente Quer

| Necessidade do aluno | Situação atual | Gap | Prioridade |
|----------------------|----------------|-----|------------|
| Material que parece completo e caro | Identidade forte | Baixo | — |
| Muita prática real | Existe, mas espaços sem função | Médio | P1 |
| Sensação clara de progresso | Autoavaliação quebrada | Alto | P0 |
| Espaço real para escrever | Existe | Baixo | — |
| Instruções que não deixam dúvida | Boas, mas faltam comandos de oralidade | Médio | P1 |
| Valor percebido alto (“comprei muito”) | 110 páginas ajudam | Médio | P1 |
| Correção fácil dos próprios erros | Fraca | Alto | P0/P1 |
| Sensação de domínio progressivo | Critérios subjetivos | Médio | P1 |

**Insight central:**  
O aluno não compra “páginas bonitas”.  
Ele compra a sensação de que **está praticando de verdade e avançando**.

Tudo que reforça essa sensação (critérios claros, espaços nomeados, oralidade, artefato prático visível) aumenta o valor percebido.

---

## 6. Priorização Consolidada e Acionável

### P0 — Corrigir antes da próxima geração (bloqueadores)

1. **Tabela de autoavaliação**
   - Implementar altura de linha adaptativa
   - Reescrever todos os critérios para no máximo 1 linha e formato observável
   - Testar as 10 páginas finais com critérios curtos, médios e longos

2. **Separação visual Artefato Prático × Próximo Tópico**
   - Dois painéis ou barra secundária clara

### P1 — Mesma rodada de template (alto impacto)

1. Adicionar em recuperação e produção a instrução fixa:  
   **“Fale primeiro. Escreva depois. Consulte o mapa somente após a tentativa.”**

2. Nomear os principais espaços vazios com rótulos pedagógicos.

3. Garantir que todos os critérios de domínio sejam observáveis e mensuráveis.

4. Criar modo de compilação “consolidado” com divisórias compactas.

5. Revisar visualmente as 10 páginas de autoavaliação após a correção.

### P2 — Depois da validação pedagógica

1. Camada textual acessível nas capas
2. Otimização de fontes e assets no consolidado
3. Teste real com 1–2 alunos iniciantes
4. Revisão linguística humana completa (hanzi, pinyin, naturalidade)
5. Possíveis variações de template para tópicos com estrutura muito diferente (horários, localização, pedidos)

---

## 7. Critérios Objetivos para Aprovar a Próxima Versão

A próxima versão só deve ser considerada pronta se:

- [ ] Nenhuma tabela de autoavaliação apresentar sobreposição ou colapso de linha
- [ ] Todos os critérios forem observáveis e caberem em uma linha
- [ ] Artefato Prático e Próximo Tópico estiverem visualmente separados
- [ ] Todas as páginas de recuperação e produção tiverem a instrução de oralidade
- [ ] Os principais espaços vazios tiverem função explícita
- [ ] A conferência conteúdo↔PDF continuar passando em todas as unidades
- [ ] O PDF consolidado for revisado visualmente em escala real (impressão ou zoom 100%)
- [ ] Pelo menos um aluno iniciante conseguir executar as instruções sem explicação oral externa

---

## 8. Recomendações Técnicas para a IA de Correção

### 8.1 Template (Typst)

- Tornar a tabela de autoavaliação com altura de linha adaptativa (`rowspan` ou lógica de altura dinâmica)
- Criar componente reutilizável de “espaço nomeado” (label + área de escrita)
- Criar componente de “instrução de oralidade” reutilizável
- Separar o bloco final em dois painéis distintos

### 8.2 Conteúdo (JSON / Editorial)

- Revisar todos os `criterios_autoavaliacao` das unidades B02–B11
- Garantir máximo 1 linha e formato comportamental
- Verificar se o campo `artefato_pratico` está claro e distinto de `proxima_unidade_sugerida`

### 8.3 Política de compilação

- Manter capa completa nos PDFs individuais
- Implementar divisória compacta no modo consolidado
- Documentar os dois modos no README e no batch

---

## 9. Síntese Final

O workbook de 10 tópicos é uma **base forte e já próxima de produto comercial**.

Não precisa ser reconstruído.  
Precisa ser **refinado com precisão cirúrgica** em três frentes:

1. **Tabela de autoavaliação legível e critérios observáveis** (P0)
2. **Espaço vazio transformado em função pedagógica** (P1)
3. **Oralidade explícita + separação clara na página final** (P1)

Quando esses três pontos forem resolvidos, o material entregará exatamente o que o consumidor final procura:

> Um workbook visualmente premium, com muita prática real, progresso mensurável e sensação clara de que valeu a pena.

---

**Próximo passo recomendado:**  
Usar este documento como briefing para a IA de correção do template, começando pela tabela de autoavaliação e pela reescrita dos critérios de B02 a B11.

---

*Documento gerado a partir de inspeção visual direta do PDF de 110 páginas + reanálise crítica da auditoria anterior + foco no valor percebido pelo consumidor final.*

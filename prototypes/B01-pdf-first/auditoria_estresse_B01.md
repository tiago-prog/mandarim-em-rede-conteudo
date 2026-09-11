# Auditoria de estresse — B01: Cumprimentos em contexto

## Conclusão executiva

O workbook B01 tem uma base visual forte e tecnicamente estável, mas **ainda não deve ser congelado como padrão para todos os tópicos**. O problema principal não é a aparência. O problema está na relação entre **instrução, mecanismo de resposta e critério de conclusão** em algumas atividades.

O PDF passou nos testes de compilação e resistência de conteúdo. Ele mantém 12 páginas A4, preserva a hierarquia visual, acomoda instruções mais longas sem overflow e oferece áreas reais de escrita. No entanto, quatro atividades ainda permitem que um aluno compreenda o tema sem compreender exatamente **o que deve fazer com a página**.

A recomendação é congelar agora apenas o **sistema visual de base** — fundo, paleta, tipografia principal, molduras, cartões e componentes — e fazer uma revisão funcional curta antes de replicar o padrão para os demais tópicos.

## Escopo e método

A auditoria examinou a fonte Typst, o PDF final e uma variante de estresse com instruções deliberadamente mais longas. Foram analisadas as 12 páginas em A4, a extração de texto, os registros de fontes, os campos de escrita, as caixas de conferência, as tabelas, os cartões e a distribuição vertical do conteúdo.

Também foi aplicado um teste prático de autoinstrução: em cada página, a pergunta foi “se o aluno olhar apenas para esta folha, ele sabe qual ação executar, onde registrar a resposta e quando considerar a etapa concluída?”.

## Resultado técnico

| Critério | Resultado | Avaliação |
|---|---:|---|
| Formato | A4, 595,276 × 841,89 pt | Aprovado |
| Páginas | 12 | Aprovado |
| Campos de escrita | 37 | Forte presença do foco escrito |
| Caixas de conferência | 41 | Boa camada de auto-observação |
| Cartões | 26 | Sistema visual consistente |
| Tabelas | 4 | Legíveis e estáveis |
| Fonte mínima detectada | 7,5 pt | Aceitável para micro-rótulos; pequena para instruções recorrentes |
| Hanzi principal | até 28 pt | Muito legível |
| Fontes incorporadas | Noto Sans, Noto Sans CJK SC, Libertinus Serif e Symbols | Aprovado |
| Variante densa | 12 páginas, compilação sem warnings | Resistente |
| Overflow ou página extra | Não observado | Aprovado |

Os campos de escrita variam de 5 mm a 18 mm. Os campos de 8–18 mm são adequados para escrita manual. Os campos de 5–6 mm devem ser tratados como lacunas curtas de uma palavra ou de um caractere, não como áreas gerais de produção. Para um hanzi escrito à mão, a altura de 5 mm é apertada.

## Avaliação página a página

| Página | Função | Clareza atual | Decisão |
|---:|---|---|---|
| 1 | Apresentar promessa, situação e resultado | Alta | Manter; apenas alinhar a promessa à estratégia PDF-first |
| 2 | Observar a situação e registrar uma primeira decisão | Alta | Manter; descrições de até duas linhas e meia funcionam |
| 3 | Consultar palavras e registrar uma palavra | Média-alta | Trocar “ligue” por “marque” ou criar correspondência real |
| 4 | Consultar mapa e recuperar formas | Média-alta | Manter; melhorar a correspondência espacial do mapa |
| 5 | Reconhecer e escrever hanzi | Média | Explicar o que deve ser escrito nos campos dos cartões |
| 6 | Ler pinyin e visualizar tons | Média-baixa | Adicionar legenda operacional para setas e critério das caixas “Leia” |
| 7 | Escolher forma e ligar hanzi ao sentido | Baixa | Redesenhar o mecanismo de resposta das atividades 1 e 2 |
| 8 | Recuperar formas por escrito | Média-alta | Manter; aumentar lacunas de 5–6 mm se forem manuscritas |
| 9 | Reorganizar blocos e reconstruir formas | Baixa | Redesenhar a primeira atividade; atualmente não é executável |
| 10 | Recombinar forma e contexto | Alta | Manter; explicitar o que deve ser escrito em “Minha troca” |
| 11 | Produzir um artefato escrito | Alta | Manter; tornar a leitura em voz alta opcional |
| 12 | Autoavaliar, anotar e revisar | Alta | Manter; indicar quando marcar os critérios |

## Problemas que bloqueiam a replicação

### 1. Instrução e resposta não correspondem

Na página 3, a instrução diz “ligue cada palavra a uma situação”, mas a interface apresenta caixas de seleção e setas já impressas. Na página 7, a atividade 2 repete o mesmo problema: o título manda ligar, mas as setas já estão fornecidas. O aluno entende a associação, porém não executa a ação descrita.

A solução mais simples é escolher uma única modalidade. Se a modalidade for seleção, usar “Marque a combinação correta”. Se a modalidade for ligação, deixar as colunas desalinhadas e fornecer espaço para linhas reais.

### 2. A atividade de escolha não possui mecanismo de registro

Na página 7, “ESCOLHA A FORMA” mostra Opção A e Opção B, mas não existe caixa, círculo ou campo para registrar a escolha. O aluno precisa inferir que deve apenas olhar ou marcar mentalmente.

A atividade deve conter uma coluna “Minha escolha” com uma caixa A/B, ou cada alternativa deve ter uma caixa de seleção. A instrução deve dizer “marque A ou B em cada linha”.

### 3. A reorganização não é executável como está

Na página 9, o título manda colocar blocos em ordem, mas os blocos já estão dispostos na página e os números abaixo parecem uma resposta pronta. Não há campos para o aluno numerar, reescrever ou mover os blocos.

A solução recomendada é usar blocos embaralhados e uma linha de resposta: “ordem: ___ → ___ → ___”. Para a frase de quatro elementos, usar quatro caixas vazias numeradas. Essa solução preserva a impressão comum e não exige recorte.

### 4. Os campos de hanzi não explicam a ação

Na página 5, cada cartão contém um hanzi, pinyin, sentido e um campo vazio. O aluno pode não saber se deve copiar o caractere, cobrir o modelo e recuperar de memória, escrever uma palavra ou registrar uma dificuldade.

Adicionar uma instrução única acima dos cartões: “Observe o hanzi, cubra o modelo e escreva-o uma vez no campo”. A seção inferior deve ter dois rótulos explícitos, como “Hanzi escolhido” e “Palavra ou combinação”.

### 5. A página de tons precisa de legenda

A página 6 usa setas e o símbolo `↯` para representar uma direção visual, mas não explica o que esses sinais significam. Sem uma legenda, o aluno pode interpretar a coluna como direção de leitura, movimento da voz ou decoração.

Como a estratégia agora é 100% PDF, o apoio visual de pinyin e tons precisa ser autossuficiente. A página deve incluir uma microlegenda, por exemplo: “A seta mostra o movimento da voz; leia o pinyin e acompanhe o contorno”. As caixas “Leia” devem vir acompanhadas de “marque depois de ler sem consultar”.

### 6. O workbook ainda contém uma dependência oral implícita

A página 11 orienta o aluno a “ler em voz alta”. Isso não é um problema se a leitura for um convite opcional, mas entra em conflito com uma oferta que não depende de áudio nem de avaliação oral.

A recomendação é substituir por “Releia com atenção; se quiser, leia em voz alta” ou “Compare suas formas com o mapa e revise a escrita”. A produção principal deve continuar sendo observável no papel.

## Tipografia e leitura

A hierarquia tipográfica é uma das forças do protótipo. O título serifado cria identidade, o corpo em Noto Sans é confortável e o hanzi em Noto Sans CJK SC permanece dominante. O pinyin em vermelho é visível sem competir com os caracteres.

A fonte mínima detectada é 7,5 pt, usada principalmente em rótulos. Esse tamanho é aceitável para micro-rótulos curtos, mas deve ser evitado em instruções que o aluno precisa ler repetidamente. A regra recomendada para o template é:

| Elemento | Tamanho recomendado |
|---|---:|
| Título da página | 20 pt |
| Subtítulo | 9–10 pt |
| Instrução operacional | 9,5–10,5 pt |
| Corpo e sentido | 9–10 pt |
| Pinyin | 9–10 pt |
| Rótulo curto | 8–8,5 pt |
| Hanzi de estudo | 22–28 pt |
| Hanzi em tabela | 16–18 pt |

A atualização mais segura é aumentar `label` de 7,5 pt para aproximadamente 8 pt ou 8,5 pt, sem aumentar os títulos de seção. Isso melhora a leitura sem alterar significativamente a distribuição vertical.

## Espaço para escrita

O workbook oferece espaço suficiente nas páginas de produção. As páginas 8, 10, 11 e 12 cumprem bem o compromisso de transformar o material em um produto escrito.

O principal cuidado está nos campos de 5–6 mm. Eles são visualmente elegantes, mas não devem ser usados para escrita manual livre. Para lacunas de um hanzi ou de uma sílaba curta, recomenda-se altura de pelo menos 7 mm. Para respostas próprias, manter 9–18 mm.

O espaço vazio na parte inferior de várias páginas não é automaticamente um defeito. Ele protege a composição, mantém visíveis as montanhas e evita que o material pareça comprimido. Entretanto, quando uma página contém uma atividade subespecificada, esse espaço deve ser usado para melhorar a resposta — por exemplo, com uma caixa de escolha, uma linha de ordem ou uma microinstrução — e não com texto decorativo.

## Limite de densidade

A variante densa adicionou instruções mais longas em situações, tabelas e páginas de produção. O sistema continuou em 12 páginas, sem warnings, sem overflow e sem quebra de hierarquia.

O teste indica que o template suporta uma microinstrução operacional de uma ou duas linhas por seção. Quando um cartão recebe um parágrafo adicional, ele continua compilando, mas a explicação começa a competir com a área de escrita. Conteúdo conceitual mais longo deve ir para um guia separado ou para uma página específica de explicação.

A regra de produção recomendada é: **uma ação, um mecanismo de resposta e um critério de conclusão por seção**. Se uma seção exigir uma quarta explicação, ela provavelmente precisa ser dividida.

## Critérios para congelar o template

Antes de usar o padrão B01 nos demais tópicos, a revisão deve cumprir os seguintes critérios:

| Critério de aprovação | Meta |
|---|---|
| O aluno identifica a ação em até 5 segundos | 5 de 5 páginas testadas |
| O aluno sabe onde registrar a resposta | 100% das atividades |
| O verbo da instrução corresponde ao mecanismo visual | 100% das atividades |
| As áreas de escrita principais têm pelo menos 8 mm | 100% das respostas livres |
| Instruções recorrentes têm pelo menos 9 pt | 100% das microinstruções |
| Nenhuma atividade depende de explicação oral externa | 100% do workbook principal |
| O PDF mantém 12 páginas sob conteúdo denso | Sim |
| O aluno consegue distinguir hanzi, pinyin e sentido | Sim, em teste de uso |

## Decisão

O B01 está aprovado como **protótipo visual e estrutural**, mas não como template pedagógico congelado. A próxima iteração deve corrigir cinco pontos: mecanismo de resposta da página 3, escolha e ligação da página 7, reorganização da página 9, instrução dos campos de hanzi da página 5 e legenda de tons da página 6. Também deve tornar a leitura em voz alta opcional e elevar discretamente os micro-rótulos.

Depois dessas correções, o B01 pode ser usado como padrão para os demais tópicos. A expansão de conteúdo deve preservar a arquitetura, mas não copiar atividades que ainda não têm uma ação observável no papel.

## Referências

[1]: https://github.com/tiago-prog/mandarim-em-rede-conteudo "Repositório do conteúdo do Mandarim em Rede"

[2]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/tree/main/prototypes/B01-pdf-first "Protótipo B01 visual e escrito"

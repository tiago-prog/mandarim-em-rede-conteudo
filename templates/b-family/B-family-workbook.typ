#import "report-theme.typ": report-theme

#let navy = rgb("#173754")
#let teal = rgb("#367D86")
#let ochre = rgb("#C99E4A")
#let red = rgb("#C94D3F")
#let cream = rgb("#FFFDF8")
#let warm = rgb("#FDF8EE")
#let mint = rgb("#EEF6F2")
#let pink = rgb("#FCEEEB")
#let gray = rgb("#66727B")
#let ink = rgb("#24323D")
#let line = rgb("#D7CDBB")

#let data = json("content.json")
#let unit = data.unidade
#let structures = unit.estruturas
#let first = structures.at(0)
#let second = structures.at(1)
#let third = structures.at(2)
#let fourth = if structures.len() > 3 { structures.at(3) } else { first }
#let fifth = if structures.len() > 4 { structures.at(4) } else { first }
#let sixth = if structures.len() > 5 { structures.at(5) } else { second }
#let seventh = if structures.len() > 6 { structures.at(6) } else { third }
#let words = (
  (hanzi: "我", pinyin: "wǒ", meaning: "eu / me", use: "resposta"),
  (hanzi: "是", pinyin: "shì", meaning: "ser", use: "identidade"),
  (hanzi: "学生", pinyin: "xuésheng", meaning: "estudante", use: "ocupação"),
  (hanzi: "老师", pinyin: "lǎoshī", meaning: "professor(a)", use: "ocupação"),
  (hanzi: "吗", pinyin: "ma", meaning: "pergunta sim/não", use: "pergunta"),
  (hanzi: "呢", pinyin: "ne", meaning: "e você?", use: "devolução"),
  (hanzi: "好", pinyin: "hǎo", meaning: "bem / bom", use: "estado"),
  (hanzi: "忙", pinyin: "máng", meaning: "ocupado", use: "estado"),
)

#show: report-theme.with(
  title: [Mandarim em Rede — #unit.codigo #unit.titulo],
  author: "Mandarim em Rede",
  rhythm: "report",
  body-size: 10.5pt,
  running-header: false,
)
#set page(paper: "a4", margin: (top: 14mm, bottom: 14mm, x: 14mm), background: image("assets/bg-fundo-prime.png", width: 210mm, height: 297mm), numbering: none)
#set text(font: ("Noto Sans", "Noto Sans CJK SC"), size: 10pt, fill: ink, lang: "pt")
#set par(justify: false, leading: 0.98em, spacing: 0.45em, first-line-indent: 0pt)

#let cjk(body, size: 20pt, color: navy) = text(font: "Noto Sans CJK SC", size: size, weight: "bold", fill: color)[#body]
#let label(txt, color: navy) = text(size: 8pt, weight: "bold", fill: color, tracking: 0.35pt)[#txt]
#let page-title(txt, sub: none) = { align(center)[#text(size: 20pt, weight: "bold", fill: navy, font: ("Libertinus Serif", "Noto Serif CJK SC"))[#txt]; #if sub != none { v(2pt); text(size: 9pt, fill: gray)[#sub] }]; v(5pt) }
#let section(txt, color: navy) = { box(width: 100%, inset: (x: 7pt, y: 4pt), fill: color, radius: 4pt)[#text(size: 9.5pt, weight: "bold", fill: cream)[#txt]]; v(4pt) }
#let panel(body, fill: cream, stroke: navy, inset: 7pt) = box(width: 100%, inset: inset, fill: fill, stroke: 0.8pt + stroke, radius: 5pt)[#body]
#let card(body, fill: cream, stroke: navy) = box(width: 100%, inset: 6pt, fill: fill, stroke: 0.75pt + stroke, radius: 5pt)[#body]
#let check(txt, color: navy) = grid(columns: (10pt, 1fr), column-gutter: 4pt, [#box(width: 8pt, height: 8pt, stroke: 0.8pt + color, fill: cream)], [#txt])
#let writebox(height: 8mm, color: teal) = box(width: 100%, height: height, fill: cream, stroke: 0.8pt + color, radius: 3pt)
#let small(body) = text(size: 8.5pt, fill: gray)[#body]
#let tcell(body, fill: cream) = table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#body]
#let word-row(word, fill: cream) = (
  table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#cjk(word.hanzi, size: 16pt)],
  table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#text(size: 9pt, fill: red)[#word.pinyin]],
  table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#word.meaning],
  table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#word.use],
)
#let structure-card(item, fill: cream, stroke: navy) = card([
  #label(item.tipo, color: stroke)
  #v(3pt)
  #cjk(item.mandarim, size: 19pt)
  #v(2pt)
  #text(size: 9pt, fill: red)[#item.pinyin]
  #v(2pt)
  #small[#item.sentido_funcional]
], fill: fill, stroke: stroke)

#page(margin: 0pt, background: image("assets/capa-workbook.png", width: 210mm, height: 297mm))[]

#page[
  #align(center)[#label("COLEÇÃO 01 · PRIMEIRAS INTERAÇÕES", color: ochre); #v(5pt); #page-title(unit.titulo, sub: [#unit.codigo · workbook visual e escrito])]
  #section("O QUE VOCÊ VAI CONSEGUIR FAZER", color: navy)
  #panel(fill: warm, stroke: ochre)[#text(size: 12pt, weight: "bold", fill: navy)[#unit.objetivo_comunicativo]; #v(5pt); #small[#unit.situacao_principal]]
  #v(7pt)
  #section("RESULTADO MÍNIMO", color: ochre)
  #panel(fill: cream, stroke: navy)[#text(size: 10.5pt)[#unit.resultado_minimo]; #v(7pt); #align(center)[#text(size: 9pt, weight: "bold", fill: ochre)[SITUAR → OBSERVAR → RECONHECER → PRODUZIR]]]
  #v(8pt)
  #section("ANTES DE COMEÇAR", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Observe quem pergunta.])], [#check([Identifique o que deve responder.])], [#check([Tente antes de consultar.])], [#check([Registre sua dúvida.])])]
]

#page[
  #page-title("Mapa de linguagem", sub: "O que fica, o que muda e como devolver")
  #section("ESTRUTURAS CENTRAIS", color: navy)
  #grid(columns: (1fr, 1fr), gutter: 6pt, structure-card(first, fill: cream, stroke: navy), structure-card(second, fill: warm, stroke: ochre), structure-card(third, fill: mint, stroke: teal), structure-card(fourth, fill: pink, stroke: red))
  #v(8pt)
  #section("MAPA DE DECISÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#small[Leia cada linha da esquerda para a direita.]; #v(4pt); #grid(columns: (1.3fr, 12mm, 1.5fr), gutter: 4pt, [#label("INTENÇÃO", color: navy)], [#text(size: 15pt, fill: ochre)[→]], [#label("FORMA", color: navy)], [Perguntar], [#text(size: 13pt)[→]], [#cjk(first.mandarim, size: 15pt)], [Responder], [#text(size: 13pt)[→]], [#cjk(second.mandarim, size: 15pt)], [Devolver a pergunta], [#text(size: 13pt)[→]], [#cjk(seventh.mandarim, size: 15pt)])]
]

#page[
  #page-title("Banco de palavras", sub: "Clareza lexical para usar nas estruturas")
  #section("PALAVRAS DO TÓPICO", color: navy)
  #small[Cada item deve reaparecer em uma frase, uma lacuna ou uma produção. A lista serve para consulta e recuperação.]
  #v(5pt)
  #table(
    columns: (1.1fr, 0.95fr, 1.3fr, 1.25fr),
    inset: 0pt,
    stroke: 0.45pt + line,
    align: center + horizon,
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Hanzi]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Pinyin]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Sentido]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Uso]], fill: navy),
    tcell([#cjk("我", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[wǒ]], fill: cream), tcell([eu / me], fill: cream), tcell([resposta], fill: cream),
    tcell([#cjk("是", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[shì]], fill: warm), tcell([ser], fill: warm), tcell([identidade], fill: warm),
    tcell([#cjk("学生", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[xuésheng]], fill: cream), tcell([estudante], fill: cream), tcell([ocupação], fill: cream),
    tcell([#cjk("老师", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[lǎoshī]], fill: warm), tcell([professor(a)], fill: warm), tcell([ocupação], fill: warm),
    tcell([#cjk("吗", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[ma]], fill: cream), tcell([pergunta sim/não], fill: cream), tcell([pergunta], fill: cream),
    tcell([#cjk("呢", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[ne]], fill: warm), tcell([e você?], fill: warm), tcell([devolução], fill: warm),
    tcell([#cjk("好", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[hǎo]], fill: cream), tcell([bem / bom], fill: cream), tcell([estado], fill: cream),
    tcell([#cjk("忙", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[máng]], fill: warm), tcell([ocupado], fill: warm), tcell([estado], fill: warm),
  )
  #v(8pt)
  #section("MINHA PALAVRA MAIS IMPORTANTE", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (30mm, 1fr), gutter: 6pt, [#label("HANZI", color: ochre)], [#writebox(height: 9mm, color: ochre)], [#label("FRASE OU USO", color: ochre)], [#writebox(height: 9mm, color: ochre)])]
]

#page[
  #page-title("Frases de exemplo", sub: "Leia como a referência: forma, apoio e sentido")
  #section("CARTÕES DE FRASE", color: navy)
  #for item in structures.slice(0, calc.min(structures.len(), 6)) {
    card([
      #grid(columns: (22mm, 1fr), gutter: 6pt, [#label("FUNÇÃO", color: navy); #v(3pt); #small[#item.funcao]], [#cjk(item.mandarim, size: 17pt); #v(2pt); #text(size: 9pt, fill: red)[#item.pinyin]; #v(2pt); #small[#item.sentido_funcional]])
    ], fill: if item.tipo == "particula" { warm } else { cream }, stroke: if item.tipo == "particula" { ochre } else { navy })
    v(4pt)
  }
  #v(4pt)
  #panel(fill: mint, stroke: teal)[#small[Leia uma frase em pinyin, cubra o apoio e tente recuperar a intenção em português.]; #v(4pt); #writebox(height: 13mm, color: teal)]
]

#page[
  #page-title("Reconhecer", sub: "Ligue pergunta, resposta e situação")
  #section("ESCOLHA A FORMA ADEQUADA", color: navy)
  #panel(fill: cream, stroke: navy)[#small[Marque a estrutura que combina com cada situação.]; #v(5pt); #grid(columns: (1.5fr, 1fr, 1fr, 0.7fr), gutter: 5pt, [#label("Situação", color: navy)], [#label("A", color: navy)], [#label("B", color: navy)], [#label("Escolha", color: navy)], [Perguntar sobre estudante], [#cjk(first.mandarim, size: 15pt)], [#cjk(second.mandarim, size: 15pt)], [#writebox(height: 7mm, color: navy)], [Responder afirmativamente], [#cjk(second.mandarim, size: 15pt)], [#cjk(fourth.mandarim, size: 15pt)], [#writebox(height: 7mm, color: navy)], [Devolver a pergunta], [#cjk(seventh.mandarim, size: 15pt)], [#cjk(fifth.mandarim, size: 15pt)], [#writebox(height: 7mm, color: navy)])]
  #v(8pt)
  #section("CONFIRA A RELAÇÃO", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Reconheci a função da partícula.])], [#check([Separei pergunta e resposta.])], [#check([Identifiquei o sentido.])], [#check([Entendi a devolução.])])]
  #v(8pt)
  #section("MINHA DÚVIDA", color: ochre)
  #panel(fill: warm, stroke: ochre)[#writebox(height: 18mm, color: ochre)]
]

#page[
  #page-title("Recuperação", sub: "Tente primeiro; confira depois")
  #section("COMPLETE A FORMA", color: navy)
  #panel(fill: cream, stroke: navy)[#grid(columns: (42mm, 1fr, 25mm), gutter: 6pt, [#label("Função", color: navy)], [#label("Minha resposta", color: navy)], [#label("Conferi", color: navy)], [Perguntar], [#writebox(height: 9mm, color: teal)], [#check([ ])], [Responder], [#writebox(height: 9mm, color: teal)], [#check([ ])], [Devolver], [#writebox(height: 9mm, color: teal)], [#check([ ])])]
  #v(8pt)
  #section("RECUPERE UM HANZI", color: teal)
  #panel(fill: mint, stroke: teal)[#small[Escreva um caractere que aparece em pelo menos duas formas do tópico.]; #v(4pt); #grid(columns: (35mm, 1fr), gutter: 6pt, [#label("HANZI", color: teal)], [#writebox(height: 12mm, color: teal)], [#label("PALAVRA", color: teal)], [#writebox(height: 12mm, color: teal)])]
  #v(8pt)
  #section("O QUE ACONTECEU?", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Lembrei sem copiar.])], [#check([Consultei depois da tentativa.])], [#check([Corrigi uma forma.])], [#check([Li em voz alta.])])]
]

#page[
  #page-title("Reorganizar", sub: "Entenda a sequência antes de produzir")
  #section("ORDENE OS BLOCOS", color: navy)
  #panel(fill: cream, stroke: navy)[#small[Escreva a ordem dos blocos para formar uma pergunta ou resposta.]; #v(5pt); #grid(columns: (1fr, 1fr, 1fr), gutter: 5pt, [#card([#cjk("吗", size: 18pt)], fill: warm, stroke: ochre)], [#card([#cjk("你是学生", size: 18pt)], fill: mint, stroke: teal)], [#card([#cjk("？", size: 15pt)], fill: cream, stroke: navy)]); #v(5pt); #grid(columns: (22mm, 1fr), gutter: 6pt, [#label("ORDEM", color: navy)], [#writebox(height: 9mm, color: navy)])]
  #v(8pt)
  #section("RECONSTRUA SEM MODELO", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#label("Pergunta", color: teal)], [#label("Escreva", color: teal)], [Você é professor(a)?], [#writebox(height: 10mm, color: teal)], [E você?], [#writebox(height: 10mm, color: teal)])]
  #v(8pt)
  #section("MARQUE", color: ochre)
  #panel(fill: warm, stroke: ochre)[#check([Percebi a posição da partícula.]); #v(3pt); #check([Consegui reconstruir sem copiar.])]
]

#page[
  #page-title("Recombinar", sub: "Mantenha a estrutura; troque o slot")
  #section("BANCO PARA TROCAR", color: navy)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 6pt, card([#label("OCUPAÇÃO", color: navy); #v(4pt); #cjk("学生", size: 20pt); #v(2pt); #small[xuésheng]], fill: cream, stroke: navy), card([#label("OCUPAÇÃO", color: ochre); #v(4pt); #cjk("老师", size: 20pt); #v(2pt); #small[lǎoshī]], fill: warm, stroke: ochre), card([#label("ESTADO", color: teal); #v(4pt); #cjk("忙", size: 20pt); #v(2pt); #small[máng]], fill: mint, stroke: teal))
  #v(8pt)
  #section("MINHAS VARIAÇÕES", color: teal)
  #panel(fill: mint, stroke: teal)[#small[Escreva três trocas controladas. Mantenha o início da pergunta e altere somente o elemento necessário.]; #v(5pt); #grid(columns: (35mm, 1fr), gutter: 6pt, [#label("ESTRUTURA", color: teal)], [#label("MINHA TROCA", color: teal)], [你是 … 吗？], [#writebox(height: 10mm, color: teal)], [我 …。], [#writebox(height: 10mm, color: teal)], [你 … 呢？], [#writebox(height: 10mm, color: teal)])]
  #v(8pt)
  #section("USEI A ESTRUTURA", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Troquei apenas o slot.])], [#check([Mantive o sentido.])])]
]

#page[
  #page-title("Produção prática", sub: "Transfira para uma conversa curta")
  #section("CENÁRIO 1 · COM APOIO", color: navy)
  #panel(fill: cream, stroke: navy)[#text(size: 10pt)[Você acabou de cumprimentar alguém em uma aula. Descubra se a pessoa é estudante ou professor(a), responda sobre você e devolva uma pergunta.]; #v(6pt); #grid(columns: (1fr, 1fr), gutter: 6pt, [#label("PERGUNTA", color: navy); #v(4pt); #writebox(height: 15mm, color: navy)], [#label("RESPOSTA + DEVOLUÇÃO", color: teal); #v(4pt); #writebox(height: 15mm, color: teal)])]
  #v(8pt)
  #section("CENÁRIO 2 · MENOS APOIO", color: red)
  #panel(fill: pink, stroke: red)[#text(size: 10pt)[Escreva três trocas novas usando pelo menos duas estruturas do mapa.]; #v(5pt); #writebox(height: 28mm, color: red)]
  #v(8pt)
  #section("NÍVEL DE APOIO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (1fr, 1fr, 1fr), gutter: 5pt, [#check([Usei hanzi + pinyin.])], [#check([Usei apoio parcial.])], [#check([Produzi sem o mapa.])])]
]

#page[
  #page-title("Revisar e continuar", sub: "Feche o tópico e prepare a próxima recuperação")
  #section("AUTOAVALIAÇÃO", color: navy)
  #panel(fill: cream, stroke: navy)[#table(columns: (1.6fr, 1fr, 1fr, 1fr), inset: 0pt, stroke: 0.45pt + line, align: center + horizon, table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Critério]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Ainda não]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Com apoio]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Sem mapa]], [Reconheço a função das estruturas], [☐], [☐], [☐], [Completo uma pergunta e uma resposta], [☐], [☐], [☐], [Devolvo a pergunta], [☐], [☐], [☐], [Escrevo uma variação], [☐], [☐], [☐], [Leio minha produção], [☐], [☐], [☐])]
  #v(8pt)
  #section("REVISÃO PROGRAMADA", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#label("EM 24 HORAS", color: teal); #v(3pt); #writebox(height: 10mm, color: teal)], [#label("EM 7 DIAS", color: teal); #v(3pt); #writebox(height: 10mm, color: teal)])]
  #v(8pt)
  #section("PRÓXIMO TÓPICO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#small[#unit.proxima_unidade_sugerida]; #v(4pt); #grid(columns: (1fr, 1fr), gutter: 6pt, [#label("AINDA PRECISO PRATICAR", color: red); #v(3pt); #writebox(height: 13mm, color: red)], [#label("MINHA OBSERVAÇÃO", color: teal); #v(3pt); #writebox(height: 13mm, color: teal)])]
]

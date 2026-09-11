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

#show: report-theme.with(
  title: "Mandarim em Rede — B01 Cumprimentos em contexto",
  author: "Mandarim em Rede",
  rhythm: "report",
  body-size: 10.5pt,
  running-header: false,
)

#set page(
  paper: "a4",
  margin: (top: 14mm, bottom: 14mm, x: 14mm),
  background: image("assets/bg-fundo-prime.png", width: 210mm, height: 297mm),
  numbering: none,
)
#set text(font: ("Noto Sans", "Noto Sans CJK SC"), size: 10pt, fill: ink, lang: "pt")
#set par(justify: false, leading: 0.98em, spacing: 0.45em, first-line-indent: 0pt)

#let cjk(body, size: 20pt, color: navy) = text(font: "Noto Sans CJK SC", size: size, weight: "bold", fill: color)[#body]
#let label(txt, color: navy) = text(size: 7.5pt, weight: "bold", fill: color, tracking: 0.35pt)[#txt]
#let page-title(txt, sub: none) = {
  align(center)[
    #text(size: 20pt, weight: "bold", fill: navy, font: ("Libertinus Serif", "Noto Serif CJK SC"))[#txt]
    #if sub != none { v(2pt); text(size: 9pt, fill: gray)[#sub] }
  ]
  v(5pt)
}
#let section(txt, color: navy) = {
  box(width: 100%, inset: (x: 7pt, y: 4pt), fill: color, radius: 4pt)[
    #text(size: 9.5pt, weight: "bold", fill: cream)[#txt]
  ]
  v(4pt)
}
#let panel(body, fill: cream, stroke: navy, inset: 7pt) = box(width: 100%, inset: inset, fill: fill, stroke: 0.8pt + stroke, radius: 5pt)[#body]
#let card(body, fill: cream, stroke: navy) = box(width: 100%, inset: 6pt, fill: fill, stroke: 0.75pt + stroke, radius: 5pt)[#body]
#let check(txt, color: navy) = grid(columns: (10pt, 1fr), column-gutter: 4pt, [#box(width: 8pt, height: 8pt, stroke: 0.8pt + color, fill: cream)], [#txt])
#let writebox(height: 8mm, color: teal) = box(width: 100%, height: height, fill: cream, stroke: 0.8pt + color, radius: 3pt)
#let answerline(width: 35mm, color: teal) = box(width: width, height: 6mm, fill: cream, stroke: 0.9pt + color, radius: 3pt)
#let tcell(body, fill: none) = table.cell(fill: fill, inset: (x: 4pt, y: 3.5pt))[#body]
#let small(body) = text(size: 8.5pt, fill: gray)[#body]

// Página 1 — capa funcional.
#page[
  #align(center)[
    #label("COLEÇÃO 01 · PRIMEIRAS INTERAÇÕES", color: ochre)
    #v(5pt)
    #page-title("Cumprimentos em contexto", sub: "B01 · workbook visual e escrito")
  ]
  #section("O QUE VOCÊ VAI CONSEGUIR FAZER", color: navy)
  #panel(fill: warm, stroke: ochre)[
    #text(size: 12pt, weight: "bold", fill: navy)[Escolher um cumprimento conforme a situação e registrar a forma em hanzi, pinyin e escrita própria.]
    #v(5pt)
    #small[Você vai trabalhar com pessoa nova, respeito, grupo e telefone.]
  ]
  #v(7pt)
  #section("A SITUAÇÃO", color: teal)
  #grid(columns: (1fr, 1fr), gutter: 6pt,
    [#card([
      #label("VOCÊ OBSERVA", color: teal)
      #v(4pt)
      #text(size: 14pt, weight: "bold", fill: navy)[Quem está presente?]
      #v(3pt)
      #small[Uma pessoa, uma professora, um grupo ou uma chamada.]
    ], fill: mint, stroke: teal)],
    [#card([
      #label("VOCÊ PRODUZ", color: red)
      #v(4pt)
      #text(size: 14pt, weight: "bold", fill: navy)[Qual forma combina?]
      #v(3pt)
      #small[Escolha, escreva, leia e use em uma cena nova.]
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("RESULTADO MÍNIMO", color: ochre)
  #panel(fill: cream, stroke: navy)[
    #grid(columns: (1fr, 1fr, 1fr), gutter: 5pt,
      [#align(center)[#cjk("你好", size: 18pt); #v(2pt); #small[pessoa nova]]],
      [#align(center)[#cjk("您好", size: 18pt); #v(2pt); #small[respeito]]],
      [#align(center)[#cjk("大家好", size: 18pt); #v(2pt); #small[grupo]]],
    )
    #v(6pt)
    #text(size: 9.5pt)[Ao final, você identifica a situação, escreve uma forma adequada e produz uma abertura curta sem consultar a tabela principal.]
  ]
  #v(8pt)
  #align(center)[
    #text(size: 9pt, weight: "bold", fill: ochre)[SITUAR  →  OBSERVAR  →  ESCREVER  →  PRODUZIR]
  ]
]

// Página 2 — situação visual.
#page[
  #page-title("A situação", sub: "Observe antes de escolher")
  #section("CENA PRINCIPAL", color: navy)
  #panel(fill: cream, stroke: navy)[
    #grid(columns: (1fr, 1fr), gutter: 8pt,
      [#card([
        #label("CENA A · UMA PESSOA", color: navy)
        #v(5pt)
        #align(center)[#text(size: 23pt, fill: navy)[○  ○]]
        #v(3pt)
        #align(center)[#text(size: 9pt)[Você conhece uma pessoa nova.]]
        #v(5pt)
        #align(center)[#cjk("你好", size: 19pt)]
      ], fill: warm, stroke: navy)],
      [#card([
        #label("CENA B · UMA PROFESSORA", color: ochre)
        #v(5pt)
        #align(center)[#text(size: 23pt, fill: ochre)[○  ▲]]
        #v(3pt)
        #align(center)[#text(size: 9pt)[Você demonstra respeito.]]
        #v(5pt)
        #align(center)[#cjk("您好", size: 19pt)]
      ], fill: cream, stroke: ochre)],
      [#card([
        #label("CENA C · UM GRUPO", color: teal)
        #v(5pt)
        #align(center)[#text(size: 23pt, fill: teal)[○  ○  ○]]
        #v(3pt)
        #align(center)[#text(size: 9pt)[Você fala com várias pessoas.]]
        #v(5pt)
        #align(center)[#cjk("大家好", size: 19pt)]
      ], fill: mint, stroke: teal)],
      [#card([
        #label("CENA D · TELEFONE", color: red)
        #v(5pt)
        #align(center)[#text(size: 23pt, fill: red)[▣  ·  ·  ·]]
        #v(3pt)
        #align(center)[#text(size: 9pt)[Você atende uma chamada.]]
        #v(5pt)
        #align(center)[#cjk("喂", size: 19pt)]
      ], fill: pink, stroke: red)],
    )
  ]
  #v(8pt)
  #section("ANTES DE ESCREVER", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([Quem está presente?])], [#check([Onde acontece?])],
      [#check([É uma pessoa ou um grupo?])], [#check([É uma conversa ou um telefone?])],
    )
  ]
  #v(8pt)
  #section("MINHA DECISÃO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #small[Escolha uma cena e escreva a forma que você usaria.]
    #v(4pt)
    #grid(columns: (22mm, 1fr), gutter: 6pt,
      [#label("CENA", color: teal)], [#writebox(height: 9mm, color: teal)],
      [#label("FORMA", color: teal)], [#writebox(height: 9mm, color: teal)],
    )
  ]
]

// Página 3 — banco de palavras.
#page[
  #page-title("Banco de palavras", sub: "Veja, leia e use")
  #section("PALAVRAS DO TÓPICO", color: navy)
  #small[Leia o hanzi, acompanhe o pinyin e ligue cada palavra a uma situação.]
  #v(5pt)
  #table(
    columns: (1.1fr, 0.9fr, 1.15fr, 1.35fr),
    inset: 0pt,
    stroke: 0.45pt + line,
    align: center + horizon,
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Hanzi]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Pinyin]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Sentido]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Use na cena]], fill: navy),
    tcell([#cjk("人", size: 18pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[rén]], fill: cream), tcell([pessoa], fill: cream), tcell([pessoa nova], fill: cream),
    tcell([#cjk("老师", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[lǎoshī]], fill: warm), tcell([professora], fill: warm), tcell([respeito], fill: warm),
    tcell([#cjk("大家", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[dàjiā]], fill: cream), tcell([as pessoas], fill: cream), tcell([grupo], fill: cream),
    tcell([#cjk("电话", size: 16pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[diànhuà]], fill: warm), tcell([telefone], fill: warm), tcell([chamada], fill: warm),
    tcell([#cjk("朋友", size: 16pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[péngyou]], fill: cream), tcell([amigo], fill: cream), tcell([pessoa conhecida], fill: cream),
    tcell([#cjk("好", size: 18pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[hǎo]], fill: warm), tcell([bem / bom], fill: warm), tcell([todas as saudações], fill: warm),
  )
  #v(8pt)
  #section("LIGUE PALAVRA E SITUAÇÃO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([人 → pessoa nova])], [#check([老师 → respeito])],
      [#check([大家 → grupo])], [#check([电话 → chamada])],
      [#check([朋友 → relação conhecida])], [#check([好 → saudação])],
    )
  ]
  #v(8pt)
  #section("UMA PALAVRA QUE EU QUERO LEMBRAR", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (32mm, 1fr), gutter: 6pt,
      [#label("HANZI", color: ochre)], [#writebox(height: 9mm, color: ochre)],
      [#label("COMBINAÇÃO", color: ochre)], [#writebox(height: 9mm, color: ochre)],
    )
  ]
]

// Página 4 — mapa de estruturas.
#page[
  #page-title("Mapa de linguagem", sub: "O que fica e o que muda")
  #section("QUATRO FORMAS CENTRAIS", color: navy)
  #grid(columns: (1fr, 1fr), gutter: 6pt,
    [#card([
      #label("FIXA · PESSOA NOVA", color: navy)
      #v(4pt)
      #cjk("你好。", size: 22pt)
      #v(2pt)
      #text(size: 9pt, fill: red)[Nǐ hǎo.]
      #v(2pt)
      #small[Olá.]
    ], fill: cream, stroke: navy)],
    [#card([
      #label("FIXA · RESPEITO", color: ochre)
      #v(4pt)
      #cjk("您好。", size: 22pt)
      #v(2pt)
      #text(size: 9pt, fill: red)[Nín hǎo.]
      #v(2pt)
      #small[Olá, com respeito.]
    ], fill: warm, stroke: ochre)],
    [#card([
      #label("FIXA · GRUPO", color: teal)
      #v(4pt)
      #cjk("大家好。", size: 22pt)
      #v(2pt)
      #text(size: 9pt, fill: red)[Dàjiā hǎo.]
      #v(2pt)
      #small[Olá para o grupo.]
    ], fill: mint, stroke: teal)],
    [#card([
      #label("FIXA · TELEFONE", color: red)
      #v(4pt)
      #cjk("喂？", size: 22pt)
      #v(2pt)
      #text(size: 9pt, fill: red)[Wéi?]
      #v(2pt)
      #small[Alô?]
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("MAPA DE DECISÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (1fr, 12mm, 1fr), gutter: 4pt, align: center + horizon,
      [#label("QUEM?", color: navy)], [#text(size: 16pt, weight: "bold", fill: ochre)[→]], [#label("QUAL FORMA?", color: navy)],
      [Pessoa nova], [#text(size: 13pt)[→]], [#cjk("你好", size: 17pt)],
      [Pessoa com respeito], [#text(size: 13pt)[→]], [#cjk("您好", size: 17pt)],
      [Grupo], [#text(size: 13pt)[→]], [#cjk("大家好", size: 17pt)],
      [Telefone], [#text(size: 13pt)[→]], [#cjk("喂", size: 17pt)],
    )
  ]
  #v(8pt)
  #section("MAPA LACUNADO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.8pt + teal, radius: 3pt)[
        #grid(columns: (12mm, auto), align: horizon, [#box(width: 12mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)], [#cjk("好。", size: 16pt)])
      ]],
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.8pt + teal, radius: 3pt)[
        #grid(columns: (auto, 12mm, auto), align: horizon, [#cjk("大家", size: 16pt)], [#box(width: 12mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)], [#cjk("。", size: 16pt)])
      ]],
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.8pt + teal, radius: 3pt)[
        #grid(columns: (auto, 12mm), align: horizon, [#cjk("喂", size: 16pt)], [#box(width: 12mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)])
      ]],
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.8pt + teal, radius: 3pt)[
        #grid(columns: (12mm, auto), align: horizon, [#box(width: 12mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)], [#cjk("好。", size: 16pt)])
      ]],
    )
    #v(4pt)
    #small[Tente escrever antes de consultar a tabela dos cartões.]
  ]
]

// Página 5 — hanzi-alvo.
#page[
  #page-title("Hanzi-alvo", sub: "Reconhecer, observar, recuperar")
  #section("SEIS CARACTERES PARA ESTE TÓPICO", color: navy)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 6pt,
    [#card([
      #align(center)[#cjk("你", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[nǐ · você]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: cream, stroke: navy)],
    [#card([
      #align(center)[#cjk("好", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[hǎo · bem / bom]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: warm, stroke: ochre)],
    [#card([
      #align(center)[#cjk("您", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[nín · você, respeito]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: mint, stroke: teal)],
    [#card([
      #align(center)[#cjk("大", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[dà · grande]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: cream, stroke: navy)],
    [#card([
      #align(center)[#cjk("家", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[jiā · casa / grupo]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: warm, stroke: ochre)],
    [#card([
      #align(center)[#cjk("喂", size: 28pt)]
      #align(center)[#text(size: 8.5pt, fill: red)[wéi · alô]]
      #v(4pt)
      #writebox(height: 9mm, color: teal)
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("RECUPERAÇÃO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([Reconheço 你 em 你好])], [#check([Reconheço 好 nas saudações])],
      [#check([Reconheço 您 em 您好])], [#check([Reconheço 大家 como grupo])],
      [#check([Reconheço 喂 como telefone])], [#check([Consigo escrever pelo menos quatro])],
    )
  ]
  #v(8pt)
  #section("USE UM HANZI EM UMA PALAVRA", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (20mm, 1fr, 1fr), gutter: 6pt,
      [#label("HANZI", color: ochre)], [#writebox(height: 9mm, color: ochre)], [#writebox(height: 9mm, color: ochre)],
    )
  ]
]

// Página 6 — pinyin e tons visuais.
#page[
  #page-title("Pinyin e tons", sub: "Leia com apoio; depois reduza o apoio")
  #section("QUATRO FORMAS DE LEITURA", color: navy)
  #table(
    columns: (1.1fr, 1fr, 1.4fr, 1.1fr),
    inset: 0pt,
    stroke: 0.45pt + line,
    align: center + horizon,
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Forma]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Pinyin]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Direção visual]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Leia]], fill: navy),
    tcell([#cjk("你好", size: 18pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[Nǐ hǎo]], fill: cream), tcell([#text(size: 17pt, fill: teal)[↘  ↯]], fill: cream), tcell([#check([ ])], fill: cream),
    tcell([#cjk("您好", size: 18pt)], fill: warm), tcell([#text(size: 9pt, fill: red)[Nín hǎo]], fill: warm), tcell([#text(size: 17pt, fill: teal)[↗  ↯]], fill: warm), tcell([#check([ ])], fill: warm),
    tcell([#cjk("大家好", size: 18pt)], fill: cream), tcell([#text(size: 9pt, fill: red)[Dàjiā hǎo]], fill: cream), tcell([#text(size: 17pt, fill: teal)[↘  —  ↯]], fill: cream), tcell([#check([ ])], fill: cream),
    tcell([#cjk("喂", size: 18pt)], fill: pink), tcell([#text(size: 9pt, fill: red)[Wéi]], fill: pink), tcell([#text(size: 17pt, fill: teal)[↗]], fill: pink), tcell([#check([ ])], fill: pink),
  )
  #v(8pt)
  #section("LEITURA EM TRÊS PASSOS", color: teal)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 6pt,
    [#card([
      #label("01 · VER", color: teal)
      #v(4pt)
      #cjk("你好", size: 21pt)
      #v(2pt)
      #small[Leia com pinyin.]
    ], fill: mint, stroke: teal)],
    [#card([
      #label("02 · COBRIR", color: ochre)
      #v(4pt)
      #text(size: 21pt, weight: "bold", fill: navy)[Nǐ hǎo]
      #v(2pt)
      #small[Leia sem olhar o hanzi.]
    ], fill: warm, stroke: ochre)],
    [#card([
      #label("03 · RECUPERAR", color: red)
      #v(4pt)
      #box(width: 25mm, height: 8mm, fill: cream, stroke: 0.8pt + red, radius: 3pt)
      #v(2pt)
      #small[Escreva de memória.]
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("MINHA OBSERVAÇÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #small[Qual forma foi mais fácil de ler? Qual forma precisa de mais prática?]
    #v(4pt)
    #writebox(height: 18mm, color: ochre)
  ]
]

// Página 7 — reconhecimento.
#page[
  #page-title("Reconhecer", sub: "Ligue forma, sentido e situação")
  #section("ATIVIDADE 1 · ESCOLHA A FORMA", color: navy)
  #panel(fill: cream, stroke: navy)[
    #grid(columns: (1.6fr, 1fr, 1fr), gutter: 5pt,
      [#label("Situação", color: navy)], [#label("Opção A", color: navy)], [#label("Opção B", color: navy)],
      [Pessoa nova], [#cjk("你好", size: 17pt)], [#cjk("喂", size: 17pt)],
      [Professora], [#cjk("您好", size: 17pt)], [#cjk("大家好", size: 17pt)],
      [Grupo], [#cjk("大家好", size: 17pt)], [#cjk("您好", size: 17pt)],
      [Telefone], [#cjk("喂", size: 17pt)], [#cjk("你好", size: 17pt)],
    )
  ]
  #v(8pt)
  #section("ATIVIDADE 2 · LIGUE HANZI E SENTIDO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 12mm, 1fr), gutter: 5pt, align: center + horizon,
      [#cjk("你好", size: 17pt)], [#text(size: 15pt, fill: ochre)[→]], [Pessoa nova],
      [#cjk("您好", size: 17pt)], [#text(size: 15pt, fill: ochre)[→]], [Respeito],
      [#cjk("大家好", size: 17pt)], [#text(size: 15pt, fill: ochre)[→]], [Grupo],
      [#cjk("喂", size: 17pt)], [#text(size: 15pt, fill: ochre)[→]], [Telefone],
    )
  ]
  #v(8pt)
  #section("ATIVIDADE 3 · CONFIRA SUA DECISÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([Escolhi antes de consultar])], [#check([Consegui explicar a situação])],
      [#check([Reconheci o hanzi])], [#check([Li com pinyin])],
    )
  ]
]

// Página 8 — recuperação escrita.
#page[
  #page-title("Recuperação escrita", sub: "Tente primeiro; confira depois")
  #section("COMPLETE A FORMA", color: navy)
  #panel(fill: cream, stroke: navy)[
    #grid(columns: (28mm, 1fr, 30mm), gutter: 6pt,
      [#label("Situação", color: navy)], [#label("Escreva", color: navy)], [#label("Conferi", color: navy)],
      [Pessoa nova], [#text(size: 17pt, font: "Noto Sans CJK SC", weight: "bold")[你#box(width: 10mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)]], [#check([ ])],
      [Respeito], [#text(size: 17pt, font: "Noto Sans CJK SC", weight: "bold")[您#box(width: 10mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)]], [#check([ ])],
      [Grupo], [#text(size: 17pt, font: "Noto Sans CJK SC", weight: "bold")[大家#box(width: 10mm, height: 5mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)]], [#check([ ])],
      [Telefone], [#box(width: 18mm, height: 6mm, stroke: 0.8pt + teal, fill: cream, radius: 2pt)], [#check([ ])],
    )
  ]
  #v(8pt)
  #section("ESCREVA A FORMA COMPLETA", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (38mm, 1fr), gutter: 6pt,
      [#label("Pessoa nova", color: teal)], [#writebox(height: 11mm, color: teal)],
      [#label("Respeito", color: teal)], [#writebox(height: 11mm, color: teal)],
      [#label("Grupo", color: teal)], [#writebox(height: 11mm, color: teal)],
      [#label("Telefone", color: teal)], [#writebox(height: 11mm, color: teal)],
    )
  ]
  #v(8pt)
  #section("MINHA CONFERÊNCIA", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #small[Depois de tentar, compare com a página 4. Marque o que aconteceu.]
    #v(4pt)
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([Lembrei sem copiar])], [#check([Consultei depois da tentativa])],
      [#check([Corrigi um hanzi])], [#check([Consegui ler])],
    )
  ]
]

// Página 9 — reorganização.
#page[
  #page-title("Reorganizar", sub: "Entenda a sequência antes de produzir")
  #section("COLOQUE OS BLOCOS EM ORDEM", color: navy)
  #panel(fill: cream, stroke: navy)[
    #label("Frase 1 · saudação para uma pessoa", color: navy)
    #v(5pt)
    #grid(columns: (1fr, 1fr, 1fr), gutter: 5pt,
      [#box(width: 100%, inset: 7pt, fill: warm, stroke: 0.7pt + ochre, radius: 3pt)[#cjk("好", size: 18pt)]],
      [#box(width: 100%, inset: 7pt, fill: mint, stroke: 0.7pt + teal, radius: 3pt)[#cjk("你", size: 18pt)]],
      [#box(width: 100%, inset: 7pt, fill: cream, stroke: 0.7pt + navy, radius: 3pt)[#cjk("。", size: 13pt)]],
    )
    #v(4pt)
    #grid(columns: (1fr, 1fr, 1fr), gutter: 5pt,
      [#label("1", color: gray)], [#label("2", color: gray)], [#label("3", color: gray)],
    )
    #v(8pt)
    #label("Frase 2 · saudação para um grupo", color: navy)
    #v(5pt)
    #grid(columns: (1fr, 1fr, 1fr, 1fr), gutter: 5pt,
      [#box(width: 100%, inset: 7pt, fill: warm, stroke: 0.7pt + ochre, radius: 3pt)[#cjk("好", size: 18pt)]],
      [#box(width: 100%, inset: 7pt, fill: cream, stroke: 0.7pt + navy, radius: 3pt)[#cjk("大", size: 18pt)]],
      [#box(width: 100%, inset: 7pt, fill: mint, stroke: 0.7pt + teal, radius: 3pt)[#cjk("家", size: 18pt)]],
      [#box(width: 100%, inset: 7pt, fill: cream, stroke: 0.7pt + navy, radius: 3pt)[#cjk("。", size: 13pt)]],
    )
    #v(4pt)
    #grid(columns: (1fr, 1fr, 1fr, 1fr), gutter: 5pt,
      [#label("1", color: gray)], [#label("2", color: gray)], [#label("3", color: gray)], [#label("4", color: gray)],
    )
  ]
  #v(8pt)
  #section("RECONSTRUA SEM MODELO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#label("Forma", color: teal)], [#label("Escreva a sequência", color: teal)],
      [Pessoa nova], [#writebox(height: 10mm, color: teal)],
      [Grupo], [#writebox(height: 10mm, color: teal)],
      [Telefone], [#writebox(height: 10mm, color: teal)],
    )
  ]
  #v(8pt)
  #section("O QUE A ORDEM MOSTRA?", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #check([Reconheci que a forma é um bloco])
    #v(3pt)
    #check([Consegui reconstruir sem copiar])
  ]
]

// Página 10 — recombinação.
#page[
  #page-title("Recombinar", sub: "Mantenha a intenção; troque o contexto")
  #section("ESTRUTURA + SITUAÇÃO", color: navy)
  #panel(fill: cream, stroke: navy)[
    #label("Escolha uma forma e troque apenas o elemento indicado.", color: navy)
    #v(6pt)
    #table(
      columns: (1.25fr, 1.2fr, 1.5fr, 0.8fr),
      inset: 0pt,
      stroke: 0.45pt + line,
      align: center + horizon,
      tcell([#text(size: 8pt, weight: "bold", fill: cream)[Situação]], fill: navy),
      tcell([#text(size: 8pt, weight: "bold", fill: cream)[Forma]], fill: navy),
      tcell([#text(size: 8pt, weight: "bold", fill: cream)[Minha troca]], fill: navy),
      tcell([#text(size: 8pt, weight: "bold", fill: cream)[Usei]], fill: navy),
      tcell([Pessoa nova], fill: cream), tcell([#cjk("你好", size: 16pt)], fill: cream), tcell([#writebox(height: 7mm, color: teal)], fill: cream), tcell([#check([ ])], fill: cream),
      tcell([Respeito], fill: warm), tcell([#cjk("您好", size: 16pt)], fill: warm), tcell([#writebox(height: 7mm, color: teal)], fill: warm), tcell([#check([ ])], fill: warm),
      tcell([Grupo], fill: cream), tcell([#cjk("大家好", size: 16pt)], fill: cream), tcell([#writebox(height: 7mm, color: teal)], fill: cream), tcell([#check([ ])], fill: cream),
      tcell([Telefone], fill: pink), tcell([#cjk("喂", size: 16pt)], fill: pink), tcell([#writebox(height: 7mm, color: teal)], fill: pink), tcell([#check([ ])], fill: pink),
    )
  ]
  #v(8pt)
  #section("BANCO PARA TROCAR", color: teal)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 6pt,
    [#card([
      #label("PESSOA", color: teal)
      #v(4pt)
      #cjk("人", size: 22pt)
      #v(2pt)
      #small[uma pessoa]
    ], fill: mint, stroke: teal)],
    [#card([
      #label("RELAÇÃO", color: ochre)
      #v(4pt)
      #cjk("朋友", size: 20pt)
      #v(2pt)
      #small[amigo]
    ], fill: warm, stroke: ochre)],
    [#card([
      #label("CANAL", color: red)
      #v(4pt)
      #cjk("电话", size: 20pt)
      #v(2pt)
      #small[telefone]
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("MINHA VARIAÇÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #small[Escreva uma situação nova e a forma que combina com ela.]
    #v(4pt)
    #writebox(height: 18mm, color: ochre)
  ]
]

// Página 11 — produção prática.
#page[
  #page-title("Produção prática", sub: "Use o que você escreveu")
  #section("ARTEFATO · CARTÃO DE ENTRADA", color: navy)
  #panel(fill: cream, stroke: navy)[
    #grid(columns: (1fr, 1fr), gutter: 8pt,
      [#card([
        #label("SITUAÇÃO", color: ochre)
        #v(4pt)
        Você chega a uma reunião e precisa cumprimentar três pessoas diferentes.
        #v(6pt)
        #grid(columns: (1fr, 1fr), gutter: 4pt,
          [#small[pessoa nova]], [#writebox(height: 8mm, color: teal)],
          [#small[professora]], [#writebox(height: 8mm, color: teal)],
          [#small[grupo]], [#writebox(height: 8mm, color: teal)],
        )
      ], fill: warm, stroke: ochre)],
      [#card([
        #label("SUA PRODUÇÃO", color: red)
        #v(4pt)
        Escreva as três formas que você usaria. Depois leia em voz alta.
        #v(6pt)
        #writebox(height: 8mm, color: red)
        #v(4pt)
        #writebox(height: 8mm, color: red)
        #v(4pt)
        #writebox(height: 8mm, color: red)
      ], fill: pink, stroke: red)],
    )
  ]
  #v(8pt)
  #section("NÍVEL DE APOIO", color: teal)
  #panel(fill: mint, stroke: teal)[
    #grid(columns: (1fr, 1fr, 1fr), gutter: 5pt,
      [#check([Usei hanzi + pinyin])], [#check([Usei apenas pinyin parcial])], [#check([Produzi sem a tabela])],
    )
  ]
  #v(8pt)
  #section("MINHA NOTA DE PRODUÇÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#label("O que saiu com facilidade", color: teal); #v(4pt); #writebox(height: 18mm, color: teal)],
      [#label("O que vou revisar", color: red); #v(4pt); #writebox(height: 18mm, color: red)],
    )
  ]
]

// Página 12 — revisão e anotações.
#page[
  #page-title("Revisar e continuar", sub: "Seu registro fecha o tópico")
  #section("AUTOAVALIAÇÃO", color: navy)
  #panel(fill: cream, stroke: navy)[
    #table(
      columns: (1.5fr, 1fr, 1fr, 1fr),
      inset: 0pt,
      stroke: 0.45pt + line,
      align: center + horizon,
      tcell([#text(size: 8pt, weight: "bold", fill: cream)[Critério]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Ainda não]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Com apoio]], fill: navy), tcell([#text(size: 8pt, weight: "bold", fill: cream)[Sem mapa]], fill: navy),
      tcell([Reconheço as quatro situações], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
      tcell([Leio as formas com pinyin], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm),
      tcell([Escrevo quatro formas], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
      tcell([Reorganizo uma forma], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm),
      tcell([Produzo em uma cena nova], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
    )
  ]
  #v(8pt)
  #section("MINHAS ANOTAÇÕES", color: teal)
  #grid(columns: (1fr, 1fr), gutter: 6pt,
    [#card([
      #label("UMA FORMA QUE QUERO LEMBRAR", color: teal)
      #v(4pt)
      #writebox(height: 15mm, color: teal)
    ], fill: mint, stroke: teal)],
    [#card([
      #label("UMA DÚVIDA QUE FICOU", color: red)
      #v(4pt)
      #writebox(height: 15mm, color: red)
    ], fill: pink, stroke: red)],
  )
  #v(8pt)
  #section("CALENDÁRIO DE REVISÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #grid(columns: (1fr, 1fr), gutter: 8pt,
      [#label("24 HORAS", color: ochre); #v(4pt); #writebox(height: 10mm, color: ochre)],
      [#label("7 DIAS", color: ochre); #v(4pt); #writebox(height: 10mm, color: ochre)],
    )
    #v(5pt)
    #align(center)[#text(size: 9pt, weight: "bold", fill: navy)[Próximo tópico: perguntar, responder e devolver.]]
  ]
]

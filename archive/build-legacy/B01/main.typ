#import "report-theme.typ": report-accent, report-theme

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

#show: report-theme.with(
  title: "Mandarim em Rede — Iniciar uma interação",
  author: "Mandarim em Rede",
  rhythm: "report",
  body-size: 10.5pt,
  running-header: false,
)

#set page(
  paper: "a4",
  margin: (top: 16mm, bottom: 15mm, x: 14mm),
  background: image("assets/bg-fundo-prime.png", width: 210mm, height: 297mm),
  numbering: none,
)
#set text(font: ("Noto Sans", "Noto Sans CJK SC"), size: 10.5pt, fill: ink, lang: "pt")
#set par(justify: false, leading: 0.98em, spacing: 0.55em, first-line-indent: 0pt)

#let label(txt, color: navy) = text(size: 8pt, weight: "bold", fill: color, tracking: 0.4pt)[#txt]
#let title(txt, sub: none) = {
  align(center)[
    #text(size: 21pt, weight: "bold", fill: navy, font: ("Libertinus Serif", "Noto Serif CJK SC"))[#txt]
    #if sub != none { v(2pt); text(size: 9.5pt, fill: gray)[#sub] }
  ]
  v(5pt)
}
#let section(txt, color: navy) = {
  box(width: 100%, inset: (x: 7pt, y: 5pt), fill: color, radius: 4pt)[
    #text(size: 10.5pt, weight: "bold", fill: cream)[#txt]
  ]
  v(4pt)
}
#let panel(body, fill: cream, stroke: navy, inset: 8pt) = box(width: 100%, inset: inset, fill: fill, stroke: 0.8pt + stroke, radius: 5pt)[#body]
#let card(body, fill: cream, stroke: navy) = box(width: 100%, inset: 6pt, fill: fill, stroke: 0.8pt + stroke, radius: 5pt)[#body]
#let check(txt, color: navy) = grid(columns: (11pt, 1fr), column-gutter: 4pt, [#box(width: 9pt, height: 9pt, stroke: 0.8pt + color, fill: cream)], [#txt])
#let blank(width: 35mm, color: teal) = box(width: width, height: 6mm, inset: 2pt, fill: cream, stroke: 1pt + color, radius: 3pt)
#let arrow() = text(size: 15pt, weight: "bold", fill: ochre)[→]
#let tcell(body, fill: none) = table.cell(fill: fill, inset: (x: 5pt, y: 4pt))[#body]

// Página 1: entrada e conteúdo linguístico.
#page[
  #title("Entrar na interação", sub: "MVP · unidade 01 · produção oral inicial")
  #section("OBJETIVO DA SESSÃO", color: navy)
  #panel[
    Esta unidade orienta a passagem de ouvir e responder à produção de uma apresentação curta. Faça uma primeira tentativa antes de consultar o mapa; depois reconstrua, recombine e transfira.
    #v(4pt)
    #align(center)[#text(size: 11pt, weight: "bold", fill: navy)[ouvir  →  tentar  →  consultar  →  reconstruir  →  recombinar  →  transferir]]
  ]
  #v(7pt)
  #section("RESULTADO MÍNIMO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #text(weight: "bold", fill: navy)[Ao final, você consegue iniciar uma interação simples e dizer seu nome sem consultar o mapa completo.]
    #v(3pt)
    #text(size: 9pt, fill: gray)[Critério de saída: produzir a sequência principal por 30–60 segundos, usando um nome novo.]
  ]
  #v(7pt)
  #section("QUATRO ESTRUTURAS PARA USAR", color: navy)
  #table(
    columns: (1.2fr, 1.15fr, 1.35fr, 1.2fr),
    inset: 0pt,
    stroke: 0.45pt + rgb("#D7CDBB"),
    align: center + horizon,
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Função]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Mandarim]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Pinyin]], fill: navy),
    tcell([#text(size: 8pt, weight: "bold", fill: cream)[Sentido]], fill: navy),
    tcell([Cumprimentar], fill: warm), tcell([#text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[你好。]], fill: warm), tcell([#text(size: 9.5pt, fill: red)[Nǐ hǎo.]], fill: warm), tcell([Olá.], fill: warm),
    tcell([Perguntar o nome], fill: cream), tcell([#text(font: "Noto Sans CJK SC", size: 15pt, weight: "bold")[你叫什么名字？]], fill: cream), tcell([#text(size: 9.5pt, fill: red)[Nǐ jiào shénme míngzi?]], fill: cream), tcell([Seu nome é...?], fill: cream),
    tcell([Dizer o próprio nome], fill: warm), tcell([#text(font: "Noto Sans CJK SC", size: 15pt, weight: "bold")[我叫] #text(size: 12pt, weight: "bold", fill: teal)[＋ nome。]], fill: warm), tcell([#text(size: 9.5pt, fill: red)[Wǒ jiào + nome.]], fill: warm), tcell([Eu me chamo + nome.], fill: warm),
    tcell([Devolver a pergunta], fill: cream), tcell([#text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[你呢？]], fill: cream), tcell([#text(size: 9.5pt, fill: red)[Nǐ ne?]], fill: cream), tcell([E você?], fill: cream),
  )
  #v(6pt)
  #panel(fill: pink, stroke: red)[
    #label("ANTES DE CONSULTAR", color: red)
    #v(2pt)
    Não leia a tabela para repetir. Ouça o áudio principal, tente responder e registre apenas o que você conseguiu produzir.
  ]
]

// Página 2: mapa completo e mapa lacunado.
#page[
  #title("Mapa de aula", sub: "Iniciar uma interação")
  #section("MAPA COMPLETO", color: navy)
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 5pt,
    card([
      #label("[F] FIXO", color: navy)
      #v(5pt)
      #text(font: "Noto Sans CJK SC", size: 20pt, weight: "bold")[你好。]
      #v(2pt)
      #text(size: 9.5pt, fill: red)[Nǐ hǎo.]
      #v(2pt)
      #text(size: 9pt)[Cumprimentar]
    ], fill: cream, stroke: navy),
    card([
      #label("[F] FIXO", color: navy)
      #v(5pt)
      #text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[你叫什么名字？]
      #v(2pt)
      #text(size: 9.5pt, fill: red)[Nǐ jiào shénme míngzi?]
      #v(2pt)
      #text(size: 9pt)[Perguntar o nome]
    ], fill: cream, stroke: navy),
    card([
      #label("[S] SUBSTITUÍVEL", color: teal)
      #v(5pt)
      #text(font: "Noto Sans CJK SC", size: 18pt, weight: "bold")[我叫] #text(size: 13pt, weight: "bold", fill: teal)[＋ nome]
      #v(2pt)
      #text(size: 9.5pt, fill: red)[Wǒ jiào + nome]
      #v(2pt)
      #text(size: 9pt)[Dizer o próprio nome]
    ], fill: mint, stroke: teal),
    card([
      #label("[O] DEVOLVER", color: red)
      #v(5pt)
      #text(font: "Noto Sans CJK SC", size: 20pt, weight: "bold")[你呢？]
      #v(2pt)
      #text(size: 9.5pt, fill: red)[Nǐ ne?]
      #v(2pt)
      #text(size: 9pt)[Devolver a pergunta]
    ], fill: cream, stroke: navy),
  )
  #v(8pt)
  #align(center)[#text(size: 12pt, weight: "bold", fill: ochre)[ouvir  →  reconstruir  →  recombinar  →  transferir]]
  #v(8pt)
  #section("MAPA LACUNADO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #label("Fale antes de preencher ou consultar.", color: red)
    #v(6pt)
    #text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[你好。  →  你叫 #box(width: 24mm, height: 6mm, stroke: 0.9pt + teal, fill: cream) #box(width: 18mm, height: 6mm, stroke: 0.9pt + teal, fill: cream)？]
    #v(8pt)
    #text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[我叫 #box(width: 28mm, height: 6mm, stroke: 0.9pt + teal, fill: cream)。  →  你 #box(width: 27mm, height: 6mm, stroke: 0.9pt + teal, fill: cream)？]
  ]
  #v(7pt)
  #panel(fill: mint, stroke: teal)[
    #label("RECONSTRUA A ORDEM", color: teal)
    #v(4pt)
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.7pt + gray, radius: 3pt)[#text(size: 9.5pt)[cumprimentar → perguntar → meu nome → devolver]]],
      [#box(width: 100%, inset: 5pt, fill: cream, stroke: 0.7pt + gray, radius: 3pt)[#text(size: 9.5pt)[ouvir → tentar → consultar → produzir]]],
    )
  ]
]

// Página 3: ciclo de áudio, recuperação e apoio visual.
#page[
  #title("Ouvir e reconstruir", sub: "Use o áudio como entrada; use a página como apoio")
  #section("CICLO DE TRABALHO", color: navy)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 6pt,
    card([
      #label("01 · OUVIR", color: navy)
      #v(5pt)
      #text(size: 16pt, weight: "bold")[♫]
      #v(3pt)
      Ouça o diálogo principal sem acompanhar a página.
      #v(3pt)
      #text(size: 8pt, fill: gray)[Objetivo: perceber a situação e o ritmo.]
    ], fill: cream, stroke: navy),
    card([
      #label("02 · TENTAR", color: red)
      #v(5pt)
      #text(size: 16pt, weight: "bold")[?]
      #v(3pt)
      Tente responder antes de consultar a solução.
      #v(3pt)
      #text(size: 8pt, fill: gray)[Objetivo: recuperar o que já foi ouvido.]
    ], fill: pink, stroke: red),
    card([
      #label("03 · CONSULTAR", color: teal)
      #v(5pt)
      #text(size: 16pt, weight: "bold")[↗]
      #v(3pt)
      Consulte o mapa, reconstrua e repita com menos apoio.
      #v(3pt)
      #text(size: 8pt, fill: gray)[Objetivo: ajustar a forma sem copiar passivamente.]
    ], fill: mint, stroke: teal),
  )
  #v(8pt)
  #section("REGISTRO DE RECUPERAÇÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #label("Marque o que aconteceu na sua primeira tentativa.", color: navy)
    #v(5pt)
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#check([Consegui cumprimentar.])], [#check([Consegui perguntar o nome.])],
      [#check([Consegui dizer meu nome.])], [#check([Consegui devolver a pergunta.])],
      [#check([Usei um nome novo.])], [#check([Produzi sem olhar o mapa completo.])],
    )
  ]
  #v(8pt)
  #section("APOIO VISUAL GRADUAL", color: navy)
  #table(columns: (1.2fr, 1.6fr, 1.6fr), inset: 0pt, stroke: 0.45pt + rgb("#D7CDBB"),
    tcell([#text(weight: "bold", fill: cream)[Etapa]], fill: navy), tcell([#text(weight: "bold", fill: cream)[Apoio disponível]], fill: navy), tcell([#text(weight: "bold", fill: cream)[O que fazer]], fill: navy),
    tcell([1], fill: cream), tcell([Áudio], fill: cream), tcell([Tente identificar a intenção.], fill: cream),
    tcell([2], fill: warm), tcell([Mapa completo], fill: warm), tcell([Reconstrua a ordem e a função.], fill: warm),
    tcell([3], fill: cream), tcell([Mapa lacunado], fill: cream), tcell([Complete sem copiar a resposta.], fill: cream),
    tcell([4], fill: warm), tcell([Sem mapa completo], fill: warm), tcell([Produza em uma situação nova.], fill: warm),
  )
]

// Página 4: recombinação e transferência.
#page[
  #title("Recombinar e transferir", sub: "Troque pouco; produza muito")
  #section("VARIAÇÕES CONTROLADAS", color: navy)
  #panel(fill: cream, stroke: navy)[
    #label("Mantenha a sequência. Troque apenas um elemento.", color: navy)
    #v(6pt)
    #grid(columns: (14mm, 1fr, 1fr, 18mm), gutter: 5pt,
      [#label("01", color: navy)], [#text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[我叫]], [#blank(width: 35mm, color: teal)], [#check([produzi])],
      [#label("02", color: navy)], [#text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[我叫]], [#blank(width: 35mm, color: teal)], [#check([produzi])],
      [#label("03", color: navy)], [#text(font: "Noto Sans CJK SC", size: 17pt, weight: "bold")[我叫]], [#blank(width: 35mm, color: teal)], [#check([produzi])],
    )
  ]
  #v(8pt)
  #section("PRODUÇÃO EM SITUAÇÃO NOVA", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #label("Fale por 30–60 segundos sem consultar o mapa completo.", color: navy)
    #v(6pt)
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#card([
        #label("SITUAÇÃO", color: ochre)
        #v(4pt)
        Você conheceu uma pessoa nova em uma reunião on-line.
      ], fill: cream, stroke: ochre)],
      [#card([
        #label("RESTRIÇÃO", color: red)
        #v(4pt)
        Use um nome que não apareceu nos exemplos.
      ], fill: pink, stroke: red)],
    )
    #v(6pt)
    #card([
      #label("GATILHOS", color: teal)
      #v(4pt)
      cumprimentar  →  perguntar  →  meu nome  →  devolver
    ], fill: mint, stroke: teal)
  ]
  #v(8pt)
  #section("MINHA PRODUÇÃO", color: red)
  #panel(fill: pink, stroke: red)[
    #label("Depois de falar, registre o que precisa ser reconstruído.", color: red)
    #v(6pt)
    #grid(columns: (1fr, 1fr), gutter: 6pt,
      [#card([#label("O que saiu com facilidade", color: teal); #v(4pt); #box(width: 100%, height: 22mm, fill: cream, stroke: 0.6pt + gray, radius: 3pt)], fill: cream, stroke: teal)],
      [#card([#label("O que vou tentar de novo", color: red); #v(4pt); #box(width: 100%, height: 22mm, fill: cream, stroke: 0.6pt + gray, radius: 3pt)], fill: cream, stroke: red)],
    )
  ]
]

// Página 5: autoavaliação e próximo passo.
#page[
  #title("Revisar e continuar", sub: "A unidade termina quando a produção fica mais independente")
  #section("AUTOAVALIAÇÃO", color: navy)
  #panel(fill: cream, stroke: navy)[
    #label("Marque uma opção para cada critério.", color: navy)
    #v(6pt)
    #table(columns: (1.5fr, 1fr, 1fr, 1fr), inset: 0pt, stroke: 0.45pt + rgb("#D7CDBB"),
      tcell([#text(weight: "bold", fill: cream)[Critério]], fill: navy), tcell([#text(weight: "bold", fill: cream)[Ainda não]], fill: navy), tcell([#text(weight: "bold", fill: cream)[Com apoio]], fill: navy), tcell([#text(weight: "bold", fill: cream)[Sem mapa]], fill: navy),
      tcell([Cumprimento], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
      tcell([Pergunta do nome], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm),
      tcell([Meu nome], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
      tcell([Devolver a pergunta], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm), tcell([☐], fill: warm),
      tcell([Usar nome novo], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream), tcell([☐], fill: cream),
    )
  ]
  #v(8pt)
  #section("PLANO DE CONTINUIDADE", color: teal)
  #grid(columns: (1fr, 1fr), gutter: 6pt,
    [#card([
      #label("REFAZER", color: navy)
      #v(4pt)
      Ouça novamente e repita a sequência sem preencher nada.
      #v(9pt)
      #box(width: 100%, height: 18mm, fill: cream, stroke: 0.6pt + gray, radius: 3pt)
    ], fill: cream, stroke: navy)],
    [#card([
      #label("TRANSFERIR", color: teal)
      #v(4pt)
      Escolha outra situação e mantenha apenas o padrão.
      #v(9pt)
      #box(width: 100%, height: 18mm, fill: cream, stroke: 0.6pt + gray, radius: 3pt)
    ], fill: mint, stroke: teal)],
  )
  #v(8pt)
  #section("REFERÊNCIA RÁPIDA", color: ochre)
  #panel(fill: warm, stroke: ochre)[
    #align(center)[
      #text(font: "Noto Sans CJK SC", size: 20pt, weight: "bold")[你好。  你叫什么名字？  我叫] #text(size: 14pt, weight: "bold", fill: teal)[＋ nome。] #text(font: "Noto Sans CJK SC", size: 20pt, weight: "bold")[ 你呢？]
      #v(4pt)
      #text(size: 9pt, fill: red)[Nǐ hǎo. · Nǐ jiào shénme míngzi? · Wǒ jiào + nome. · Nǐ ne?]
    ]
  ]
  #v(8pt)
  #align(center)[#text(size: 8.5pt, fill: gray)[Próxima unidade sugerida: perguntas sim/não com 吗 e devolução com 呢.]]
]

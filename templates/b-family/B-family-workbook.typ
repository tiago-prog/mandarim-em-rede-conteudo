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
#let decision = unit.mapa_decisao
#let words = unit.palavras_chave
#let activities = unit.atividades
#let recognition = activities.reconhecimento
#let reorder = activities.reorganizacao
#let recombine = activities.recombinacao
#let scenarios = unit.producao.cenarios
#let criteria = unit.criterios_autoavaliacao
#let steps = unit.preparacao

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
#let palette = ((cream, navy), (warm, ochre), (mint, teal), (pink, red))
#let tone(i) = palette.at(calc.rem(i, palette.len()))
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
  #align(center)[#label(upper(unit.colecao), color: ochre); #v(5pt); #page-title(unit.titulo, sub: [#unit.codigo · workbook visual e escrito])]
  #section("O QUE VOCÊ VAI CONSEGUIR FAZER", color: navy)
  #panel(fill: warm, stroke: ochre)[#text(size: 12pt, weight: "bold", fill: navy)[#unit.objetivo_comunicativo]; #v(5pt); #small[#unit.situacao_principal]; #v(4pt); #small[#unit.contexto_emocional]]
  #v(7pt)
  #section("RESULTADO MÍNIMO", color: ochre)
  #panel(fill: cream, stroke: navy)[#text(size: 10.5pt)[#unit.resultado_minimo]; #v(6pt); #small[Atenção: #unit.dificuldade_principal]; #v(6pt); #align(center)[#text(size: 9pt, weight: "bold", fill: ochre)[SITUAR → OBSERVAR → RECONHECER → PRODUZIR]]]
  #v(8pt)
  #section("ANTES DE COMEÇAR", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, ..steps.map(step => [#check([#step])]))]
]

#page[
  #page-title("Mapa de linguagem", sub: "O que fica, o que muda e como devolver")
  #section("ESTRUTURAS CENTRAIS", color: navy)
  #grid(columns: (1fr, 1fr), gutter: 6pt, ..structures.slice(0, calc.min(structures.len(), 4)).enumerate().map(((i, item)) => {
    let (bg, edge) = tone(i)
    structure-card(item, fill: bg, stroke: edge)
  }))
  #v(8pt)
  #section("MAPA DE DECISÃO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#small[Leia cada linha da esquerda para a direita.]; #v(4pt); #grid(columns: (1.3fr, 12mm, 1.5fr), gutter: 4pt, [#label("INTENÇÃO", color: navy)], [#text(size: 15pt, fill: ochre)[→]], [#label("FORMA", color: navy)], ..decision.map(row => ([#row.intencao], [#text(size: 13pt)[→]], [#cjk(row.mandarim, size: 15pt)])).flatten())]
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
    ..words.enumerate().map(((i, w)) => {
      let bg = if calc.even(i) { cream } else { warm }
      (
        tcell([#cjk(w.hanzi, size: 16pt)], fill: bg),
        tcell([#text(size: 9pt, fill: red)[#w.pinyin]], fill: bg),
        tcell([#w.sentido], fill: bg),
        tcell([#w.at("uso", default: "")], fill: bg),
      )
    }).flatten()
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
  #panel(fill: cream, stroke: navy)[#small[Marque a estrutura que combina com cada situação.]; #v(5pt); #grid(columns: (1.5fr, 1fr, 1fr, 0.7fr), gutter: 5pt, [#label("Situação", color: navy)], [#label("A", color: navy)], [#label("B", color: navy)], [#label("Escolha", color: navy)], ..recognition.map(item => ([#item.situacao], [#cjk(item.opcao_a, size: 15pt)], [#cjk(item.opcao_b, size: 15pt)], [#writebox(height: 7mm, color: navy)])).flatten())]
  #v(8pt)
  #section("CONFIRA A RELAÇÃO", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Reconheci a função de cada forma.])], [#check([Distingui as duas opções.])], [#check([Identifiquei o sentido.])], [#check([Confirei minhas escolhas.])])]
  #v(8pt)
  #section("MINHA DÚVIDA", color: ochre)
  #panel(fill: warm, stroke: ochre)[#writebox(height: 18mm, color: ochre)]
]

#page[
  #page-title("Recuperação", sub: "Tente primeiro; confira depois")
  #section("COMPLETE A FORMA", color: navy)
  #panel(fill: cream, stroke: navy)[#grid(columns: (42mm, 1fr, 25mm), gutter: 6pt, [#label("Função", color: navy)], [#label("Minha resposta", color: navy)], [#label("Conferi", color: navy)], ..decision.map(row => ([#row.intencao], [#writebox(height: 9mm, color: teal)], [#check([ ])])).flatten())]
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
  #panel(fill: cream, stroke: navy)[#small[#reorder.instrucao]; #v(5pt); #grid(columns: (1fr,) * reorder.blocos.len(), gutter: 5pt, ..reorder.blocos.enumerate().map(((i, bloco)) => {
    let (bg, edge) = tone(i)
    [#card([#cjk(bloco, size: 18pt)], fill: bg, stroke: edge)]
  })); #v(5pt); #grid(columns: (22mm, 1fr), gutter: 6pt, [#label("ORDEM", color: navy)], [#writebox(height: 9mm, color: navy)])]
  #v(8pt)
  #section("RECONSTRUA SEM MODELO", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#label("Pedido", color: teal)], [#label("Escreva", color: teal)], ..reorder.reconstrucoes.map(item => ([#item.pedido], [#writebox(height: 10mm, color: teal)])).flatten())]
  #v(8pt)
  #section("MARQUE", color: ochre)
  #panel(fill: warm, stroke: ochre)[#check([Percebi a posição da partícula.]); #v(3pt); #check([Consegui reconstruir sem copiar.])]
]

#page[
  #page-title("Recombinar", sub: "Mantenha a estrutura; troque o slot")
  #section("BANCO PARA TROCAR", color: navy)
  #grid(columns: (1fr,) * calc.min(recombine.banco.len(), 4), gutter: 6pt, ..recombine.banco.enumerate().map(((i, item)) => {
    let (bg, edge) = tone(i)
    card([#label(upper(item.rotulo), color: edge); #v(4pt); #cjk(item.hanzi, size: 20pt); #v(2pt); #small[#item.pinyin]], fill: bg, stroke: edge)
  }))
  #v(8pt)
  #section("MINHAS VARIAÇÕES", color: teal)
  #panel(fill: mint, stroke: teal)[#small[#recombine.instrucao]; #v(5pt); #grid(columns: (35mm, 1fr), gutter: 6pt, [#label("ESTRUTURA", color: teal)], [#label("MINHA TROCA", color: teal)], ..recombine.moldes.map(molde => ([#cjk(molde, size: 14pt)], [#writebox(height: 10mm, color: teal)])).flatten())]
  #v(8pt)
  #section("USEI A ESTRUTURA", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#check([Troquei apenas o slot.])], [#check([Mantive o sentido.])])]
]

#page[
  #page-title("Produção prática", sub: "Transfira para uma conversa curta")
  #for (i, cenario) in scenarios.enumerate() {
    let (bg, edge) = tone(i)
    let apoio = if cenario.apoio == "com_apoio" { "COM APOIO" } else if cenario.apoio == "menos_apoio" { "MENOS APOIO" } else { "SEM APOIO" }
    let campos = cenario.at("campos", default: ())
    let altura = if scenarios.len() > 2 { 18mm } else { 30mm }
    section("CENÁRIO " + str(i + 1) + " · " + apoio + " · " + upper(cenario.titulo), color: edge)
    panel(fill: bg, stroke: edge)[
      #text(size: 10pt)[#cenario.instrucao]
      #v(6pt)
      #if campos.len() == 0 {
        writebox(height: altura + 10mm, color: edge)
      } else {
        grid(columns: (1fr,) * campos.len(), gutter: 6pt, ..campos.map(campo => [#label(upper(campo), color: edge); #v(4pt); #writebox(height: altura, color: edge)]))
      }
    ]
    v(8pt)
  }
  #section("NÍVEL DE APOIO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#grid(columns: (1fr, 1fr, 1fr), gutter: 5pt, [#check([Usei hanzi + pinyin.])], [#check([Usei apoio parcial.])], [#check([Produzi sem o mapa.])])]
]

#page[
  #page-title("Revisar e continuar", sub: "Feche o tópico e prepare a próxima recuperação")
  #section("AUTOAVALIAÇÃO", color: navy)
  #panel(fill: cream, stroke: navy)[#table(columns: (1.6fr, 1fr, 1fr, 1fr), inset: 0pt, stroke: 0.45pt + line, align: center + horizon, table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Critério]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Ainda não]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Com apoio]], table.cell(fill: navy, inset: (x: 4pt, y: 3pt))[#text(size: 8pt, weight: "bold", fill: cream)[Sem mapa]], ..criteria.map(item => ([#item], [☐], [☐], [☐])).flatten())]
  #v(8pt)
  #section("REVISÃO PROGRAMADA", color: teal)
  #panel(fill: mint, stroke: teal)[#grid(columns: (1fr, 1fr), gutter: 6pt, [#label("EM 24 HORAS", color: teal); #v(3pt); #writebox(height: 10mm, color: teal)], [#label("EM 7 DIAS", color: teal); #v(3pt); #writebox(height: 10mm, color: teal)])]
  #v(8pt)
  #section("PRÓXIMO TÓPICO", color: ochre)
  #panel(fill: warm, stroke: ochre)[#label("ARTEFATO PRÁTICO", color: ochre); #v(2pt); #small[#unit.artefato_pratico]; #v(4pt); #small[#unit.proxima_unidade_sugerida]; #v(4pt); #grid(columns: (1fr, 1fr), gutter: 6pt, [#label("AINDA PRECISO PRATICAR", color: red); #v(3pt); #writebox(height: 13mm, color: red)], [#label("MINHA OBSERVAÇÃO", color: teal); #v(3pt); #writebox(height: 13mm, color: teal)])]
]

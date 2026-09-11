from pathlib import Path

root = Path(__file__).resolve().parent
source = root / "B01-workbook.typ"
out = root / "B01-workbook-stress-dense.typ"
s = source.read_text(encoding="utf-8")
replacements = {
    "Escolher um cumprimento conforme a situação e registrar a forma em hanzi, pinyin e escrita própria.": "Escolher um cumprimento conforme a situação, registrar a forma em hanzi e pinyin e escrever uma versão própria para usar em uma cena nova.",
    "Você vai trabalhar com pessoa nova, respeito, grupo e telefone.": "Você vai trabalhar com uma pessoa nova, uma professora, um grupo e uma chamada telefônica em situações simples do dia a dia.",
    "Você demonstra respeito.": "Você demonstra respeito ao falar com uma professora ou com uma pessoa mais velha.",
    "Escolha, escreva, leia e use em uma cena nova.": "Escolha a forma adequada, escreva com apoio, leia a estrutura e use-a em uma cena nova criada por você.",
    "Leia o hanzi, acompanhe o pinyin e ligue cada palavra a uma situação.": "Leia cada hanzi, acompanhe o pinyin com atenção, observe o sentido e marque a situação em que você usaria cada palavra.",
    "Escolha uma cena e escreva a forma que você usaria.": "Escolha uma das quatro cenas, explique rapidamente sua decisão e escreva a forma que você usaria nessa situação.",
    "Tente escrever antes de consultar a tabela dos cartões.": "Tente escrever todas as formas antes de consultar a tabela dos cartões; depois compare e corrija o que for necessário.",
    "Qual forma foi mais fácil de ler? Qual forma precisa de mais prática?": "Qual forma foi mais fácil de ler? Qual forma precisa de mais prática? Explique o motivo usando uma observação curta.",
    "Escreva uma situação nova e a forma que combina com ela.": "Escreva uma situação nova, indique quem está presente e registre a forma que combina com esse contexto.",
    "Você chega a uma reunião e precisa cumprimentar três pessoas diferentes.": "Você chega a uma reunião de trabalho e precisa cumprimentar três pessoas diferentes, escolhendo uma forma adequada para cada relação.",
    "Escreva as três formas que você usaria. Depois releia e compare com o mapa.": "Escreva as três formas que você usaria, explique qual muda conforme a situação e depois releia tudo comparando com o mapa.",
    "Depois de tentar, compare com a página 4. Marque o que aconteceu.": "Depois de tentar sem consultar, compare suas respostas com a página 4 e marque o que aconteceu durante a revisão.",
    "Tente primeiro; confira depois": "Tente primeiro, registre sua resposta e confira depois com o mapa de linguagem.",
}
for old, new in replacements.items():
    if old not in s:
        raise SystemExit(f"missing replacement: {old}")
    s = s.replace(old, new, 1)
out.write_text(s, encoding="utf-8")
print(out)

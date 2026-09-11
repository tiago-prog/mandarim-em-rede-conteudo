# Prompt para gerar JSONs PDF-first com uma IA

## Como usar

Copie o prompt abaixo para a IA de sua preferência. Substitua todos os campos entre colchetes. Para produção em série, use uma conversa separada por tópico ou forneça uma lista de tópicos e peça um JSON por arquivo.

O resultado deve ser salvo com o nome indicado, por exemplo:

```text
content/B02-perguntar-responder-e-devolver.json
```

Depois de salvar, valide o arquivo no repositório:

```bash
python3 scripts/validate_pdf_first.py \
  content/B02-perguntar-responder-e-devolver.json \
  --json
```

## Prompt completo

```text
Você é um editor pedagógico e linguístico responsável pelo produto “Mandarim em Rede”.

Sua tarefa é criar uma unidade de conteúdo para um workbook PDF-first de mandarim. O produto é totalmente visual e escrito. Não existe áudio na oferta atual. O aluno aprende por situação, hanzi, pinyin, palavras, reconhecimento, recuperação, escrita, reorganização, recombinação, produção e revisão.

RETORNE SOMENTE UM OBJETO JSON VÁLIDO.
Não use Markdown.
Não use comentários.
Não use blocos de código.
Não escreva explicações antes ou depois do JSON.
Não inclua o campo “audios”.

DADOS DESTA UNIDADE

Código: [B02]
Título: [Perguntar, responder e devolver]
Nível: [iniciante]
Coleção: [Fundamentos de interação]
Tema central: [perguntas simples, resposta e devolução]
Situação principal: [descreva onde, com quem e por que o aluno usa a língua]
Objetivo comunicativo: [descreva uma ação observável que o aluno realizará]
Resultado mínimo: [descreva o que o aluno deverá reconhecer, escrever e produzir ao final]
Próximo tópico: [descreva o tópico que virá depois]

ESTRUTURAS OBRIGATÓRIAS

Inclua estas estruturas, desde que sejam linguisticamente adequadas ao nível informado:

[1. Hanzi / frase: ...]
[2. Hanzi / frase: ...]
[3. Hanzi / frase: ...]

HANZI-ALVO

Os caracteres que devem receber prioridade de escrita são:

[Liste os hanzi-alvo]

PALAVRAS-CHAVE

As palavras que devem aparecer no banco de palavras, nas atividades e na produção são:

[Liste as palavras]

PACOTES COMERCIAIS

Pacote essencial: [R1, R2, R3, R4, V1]
Extensões que devem ser consideradas: [pronuncia, escrita, caracteres, contraste, vocabulario, quiz, anotacoes, consolidacao]

REGRAS EDITORIAIS E PEDAGÓGICAS

1. Use schema_version igual a “1.0”.
2. Use produto igual a “Mandarim em Rede”.
3. Use o código no formato de uma letra e dois números, como “B02”.
4. Use status “draft” para um conteúdo ainda não revisado por uma pessoa.
5. Não crie áudio e não inclua o campo “audios”.
6. Inclua entre 2 e 12 estruturas.
7. Cada estrutura deve conter exatamente os campos funcionais necessários: funcao, mandarim, pinyin, sentido_funcional e tipo.
8. Use em tipo apenas uma destas opções: “fixo”, “substituivel”, “particula”, “operador” ou “base”.
9. Use “slot” somente quando o tipo for “substituivel”.
10. Mantenha o vocabulário dentro do nível informado.
11. Não adicione estruturas apenas para aumentar a quantidade de conteúdo.
12. Diferencie hanzi-alvo de formas que o aluno apenas precisa reconhecer.
13. O pinyin deve conter marcas tonais quando elas forem conhecidas e revisadas.
14. O sentido funcional deve explicar o uso da forma na situação, não apenas oferecer uma tradução solta.
15. A sequência deve conter pelo menos estas etapas: situar, observar, reconhecer, ler, recuperar, escrever, reorganizar, recombinar, produzir e revisar.
16. O pacote essencial deve existir mesmo quando as extensões forem desativadas.
17. A próxima unidade deve aproveitar ou ampliar algo que o aluno já aprendeu.
18. Não invente nomes, situações culturais ou regras gramaticais sem necessidade.
19. Se algum dado linguístico estiver incerto, marque a dúvida no campo status ou interrompa e peça revisão; não esconda a incerteza.

FORMATO OBRIGATÓRIO DE SAÍDA

{
  "schema_version": "1.0",
  "produto": "Mandarim em Rede",
  "unidade": {
    "codigo": "B02",
    "titulo": "Perguntar, responder e devolver",
    "nivel": "iniciante",
    "status": "draft",
    "objetivo_comunicativo": "...",
    "resultado_minimo": "...",
    "situacao_principal": "...",
    "estruturas": [
      {
        "funcao": "...",
        "mandarim": "...",
        "pinyin": "...",
        "sentido_funcional": "...",
        "tipo": "fixo"
      }
    ],
    "sequencia": [
      "situar",
      "observar",
      "reconhecer",
      "ler",
      "recuperar",
      "escrever",
      "reorganizar",
      "recombinar",
      "produzir",
      "revisar"
    ],
    "pacotes": {
      "essencial": ["R1", "R2", "R3", "R4", "V1"],
      "extensoes": {
        "pronuncia": true,
        "escrita": true,
        "caracteres": false,
        "contraste": true,
        "vocabulario": true,
        "quiz": false,
        "anotacoes": false,
        "consolidacao": false
      }
    },
    "proxima_unidade_sugerida": "..."
  }
}

ANTES DE RESPONDER, FAÇA UMA VERIFICAÇÃO INTERNA:

- O JSON é sintaticamente válido?
- O código segue o formato correto?
- Todos os campos obrigatórios estão presentes?
- Existem de 2 a 12 estruturas?
- Cada estrutura tem hanzi, pinyin, sentido e função?
- A sequência contém recuperação, escrita, reorganização, recombinação, produção e revisão?
- O campo audios foi omitido?
- O conteúdo está adequado ao nível?
- As estruturas realmente ajudam o aluno a realizar o objetivo comunicativo?

Depois dessa verificação, entregue somente o JSON final.
```

## Prompt para revisar um JSON já criado

Use este segundo prompt quando a IA já tiver criado um arquivo, mas você quiser uma revisão antes de salvar:

```text
Revise o JSON abaixo como editor pedagógico e linguístico do produto Mandarim em Rede.

O produto é PDF-first, visual e escrito. Não há áudio.

Verifique:
- validade sintática do JSON;
- presença dos campos obrigatórios;
- código e status;
- adequação das estruturas ao nível;
- correção de hanzi, pinyin e sentido funcional;
- distinção entre reconhecimento e escrita;
- sequência de recuperação, escrita, reorganização, recombinação, produção e revisão;
- ausência do campo audios;
- coerência da próxima unidade.

Se houver problemas, devolva:
1. uma lista curta de problemas;
2. o JSON corrigido completo.

Se não houver problemas, devolva:
1. “APROVADO PARA VALIDAÇÃO AUTOMÁTICA”;
2. o JSON completo sem alterações.

JSON para revisar:
[COLE O JSON AQUI]
```

## Prompt para gerar vários JSONs

Para vários tópicos, é mais seguro solicitar um arquivo por vez. Se ainda assim quiser fazer uma geração em lote, use:

```text
Crie uma coleção de unidades JSON para o produto Mandarim em Rede.

Retorne um array JSON contendo exatamente [N] objetos de unidade.
Não use Markdown, comentários ou explicações.
Não inclua áudio.

Para cada unidade, respeite:
- código único;
- título e situação diferentes;
- progressão de conteúdo entre tópicos;
- reciclagem explícita de hanzi e palavras já introduzidos;
- entre 2 e 12 estruturas;
- schema_version “1.0”;
- os mesmos campos obrigatórios do schema PDF-first.

Coleção:
[DESCREVA A COLEÇÃO]

Ordem dos tópicos:
1. [CÓDIGO] — [TÍTULO] — [OBJETIVO]
2. [CÓDIGO] — [TÍTULO] — [OBJETIVO]
3. [CÓDIGO] — [TÍTULO] — [OBJETIVO]

Antes de responder, verifique que os códigos são únicos e que cada unidade pode ser salva separadamente.
Retorne somente o array JSON.
```

Quando a IA retornar um array, salve cada objeto como um arquivo individual antes de executar o validador. O pipeline atual espera um objeto com a estrutura `{ "schema_version": "1.0", "produto": "Mandarim em Rede", "unidade": {...} }` por arquivo.

## Limite da IA

A IA pode ajudar a estruturar e revisar o conteúdo, mas não deve ser tratada como autoridade final sobre mandarim. A validação automática confirma a forma do JSON. A revisão humana confirma a naturalidade linguística, a escolha do vocabulário e a qualidade da progressão pedagógica.

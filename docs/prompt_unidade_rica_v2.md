# Prompt para gerar unidades ricas (contrato v2)

Este prompt gera o arquivo completo de uma unidade no contrato `pdf-first-rich-v2`. Nesse contrato, todo o conteúdo pedagógico do workbook vem do JSON: banco de palavras, hanzi-alvo, mapa de decisão, atividades de reconhecimento, reorganização, recombinação, cenários de produção e critérios de autoavaliação. O template Typst não contém nenhuma frase, nenhum hanzi e nenhum cenário fixo.

Para unidades antigas no contrato `1.0`, use `docs/prompt_para_gerar_json_pdf_first.md`.

Salve o resultado em `content/pdf_first/` e valide:

```bash
python3 scripts/validate_pdf_first.py \
  content/pdf_first/B03-identificar-pessoas-e-objetos.json \
  --json
```

O validador reprova, entre outras coisas, hanzi-alvo que não aparecem nas estruturas, opções de reconhecimento inventadas, blocos de reorganização que não reconstroem o resultado esperado e pinyin sem marca tonal.

## Prompt completo

```text
Você é um editor pedagógico e linguístico do produto “Mandarim em Rede”.

Crie uma unidade de workbook PDF-first. O produto é visual e escrito. Não existe áudio.

RETORNE SOMENTE UM OBJETO JSON VÁLIDO.
Não use Markdown, comentários, blocos de código, nem texto antes ou depois do JSON.
Não inclua o campo “audios”.

DADOS DESTA UNIDADE

Código: [B03]
Título: [Identificar pessoas e objetos]
Coleção: [Coleção 01 · Primeiras interações]
Nível: [iniciante]
Situação principal: [onde, com quem e por que o aluno usa a língua]
Objetivo comunicativo: [ação observável que o aluno realizará]
Resultado mínimo: [o que o aluno reconhece, escreve e produz ao final]
Contexto emocional: [o que o aluno já sabe e o que o trava nesta situação]
Dificuldade principal: [o erro mais provável nesta unidade]
Estruturas obrigatórias: [liste as formas que precisam aparecer]
Hanzi-alvo: [liste os caracteres que recebem prioridade de escrita]
Próximo tópico: [tópico seguinte]

REGRAS DO CONTRATO

1. schema_version = "2.0"; produto = "Mandarim em Rede"; content_profile = "pdf-first-rich-v2".
2. codigo no formato de uma letra e dois números, como "B03".
3. status = "draft" enquanto não houver revisão humana.
4. Entre 6 e 10 estruturas, cada uma com funcao, mandarim, pinyin, sentido_funcional e tipo.
5. tipo aceita apenas: "fixo", "substituivel", "particula", "operador", "base".
6. Use "slot" quando tipo for "substituivel" e "particula" quando tipo for "particula".
7. O pinyin deve ter marca tonal, exceto em sílabas neutras como ma, ne, ba, de, le.
8. mapa_decisao: de 3 a 5 pares intenção → forma. Cada "mandarim" deve ser exatamente uma das estruturas.
9. hanzi_alvo: de 4 a 8 itens com hanzi, pinyin, sentido e prioridade ("alta" ou "media"). Todo hanzi-alvo deve aparecer em alguma estrutura.
10. palavras_chave: de 8 a 12 itens com hanzi, pinyin, sentido, categoria e uso. categoria aceita apenas: "pessoa", "objeto", "acao", "lugar", "informacao", "estado", "quantidade". Todo hanzi do banco deve aparecer em alguma estrutura.
11. atividades.reconhecimento: de 3 a 5 itens. opcao_a e opcao_b precisam ser formas reais da unidade, diferentes entre si; resposta é "a" ou "b".
12. atividades.reorganizacao: os blocos, concatenados na ordem correta, devem reconstruir exatamente resultado_esperado; cada reconstrução aponta para uma estrutura existente.
13. atividades.recombinacao: cada molde usa “…” para marcar o slot que muda; o banco só usa itens já presentes nas estruturas.
14. producao.cenarios: 2 ou 3 cenários, com apoio decrescente ("com_apoio", "menos_apoio", "sem_apoio").
15. criterios_autoavaliacao: de 4 a 5 critérios observáveis, escritos em primeira pessoa.
16. A sequência deve ser exatamente:
    ["situar", "observar", "reconhecer", "ler", "recuperar", "escrever", "reorganizar", "recombinar", "produzir", "revisar"]
17. pacotes.essencial usa apenas códigos do catálogo do roadmap: W1, W2, V1, X1, R1, Q1, R5.
18. Não invente regras gramaticais, nomes próprios ou referências culturais sem necessidade.
19. Se algum dado linguístico for incerto, mantenha status "draft" e não esconda a incerteza.

FORMATO OBRIGATÓRIO DE SAÍDA

{
  "schema_version": "2.0",
  "produto": "Mandarim em Rede",
  "unidade": {
    "content_profile": "pdf-first-rich-v2",
    "codigo": "B03",
    "titulo": "...",
    "colecao": "...",
    "nivel": "iniciante",
    "status": "draft",
    "objetivo_comunicativo": "...",
    "resultado_minimo": "...",
    "situacao_principal": "...",
    "contexto_emocional": "...",
    "dificuldade_principal": "...",
    "preparacao": ["...", "...", "...", "..."],
    "estruturas": [
      {"funcao": "...", "mandarim": "...", "pinyin": "...", "sentido_funcional": "...", "tipo": "base"}
    ],
    "mapa_decisao": [
      {"intencao": "...", "mandarim": "...", "pinyin": "..."}
    ],
    "hanzi_alvo": [
      {"hanzi": "...", "pinyin": "...", "sentido": "...", "prioridade": "alta"}
    ],
    "palavras_chave": [
      {"hanzi": "...", "pinyin": "...", "sentido": "...", "categoria": "pessoa", "uso": "..."}
    ],
    "atividades": {
      "reconhecimento": [
        {"situacao": "...", "opcao_a": "...", "opcao_b": "...", "resposta": "a"}
      ],
      "reorganizacao": {
        "instrucao": "...",
        "blocos": ["...", "...", "..."],
        "resultado_esperado": "...",
        "reconstrucoes": [
          {"pedido": "...", "mandarim": "..."}
        ]
      },
      "recombinacao": {
        "instrucao": "...",
        "banco": [
          {"rotulo": "...", "hanzi": "...", "pinyin": "..."}
        ],
        "moldes": ["…", "…"]
      }
    },
    "producao": {
      "cenarios": [
        {"titulo": "...", "instrucao": "...", "apoio": "com_apoio", "campos": ["..."]}
      ]
    },
    "artefato_pratico": "...",
    "criterios_autoavaliacao": ["...", "...", "...", "..."],
    "sequencia": [
      "situar", "observar", "reconhecer", "ler", "recuperar",
      "escrever", "reorganizar", "recombinar", "produzir", "revisar"
    ],
    "pacotes": {
      "essencial": ["W1", "W2", "V1", "R1"],
      "extensoes": {
        "pronuncia": true,
        "escrita": true,
        "caracteres": true,
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

VERIFICAÇÃO INTERNA ANTES DE RESPONDER

- O JSON é sintaticamente válido e não tem campos fora do contrato?
- Há de 6 a 10 estruturas e a sequência está exatamente na ordem exigida?
- Todo hanzi de hanzi_alvo e de palavras_chave aparece em alguma estrutura?
- Toda forma citada em mapa_decisao e em reconhecimento existe nas estruturas?
- Os blocos de reorganização reconstroem exatamente o resultado esperado?
- Cada molde de recombinação contém “…”?
- O campo audios foi omitido?

Depois dessa verificação, entregue somente o JSON final.
```

## Limite da IA

A validação automática confirma a forma do JSON e a coerência interna entre conteúdo e atividades. A naturalidade do mandarim, a escolha do vocabulário e a progressão pedagógica continuam dependendo de revisão humana.

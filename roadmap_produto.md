# Roadmap executável — Mandarim em Rede visual e escrito v2

## Objetivo

Transformar B01 em uma unidade vendável que ensina por meio de elementos visuais, hanzi, pinyin, palavras funcionais, escrita, leitura guiada, reorganização, recombinação, produção e revisão. A oferta não inclui áudio.

## Decisão estratégica

O produto será 100% visual e escrito. Os roteiros em `audio_scripts/` ficam arquivados para uma eventual edição futura e não fazem parte da promessa, do preço ou dos critérios de aprovação atuais.

O produto deve ser vendido como um **workbook visual premium de mandarim**, não como um curso de áudio reduzido.

## Método congelado

```text
situar → observar → reconhecer → ler → recuperar → escrever → reorganizar → recombinar → produzir → revisar
```

Cada etapa precisa aparecer como uma ação concreta no PDF. O estudante deve fazer algo em cada página.

## Arquitetura do tópico

O workbook principal passa a ter dez páginas:

1. situação visual, objetivo e resultado mínimo;
2. mapa de linguagem com hanzi, pinyin e sentido;
3. hanzi-alvo, componentes e escrita controlada;
4. pinyin, tons e leitura guiada;
5. reconhecimento de forma, sentido e situação;
6. recuperação com lacunas e apoio reduzido;
7. reorganização de blocos e ordem da frase;
8. recombinação de slots e banco de palavras;
9. produção escrita e leitura em voz alta;
10. autoavaliação, revisão em 24 horas e revisão em 7 dias.

## Complementos

| Complemento | Páginas | Função |
|---|---:|---|
| P1 — Pronúncia visual e tons | 4 | leitura de pinyin, tons e articulação consciente |
| W1 — Escrita funcional | 4 | recuperação escrita e construção de frases |
| W2 — Hanzi e leitura | 6 | reconhecimento, traços e leitura funcional |
| X1 — Contraste funcional | 4 | decisão entre formas próximas |
| S1 — Vocabulário funcional | 4 | banco de palavras, slots e recombinação |
| Q1 — Quiz de transferência | 8 | fechamento de B01–B04 |
| N1 — Anotações e revisão | 6 | revisão de 24 horas e 7 dias |
| R5 — Consolidação B01–B04 | 12 | combinar os quatro tópicos |

## Primeira coleção

1. B01 — Cumprimentos em contexto;
2. B02 — Perguntar, responder e devolver;
3. B03 — Identificar pessoas e objetos;
4. B04 — Posse e especificação.

A expansão B05–B08 fica para depois do teste do novo método.

## Pacotes comerciais

| Oferta | Conteúdo | Meta B01–B04 |
|---|---|---:|
| Essencial | Workbooks, guia, gabarito e revisão integrada | 56 páginas |
| Premium | Essencial + P1, W1, W2, X1 e S1 | 144–156 páginas |
| Premium Plus | Premium + Q1, N1 e R5 | 170–185 páginas |

A Premium deve conter aproximadamente 128 páginas diretamente destinadas ao aluno. A Premium Plus deve conter aproximadamente 154 páginas diretamente destinadas ao aluno.

## Progressão linguística

Cada tópico deve separar:

- hanzi-alvo;
- hanzi de reconhecimento;
- palavras funcionais;
- estruturas centrais;
- slots substituíveis;
- formas recicladas de tópicos anteriores.

O pinyin deve ser um apoio graduado. A sequência deve passar de hanzi + pinyin para hanzi + pinyin parcial e, depois, hanzi com consulta posterior.

## Estados editoriais

```text
draft → revisão linguística → revisão visual → teste sem áudio → piloto → aprovado → publicado
```

A compilação do PDF não substitui a revisão do mandarim nem o teste com estudante.

## Fases

### Fase 1 — congelar a arquitetura

Registrar a promessa visual e escrita, os pacotes, os nomes dos complementos e a progressão de hanzi.

### Fase 2 — redesenhar B01

Criar o workbook de dez páginas e os cinco complementos visuais. O P1 deve ser chamado de **Pronúncia visual e tons**. O W2 deve trabalhar reconhecimento, traços, recuperação e leitura funcional.

### Fase 3 — teste manual

Aplicar B01 sem áudio. Observar se o estudante consegue situar, reconhecer, ler, escrever, reorganizar, recombinar e produzir.

### Fase 4 — revisão de layout

Usar a faixa confortável de 45–65% de ocupação vertical. Expandir para baixo em páginas de produção, sem comprimir hanzi, pinyin ou campos de escrita.

### Fase 5 — replicar B02–B04

Somente após B01 funcionar, migrar os outros três tópicos para dez páginas e os complementos correspondentes.

### Fase 6 — fechamento Premium Plus

Criar Q1, N1 e R5 como materiais de coleção, não como repetições de cada tópico.

### Fase 7 — pipeline v2

Depois de validar o conteúdo manualmente:

- separar `conteudo_pdf` de `roteiro_audio`;
- criar campos de hanzi-alvo, hanzi de reconhecimento, pinyin, tom visual e slots;
- tornar áudio totalmente opcional ou removê-lo da geração;
- criar templates de dez páginas;
- gerar pacotes Essencial, Premium e Premium Plus.

## Critérios de aprovação B01

B01 estará pronto para piloto quando o estudante conseguir:

- entender a situação pela página;
- localizar os hanzi principais;
- ler com pinyin;
- reconhecer palavras em contexto;
- completar lacunas;
- reorganizar uma frase;
- escrever uma variação;
- ler a própria produção em voz alta;
- produzir com apoio visual reduzido;
- marcar o que precisa revisar.

## Próxima ação concreta

Não produzir mais tópicos ainda. Redesenhar B01 como prova completa do sistema visual e escrito. Depois da validação, replicar a arquitetura em B02, B03 e B04.

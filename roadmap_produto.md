# Roadmap executável — Mandarim em Rede PDF-first

## Objetivo

Transformar B01 em uma unidade PDF-first completa e replicável. O produto deve ensinar por exposição visual, recuperação escrita, leitura guiada, recombinação, produção e revisão, sem depender de áudio próprio.

## Decisão estratégica

A oferta principal não inclui áudio. Os roteiros de áudio B01–B04 permanecem em `audio_scripts/` como arquivo de referência para uma futura edição, parceria ou produção externa. Eles não bloqueiam a geração nem definem a promessa comercial atual.

## Princípios congelados

O percurso central passa a ser:

```text
ver → reconhecer → recuperar → reorganizar → escrever → recombinar → produzir → revisar
```

A tipografia v2, a capa, o fundo premium, as cores, as fontes e o tratamento dos hanzi continuam congelados como sistema visual.

## Arquitetura do tópico

Cada tópico deve ter um workbook principal de oito páginas:

1. entrada visual, situação, objetivo e resultado mínimo;
2. estruturas centrais com hanzi, pinyin e sentido;
3. pronúncia visual, tons e leitura guiada;
4. mapa completo, mapa lacunado e reconhecimento;
5. reorganização de blocos e recuperação escrita;
6. recombinação de slots e contraste funcional;
7. produção oral e escrita em situação nova;
8. autoavaliação, revisão em 24 horas e revisão em 7 dias.

Os complementos Premium recomendados são P1 — Pronúncia visual e tons, W1 — Escrita funcional, W2 — Hanzi e leitura, X1 — Contraste funcional e S1 — Vocabulário funcional. Cada complemento deve ter quatro páginas, incluindo capa quando necessário.

## Coleção inicial

A primeira coleção continua formada por quatro tópicos:

1. B01 — Cumprimentos em contexto;
2. B02 — Perguntar, responder e devolver;
3. B03 — Identificar pessoas e objetos;
4. B04 — Posse e especificação.

B05–B08 ficam para uma fase posterior:

1. B05 — Números e informações pessoais;
2. B06 — Pedir repetição e confirmação;
3. B07 — Preferências e ações simples;
4. B08 — Encerrar, revisar e transferir.

## Pacotes comerciais

| Oferta | Conteúdo-alvo |
|---|---|
| Essencial | Workbook, guia curto, gabarito e páginas de revisão |
| Premium | Essencial + P1, W1, W2, X1 e S1 |
| Premium Plus | Premium + Q1, N1 e R5 de consolidação do bloco |

Para B01–B04, as metas de páginas são:

| Oferta | Meta de páginas |
|---|---:|
| Essencial | aproximadamente 44 páginas |
| Premium | aproximadamente 128–140 páginas |
| Premium Plus | aproximadamente 152–168 páginas |

A oferta Premium Plus deve conter aproximadamente 136 páginas diretamente destinadas ao aluno.

## Fases

### Fase 1 — decisão e nomenclatura

Concluída quando a promessa PDF-first, os pacotes e o papel opcional dos roteiros estiverem registrados.

### Fase 2 — B01 PDF-first

Redesenhar B01 para oito páginas. Reescrever P1 como pronúncia visual e tons. Integrar tarefas de leitura, recuperação, escrita, hanzi, contraste, recombinação e produção.

### Fase 3 — teste manual

Aplicar B01 sem áudio. Registrar onde o estudante para, copia, consulta ou abandona. Corrigir primeiro o fluxo, depois a estética.

### Fase 4 — replicação B02–B04

Adaptar a estrutura validada de B01 aos três tópicos seguintes. Cada tópico deve passar por revisão linguística antes da geração final.

### Fase 5 — fechamento do bloco

Criar Q1 — Quiz de transferência, N1 — Anotações e revisão e R5 — Consolidação B01–B04.

### Fase 6 — pipeline v2

Alterar o schema e o gerador para:

- tornar `audios` opcional;
- separar `conteudo_pdf` de `roteiro_audio`;
- criar templates de workbook de oito páginas;
- parametrizar hanzi, pinyin, tons, slots e produção;
- gerar Essencial, Premium e Premium Plus;
- registrar claramente quando um pacote não contém áudio.

## Portões de aprovação

```text
draft → revisão linguística → revisão visual → teste sem áudio → piloto → aprovado → publicado
```

A compilação não equivale à aprovação. O conteúdo em mandarim e a experiência real de estudo ainda exigem revisão humana.

## Métricas do teste sem áudio

| Indicador | Pergunta |
|---|---|
| Orientação | O estudante sabe por onde começar? |
| Recuperação | Ele tenta antes de copiar? |
| Leitura | Hanzi e pinyin cumprem papéis distintos? |
| Escrita | A escrita ajuda a lembrar? |
| Oralidade | Ele consegue ler e produzir a forma? |
| Transferência | Ele troca um slot e mantém o padrão? |
| Revisão | Ele retorna em 24 horas e 7 dias? |
| Valor | O conjunto parece um sistema premium? |

## Próxima ação concreta

Redesenhar somente B01 como unidade PDF-first completa. Não expandir B02–B04 nem alterar o schema antes de verificar se B01 conduz o estudante até a produção sem áudio próprio.

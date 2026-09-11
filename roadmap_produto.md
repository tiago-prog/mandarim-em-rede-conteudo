# Roadmap executável — Mandarim em Rede visual e escrito v3

## Objetivo

Construir uma biblioteca visual de mandarim prático, organizada por tópicos do cotidiano e centrada em hanzi, palavras, pinyin, escrita, leitura guiada, situações e produção funcional. A oferta não inclui áudio.

## Produto vendido

O Mandarim em Rede será uma coleção de workbooks visuais para adultos iniciantes que desejam aprender mandarim por situações práticas, como aeroporto, hotel, transporte, restaurante, compras e interações básicas.

O catálogo completo terá 24 tópicos. A primeira coleção comercial terá oito.

## Método congelado

```text
situar → observar → reconhecer → ler → recuperar → escrever → reorganizar → recombinar → produzir → revisar
```

Cada tópico deve produzir um resultado escrito e prático. O estudante não deve apenas ler explicações.

## Arquitetura de cada tópico

O workbook principal terá 12 páginas:

1. capa funcional, resultado e situação;
2. cena visual e tarefa;
3. banco de 8–12 palavras;
4. mapa de 2–4 estruturas;
5. hanzi-alvo e escrita controlada;
6. pinyin, tons e leitura;
7. reconhecimento;
8. recuperação escrita;
9. reorganização de blocos;
10. recombinação de slots;
11. produção prática com artefato visual;
12. revisão e anotações.

## Catálogo completo de 24 tópicos

### Coleção 1 — Primeiras interações

B01 Cumprimentos em contexto  
B02 Nome e identidade  
B03 Números e contatos  
B04 Pessoas e objetos  
B05 Posse e relações  
B06 Perguntar e devolver

### Coleção 2 — Deslocamento e viagem

V01 Aeroporto e check-in  
V02 Imigração e bagagem  
V03 Hotel e hospedagem  
V04 Transporte e táxi  
V05 Direções e localização  
V06 Horários e itinerários

### Coleção 3 — Comer, comprar e pagar

C01 Restaurante e pedido  
C02 Preferências e ingredientes  
C03 Conta e pagamento  
C04 Mercado e loja de conveniência  
C05 Compras e preços  
C06 Serviços do dia a dia

### Coleção 4 — Vida diária e autonomia

D01 Rotina e atividades  
D02 Família e pessoas  
D03 Trabalho e estudo  
D04 Convites e planos  
D05 Ajuda, saúde e emergência  
D06 Mensagens e revisão

## Primeira coleção comercial

A primeira entrega terá oito tópicos:

1. B01 — Cumprimentos em contexto;
2. B02 — Nome e identidade;
3. B03 — Números e contatos;
4. B04 — Pessoas e objetos;
5. V01 — Aeroporto e check-in;
6. V03 — Hotel e hospedagem;
7. V04 — Transporte e táxi;
8. C01 — Restaurante e pedido.

Essa coleção combina fundamentos com situações imediatas de viagem.

## Complementos

| Complemento | Escala | Função |
|---|---:|---|
| W1 — Laboratório de escrita | 6 páginas por tópico | recuperar palavras e frases |
| W2 — Hanzi e leitura | 6 páginas por tópico | reconhecer, escrever e ler caracteres |
| V1 — Vocabulário visual | 4 páginas por tópico | organizar palavras e combinações |
| X1 — Contraste funcional | 4 páginas por tópico | escolher entre formas próximas |
| R1 — Revisão e anotações | 4 páginas por tópico ou coleção | registrar dificuldades e agenda |
| Q1 — Quiz de transferência | 8 páginas por coleção | verificar uso misturado |
| R5 — Consolidação | 12 páginas por coleção | integrar os tópicos |

## Pacotes

| Oferta | Conteúdo | Volume estimado para 8 tópicos |
|---|---|---:|
| Essencial | workbooks, guia e gabarito | 110–125 páginas |
| Premium | Essencial + W1, W2 e V1 | 244–254 páginas |
| Premium Plus | Premium + X1, R1, Q1 e R5 | 333–343 páginas |

Os números são metas de arquitetura. Nenhum PDF deve entrar apenas para aumentar volume.

## Fases de produção

### Fase 1 — sistema visual

Congelar capa, tipografia, paleta, cartões, mapas, áreas de escrita, formulários, códigos de seção e tratamento de hanzi.

### Fase 2 — protótipo B01 — concluída tecnicamente

B01 foi implementado integralmente com 12 páginas. O protótipo inclui cena visual, banco de palavras, hanzi, pinyin, recuperação escrita, reorganização, recombinação, produção prática e revisão. As auditorias e protótipos históricos estão em `archive/prototypes/B01-pdf-first/`; a fonte ativa está em `templates/b01/B01-workbook.typ`.

### Fase 3 — teste de uso — próxima etapa

Entregar B01 a leitores externos. Medir onde o estudante para, copia, consulta, confunde hanzi e pinyin ou não entende a instrução.

### Fase 4 — correção do sistema

Corrigir fluxo, densidade, tipografia, espaço de escrita e instruções. Só depois congelar o template.

### Fase 5 — primeira coleção de oito tópicos

Produzir B02, B03, B04, V01, V03, V04 e C01 usando o template validado.

### Fase 6 — complementos

Produzir W1, W2 e V1 para os oito tópicos. Depois criar X1 e R1.

### Fase 7 — fechamento da coleção

Criar Q1 e R5 para misturar os oito tópicos. D06 poderá funcionar como unidade de revisão posterior.

### Fase 8 — expansão do catálogo

Produzir as três coleções restantes em blocos de quatro tópicos, sempre após testar o bloco anterior.

## Portões de aprovação

```text
draft → revisão linguística → revisão visual → teste de uso → piloto comercial → aprovado → publicado
```

A compilação do PDF não equivale à aprovação. Toda unidade precisa de revisão linguística e teste de uso.

## Critérios de qualidade

Cada tópico deve respeitar:

- 8–12 palavras novas;
- 4–8 hanzi-alvo;
- 2–4 estruturas centrais;
- 1 ou 2 situações principais;
- 1 artefato prático;
- áreas de escrita reais;
- no máximo cinco critérios na autoavaliação;
- ocupação visual preferencial entre 45% e 65%;
- nenhuma informação essencial dependente de cor isolada.

## Pipeline futuro

O pipeline deverá ser atualizado somente depois do protótipo B01:

- separar conteúdo visual, linguístico e comercial;
- registrar hanzi-alvo e hanzi de reconhecimento;
- registrar banco de palavras e categorias;
- registrar estruturas fixas e slots;
- registrar artefato prático;
- gerar workbook de 12 páginas;
- gerar complementos por pacote;
- tornar áudio ausente da oferta e opcional no arquivo histórico.

## Próxima ação concreta

Implementar somente o B01 completo como protótipo visual e escrito. Não gerar os 24 tópicos em massa antes do teste de uso do primeiro tópico.

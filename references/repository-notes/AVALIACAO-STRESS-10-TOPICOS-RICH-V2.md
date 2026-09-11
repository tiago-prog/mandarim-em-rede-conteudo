# Avaliação de stress — lote de 10 tópicos rich v2

## 1. Escopo

Foi produzido um lote real de dez unidades PDF-first rich v2, usando as referências existentes do repositório como base de progressão e organização lexical. O lote cobre B02–B11 e foi compilado pelo pipeline oficial, sem substituir o template por arquivos de apresentação manuais.

A referência HSK1 foi usada como base para o banco lexical, a separação entre palavra-alvo, pinyin, sentido e frase, e a progressão de funções comunicativas. Os materiais B01–B04 existentes foram usados para preservar a continuidade da coleção e migrar B04 para o contrato rico.

## 2. Tópicos gerados

| Código | Tópico | Função comunicativa principal |
|---|---|---|
| B02 | Perguntar, responder e devolver | manter uma troca curta |
| B03 | Identificar pessoas e objetos | perguntar o que/quem é algo ou alguém |
| B04 | Posse e especificação | perguntar e responder de quem é um objeto |
| B05 | Números e informações pessoais | informar idade, telefone e quantidades |
| B06 | Horários e agenda | perguntar e informar horários |
| B07 | Localização e direções | perguntar onde algo ou alguém está |
| B08 | Pedidos em café ou restaurante | fazer pedidos e confirmar escolhas |
| B09 | Preferências e escolhas | dizer gostos, recusas e opções |
| B10 | Capacidade e pedidos de ajuda | dizer o que consegue fazer e pedir ajuda |
| B11 | Rotina e atividades | falar de atividades cotidianas |

A matriz de coleção contém também B01 como ponto de entrada, totalizando onze posições progressivas no mapa canônico.

## 3. Resultado técnico do lote

| Métrica | Resultado |
|---|---:|
| Unidades rich v2 no lote | 10 |
| Unidades validadas | 10 |
| Builds aprovados | 10 |
| Builds falhos | 0 |
| Páginas por unidade | 11 |
| Páginas totais | 110 |
| Perfis de template usados | 1 |
| Áudio incluído | 0 unidades |
| Warnings individuais após correção | 0 |
| Entradas no índice lexical cumulativo | 67 |

O manifesto usado foi `content/pdf_first/colecao_01_rich_10_topicos.json`, com política de paginação `range` entre 11 e 13 páginas. Todas as unidades permaneceram em 11 páginas.

## 4. Stress de quantidade

O lote comprova que o pipeline consegue gerar dez unidades semanticamente diferentes no mesmo ciclo sem copiar manualmente PDFs, páginas ou templates. Cada unidade foi validada individualmente, incluída em um manifesto rich v2, compilada, verificada pelo portão conteúdo↔PDF e empacotada em ZIP.

A execução demonstra que o sistema suporta a passagem de uma unidade-piloto para uma coleção inicial de dez tópicos. O catálogo de progressão e o índice lexical também passaram separadamente pelo validador.

## 5. Correções encontradas durante o stress

O stress não foi tratado como simples geração automática. A primeira rodada encontrou incompatibilidades reais:

- alternativas de reconhecimento apontavam para pinyin em vez de formas mandarim;
- uma reconstrução não correspondia a uma estrutura declarada;
- alguns bancos lexicais ficaram abaixo da cardinalidade mínima;
- algumas categorias lexicais não pertenciam ao vocabulário permitido;
- alguns moldes não tinham marcador explícito de slot;
- um termo lexical não aparecia integralmente em nenhuma estrutura.

Esses problemas foram corrigidos no gerador e o lote foi regenerado. A rodada final terminou com dez unidades válidas e zero warnings.

Esse resultado é importante: o pipeline não apenas compilou o conteúdo; ele expôs falhas de contrato que seriam fáceis de deixar passar em produção manual.

## 6. Avaliação de diversidade

A diversidade funcional é suficiente para um stress inicial de quantidade. O lote percorre:

```text
interação
→ identificação
→ posse
→ informação numérica
→ horário
→ localização
→ pedido
→ preferência
→ capacidade
→ rotina
```

Há progressão de situações sociais para situações práticas e, depois, para expressão pessoal e rotina. Isso fornece variedade suficiente para avaliar se um único template consegue acomodar objetivos diferentes.

O lote ainda não representa dez famílias visuais diferentes. Todas as unidades usam `b-family-workbook-v1`. Portanto, o stress confirma a capacidade de produção em massa dentro de uma família, mas não valida ainda a necessidade de múltiplos templates especializados.

## 7. O que foi comprovado

O lote comprova:

- repetibilidade do contrato rich v2;
- validação estrutural de dez unidades;
- compatibilidade do manifesto de lote rich v2;
- progressão formal no catálogo;
- existência do índice lexical cumulativo;
- compilação de 110 páginas;
- paginação estável em 11 páginas por unidade;
- geração dos pacotes ZIP;
- ausência de áudio no produto final;
- rejeição de erros estruturais antes da compilação;
- capacidade de corrigir falhas descobertas pelo próprio stress test.

## 8. O que ainda não foi comprovado

O lote ainda não comprova:

- revisão por falante nativo de mandarim;
- correção independente de todos os tons e pinyin;
- naturalidade cultural de cada frase;
- adequação das traduções ao português brasileiro;
- eficácia real das atividades com alunos;
- retenção oral após revisão espaçada;
- qualidade visual por inspeção humana página a página;
- necessidade de variações de template por função comunicativa;
- equilíbrio final de carga cognitiva entre os dez tópicos.

A aprovação técnica não deve ser confundida com aprovação linguística ou publicação comercial.

## 9. Riscos ainda abertos

### Revisão linguística

As unidades foram estruturadas e validadas automaticamente. O mandarim deve passar por revisão humana antes de ser marcado como aprovado ou publicado.

### Homogeneidade visual

O mesmo template foi capaz de renderizar todos os tópicos, mas isso pode esconder uma limitação: pedidos, horários, localização e preferências talvez se beneficiem de componentes visuais próprios.

### Escala além de dez unidades

O lote confirma a primeira escala significativa, mas ainda é necessário testar 20–30 unidades semanticamente distintas, com introdução e reciclagem lexical mais densas.

### Conteúdo de consolidação

B11 fecha um primeiro arco de situações, mas ainda não é uma aula de consolidação formal. O próximo lote deve incluir unidades de revisão cumulativa e transferência.

## 10. Veredito

```text
Stress quantitativo: APROVADO
Stress de contrato: APROVADO
Stress de paginação: APROVADO para esta densidade
Stress de progressão: APROVADO como primeira matriz
Stress linguístico: PENDENTE DE REVISÃO HUMANA
Stress de produto com alunos: PENDENTE DE PILOTO
```

A arquitetura agora suporta uma produção em lote inicial de dez tópicos reais. O próximo passo recomendado não é gerar volume indefinidamente, mas revisar linguisticamente B02–B11, testar o uso com alunos e então criar um segundo lote com consolidações e variações de template.

> **O sistema passou do estágio “consegue compilar uma unidade” para o estágio “consegue produzir uma coleção inicial”. Ainda falta provar que a coleção ensina tão bem quanto compila.**

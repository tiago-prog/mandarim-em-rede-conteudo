# Roadmap executável — Mandarim em Rede

## Objetivo

Transformar o MVP B01 em uma linha de produção modular capaz de gerar unidades essenciais, complementos e módulos completos a partir de arquivos JSON revisados.

## Princípios congelados

O núcleo do produto continua sendo ouvir, tentar, consultar, reconstruir, recombinar, transferir e revisar. O áudio apresenta a língua; o mapa reduz a carga de memória; a escrita serve à recuperação; a fala continua sendo o resultado principal.

A tipografia v2 está congelada como tema visual de referência. O fundo premium, as cores, as fontes e o tratamento dos hanzi não devem ser redefinidos dentro de cada unidade.

## Fase 0 — concluída

A primeira unidade foi criada, revisada visualmente e ajustada tipograficamente. O problema dos fundos compactos atrás das palavras foi corrigido. O resultado foi compilado em A4 e verificado.

## Fase 1 — pipeline v1

A primeira implementação deve resolver apenas o necessário para produção segura:

| Entrega | Critério de saída |
|---|---|
| Schema JSON v1 | Uma estrutura única para conteúdo e pacotes |
| Validador | Campos ausentes e inconsistências são bloqueados antes da compilação |
| Gerador | Um comando gera workbook, roteiros, guia e manifesto |
| B01 de regressão | O pipeline recompila a unidade piloto com sucesso |
| ZIP da unidade | O pacote pode ser entregue sem organização manual |

## Fase 2 — conteúdo B02–B04

Produzir três unidades essenciais, cada uma com um único objetivo comunicativo:

1. B02 — perguntas sim/não com 吗 e devolução com 呢;
2. B03 — identificar pessoas e objetos com 这, 那, 谁 e 什么;
3. B04 — posse e especificação com 的.

Cada unidade deve passar por revisão linguística antes da renderização final. O gerador não deve ser usado para esconder conteúdo ainda não aprovado.

## Fase 3 — piloto comercial

Aplicar B01 ou B01–B03 a um grupo pequeno de estudantes. O piloto deve observar compreensão do fluxo, tentativa antes da consulta, uso do mapa lacunado, produção em situação nova e interesse em adquirir a próxima unidade.

O resultado do piloto deve alterar o JSON, não apenas anotações soltas. Cada mudança precisa indicar se foi pedagógica, linguística, visual ou comercial.

## Fase 4 — complementos

Depois do núcleo B02–B04, produzir complementos selecionáveis:

| Complemento | Gatilho de inclusão |
|---|---|
| P1 | dificuldade em tons, ritmo ou percepção |
| W1 | necessidade de recuperação escrita curta |
| W2 | objetivo explícito de reconhecimento ou formação de hanzi |
| X1 | contraste entre partículas ou padrões próximos |
| S1 | vocabulário operacional maior para a situação |
| Q1 | diagnóstico de transferência ou fechamento de bloco |
| N1 | revisão autônoma |
| R5 | consolidação de três ou quatro unidades |

## Fase 5 — escala controlada

Somente depois de validar o núcleo e os complementos, ampliar a quantidade de unidades. A produção em massa deve manter três portões: validação do JSON, revisão linguística e revisão visual do PDF.

## Estados de uma unidade

```text
draft → revisão linguística → revisão visual → piloto → aprovado → publicado
```

Nenhuma unidade deve ser publicada automaticamente logo após a compilação. O gerador automatiza a produção; a aprovação continua sendo uma decisão editorial.

## Próxima ação concreta

Executar o pipeline v1 com B01, comparar o PDF gerado com a versão revisada atual e, se o resultado for estável, criar os JSONs de trabalho de B02, B03 e B04 para revisão linguística.

# Análise do repositório Mandarim em Rede — Conteúdo

**Data da análise:** 11 de setembro de 2026  
**Repositório:** [tiago-prog/mandarim-em-rede-conteudo][1]  
**Branch analisada:** `main`  
**Commit analisado:** `b05a0c1` — “nova referencia, para criar praticas de escrita”

## Conclusão executiva

O repositório é um **pipeline de produção editorial para workbooks de mandarim em PDF**, e não uma aplicação web convencional. A arquitetura atual separa conteúdo estruturado em JSON, regras de validação, templates Typst, renderização de capa, geração de PDF, verificação e empacotamento ZIP.

O projeto está em um estágio tecnicamente funcional para o protótipo **B01 — Cumprimentos em contexto**. O build reproduzido nesta análise gerou um workbook de **13 páginas A4**, verificou o PDF e produziu um pacote distribuível sem áudio. O código Python também passou na compilação sintática.

A principal limitação não é a geração do B01. É a **escalabilidade editorial**: o registro possui apenas um perfil de template, B02–B04 ainda não têm templates próprios no lote PDF-first, e o produto planejado para oito tópicos ainda está representado por um único item no manifesto de produção. Antes de produzir em massa, é necessário consolidar os contratos de dados, automatizar os testes e realizar revisão linguística e teste com alunos reais.

## Inventário observado

| Área | Situação encontrada | Avaliação |
|---|---|---|
| Conteúdo | Unidades B01–B04 em JSON, além de versões históricas, rascunhos e manifests | Bom, mas há arquivos de naturezas diferentes no mesmo diretório |
| Pipeline PDF-first | Geração de capa, workbook Typst, verificação, manifesto e ZIP | Funcional para B01 |
| Templates | Um perfil registrado: `b01-cumprimentos-v2` | Principal gargalo para expansão |
| Schemas | Schemas JSON para unidade e lote | Existem, mas o validador Python não os aplica integralmente |
| Documentação | README, guia de produção, prompts, estratégia e roadmap | Forte e relativamente clara |
| Áudio | Roteiros preservados como histórico | Coerente com a decisão atual de produto sem áudio |
| Testes | Compilação Python, validação manual e auditorias visuais do B01 | Ainda não há suíte automatizada de regressão |
| Artefatos gerados | PDFs, ZIPs, imagens e builds versionados no Git | Útil para referência, mas aumenta o repositório e o risco de divergência |

## Arquitetura e fluxo

O fluxo recomendado é:

```text
JSON de conteúdo
    → validação PDF-first
    → seleção do perfil em templates/registry.json
    → renderização da capa
    → cópia do template Typst e dos assets
    → compilação estrita do PDF
    → verificação estrutural do PDF
    → conferência do número de páginas
    → manifesto de build
    → pacote ZIP
```

O conteúdo é corretamente tratado como fonte editorial, enquanto o Typst controla a apresentação. Essa separação permite revisar o texto sem reescrever todo o layout e permite associar diferentes famílias de tópicos a templates específicos.

## Pontos fortes

### Separação entre conteúdo e apresentação

Os conteúdos estão em JSON e os workbooks em Typst. Essa decisão é adequada para produção repetível e para eventual geração assistida por IA. O prompt documentado também restringe a IA à criação do conteúdo estruturado, sem permitir que ela altere o template ou gere arquivos de apresentação diretamente.

### Proteções contra aplicação indevida de template

O gerador exige que o perfil de template exista no registro e falha quando o perfil não é encontrado. Essa proteção é importante: evita aplicar o layout de B01 a qualquer tópico apenas porque a estrutura do comando permite fazê-lo.

### Pipeline reproduzível

O build executa validação do conteúdo, gera a capa, compila o Typst em modo estrito, chama a verificação do PDF, confirma a paginação e cria um pacote. O resultado é rastreado em `build-manifest.json` e no relatório do lote.

### Decisão de produto bem explicitada

A documentação é consistente ao registrar que o produto atual é visual e escrito e que os roteiros de áudio são históricos. Isso reduz o risco de alguém interpretar a presença de `archive/audio-scripts/` como requisito de geração do produto atual.

### Protótipo B01 auditado

O repositório contém versões de teste de estresse, métricas e registros de achados visuais. Isso demonstra uma preocupação correta com densidade, paginação, área de escrita e integração da capa, em vez de considerar apenas a compilação bem-sucedida como critério de qualidade.

## Problemas e riscos prioritários

| Prioridade | Problema | Evidência | Impacto | Recomendação |
|---|---|---|---|---|
| Alta | Apenas um template está registrado | `templates/registry.json` contém somente `b01-cumprimentos-v2` | B02–B04 e os demais tópicos não podem ser produzidos em massa com layouts apropriados | Criar um perfil Typst validado por família de tópico e adicionar testes de compilação por perfil |
| Alta | O lote atual contém somente B01 | `content/pdf_first/colecao_01_batch.json` possui uma unidade | A documentação fala em coleção, mas a execução real ainda é um piloto unitário | Criar manifestos explícitos para B01–B04 e, depois, para os oito tópicos comerciais, sempre após validar cada template |
| Alta | Validador Python não usa os schemas JSON | `schema/pdf_first_unit_v1.schema.json` existe, mas `scripts/validate_pdf_first.py` implementa regras manualmente | O contrato declarado e o comportamento real podem divergir sem aviso | Usar uma biblioteca de JSON Schema ou gerar testes que comparem o validador Python com o schema |
| Média | Validação indiscriminada de todos os JSONs produz falsos erros | Arquivos como `B01-B04-colecao.json` e manifests não são unidades PDF-first | Operadores podem interpretar arquivos auxiliares como conteúdo inválido | Separar diretórios por tipo ou criar comandos distintos: `validate-unit`, `validate-batch` e `validate-manifest` |
| Média | Validações duplicadas e divergentes | `validate_unit.py` é legado e exige áudio; `scripts/validate_pdf_first.py` ignora áudio | A mesma unidade pode passar em um fluxo e falhar em outro | Declarar o legado como compatibilidade, documentar a matriz de uso e compartilhar regras comuns |
| Média | Artefatos gerados estão versionados | PDFs, ZIPs, imagens e diretórios de build aparecem rastreados | O repositório cresce rapidamente e pode conter builds desatualizados | Decidir entre manter apenas artefatos de release ou mover builds para CI/releases; adicionar regras de `.gitignore` quando apropriado |
| Média | Dependências externas do gerador são fixadas por caminho absoluto | `build_pdf_batch.py` aponta para `/home/ubuntu/skills/typst-pdf-maker/scripts/...` | O pipeline não é portável para outro computador ou CI sem adaptação | Resolver scripts por configuração, variável de ambiente ou dependência empacotada no projeto |
| Baixa | O código não valida todos os campos do manifesto antes de usá-los | `build_one()` acessa `material` e `edicao` diretamente | Erros de manifesto podem aparecer como exceções pouco específicas | Validar integralmente cada item antes do processamento e retornar mensagens de erro orientadas ao arquivo |

## Verificações executadas

| Verificação | Resultado |
|---|---|
| Clone via GitHub CLI | Aprovado; repositório público encontrado e clonado |
| Branch e histórico | `main`, sem branches adicionais relevantes; histórico recente concentra a implementação do pipeline |
| Compilação sintática Python | Aprovada com `python3 -m compileall -q .` |
| Dependências | `cairosvg` e `Pillow` instalados conforme `requirements.txt` |
| Validação PDF-first do conteúdo B01 | Aprovada; com aviso histórico de áudio |
| Build do lote atual | Aprovado: 1 PASS, 0 FAIL |
| PDF produzido | Aprovado: 13 páginas |
| Pacote distribuível | Produzido em ZIP pelo pipeline |
| Validação legada B01–B04 | Aprovada para os quatro arquivos principais; o validador legado exige áudio e não representa o fluxo atual |
| Revisão linguística do mandarim | Não realizada nesta análise |
| Teste de uso com alunos | Não realizado; permanece como próxima etapa do roadmap |

O primeiro build falhou antes da instalação das dependências porque `cairosvg` não estava disponível no ambiente. Depois da instalação de `requirements.txt`, o mesmo comando passou integralmente. Portanto, esse primeiro erro foi **ambiental**, não uma falha lógica do pipeline.

## Observações sobre o conteúdo

Os arquivos B01–B04 principais estão estruturados com código, título, nível, status editorial, objetivo comunicativo, resultado mínimo, situação, estruturas, sequência e pacotes. A quantidade de estruturas observada está dentro da faixa declarada de 2 a 12.

O estado editorial está corretamente representado como parte do conteúdo. Entretanto, o status `revisao_linguistica` de B01–B04 indica que os arquivos ainda não devem ser tratados como material publicado. A compilação do PDF comprova consistência técnica, mas não comprova correção do mandarim, adequação pedagógica ou clareza para um aluno iniciante.

Também existe uma possível fonte de confusão de nomenclatura no roadmap: a lista da Coleção 1 e os arquivos B02–B04 não parecem seguir exatamente a mesma ordem temática em todos os documentos. Recomenda-se manter um catálogo canônico único, com código, título comercial, nome do arquivo e próxima unidade, para evitar que conteúdo, roadmap e manifesto se desalinhem.

## Plano recomendado

### Próxima etapa imediata

Consolidar o contrato de dados. O projeto deve escolher um único ponto de validação oficial para cada tipo de arquivo. A opção mais segura é manter os schemas como fonte normativa e fazer os scripts validarem contra eles, acrescentando apenas regras editoriais que não possam ser expressas em JSON Schema.

### Etapa seguinte

Criar uma matriz de cobertura de templates. Cada tópico deve apontar para um perfil existente, para um arquivo Typst, para assets, para o número esperado de páginas e para o status de validação. Um perfil só deve ser marcado como `pilot` depois de compilação, verificação estrutural e inspeção visual.

### Antes da produção em massa

Adicionar testes automatizados. O conjunto mínimo deve validar todos os JSONs de unidade, todos os manifests de lote, a existência dos templates registrados, a compilação de cada perfil e a ausência de arquivos fora do pacote final. O build deve ser executado em ambiente limpo, não apenas no diretório de desenvolvimento.

### Validação de produto

Executar um piloto com alunos reais usando B01. Registrar onde os alunos interrompem a atividade, confundem hanzi e pinyin, não entendem as instruções ou precisam de espaço adicional. Esses dados devem orientar o congelamento do template antes da criação de B02–B08.

### Higienização do repositório

Separar claramente fontes, protótipos, exemplos e artefatos de distribuição. O arquivo ZIP `archive/snapshots/mandarim-em-rede-main (1).zip` parece ser um snapshot de referência dentro do próprio repositório. Se ele não for necessário para o fluxo editorial, deve ser removido ou movido para releases externas, pois duplica conteúdo e dificulta a manutenção.

## Veredito

**Classificação: protótipo funcional, pronto para piloto controlado; ainda não pronto para produção em massa.**

O núcleo técnico está bem encaminhado e o B01 é reproduzível. A prioridade deve ser **governança do conteúdo e dos templates**, não adicionar volume de tópicos imediatamente. O risco maior seria escalar a geração antes de estabilizar o schema oficial, os perfis Typst e o teste de uso pedagógico.

## Referências

[1]: https://github.com/tiago-prog/mandarim-em-rede-conteudo "Repositório Mandarim em Rede — Conteúdo"

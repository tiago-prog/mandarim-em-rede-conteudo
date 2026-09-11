# Arquitetura de automação PDF-first — Mandarim em Rede

## Decisão

A produção em massa deve ser organizada em três camadas separadas: **conteúdo**, **perfil de template** e **manifesto de lote**. O conteúdo descreve o tópico linguístico. O perfil de template define qual fonte Typst e qual identidade visual serão usadas. O manifesto informa quais tópicos devem ser gerados, com qual edição e para qual pacote.

Essa separação evita o erro mais perigoso do pipeline anterior: produzir rapidamente um PDF visualmente correto, mas semanticamente inadequado para um tópico diferente. O gerador só deve criar um arquivo quando o tópico estiver associado a um perfil de template explicitamente registrado.

## Frente 1 — capa do workbook

A capa agora é uma primeira página editorial do workbook. Ela não é uma imagem fixa repetida sem contexto. O renderer `scripts/render_workbook_cover.py` recebe um JSON e preenche os campos variáveis do material:

| Campo | Origem | Exemplo B01 |
|---|---|---|
| Código | `unidade.codigo` | B01 |
| Número do tópico | `unidade.numero` ou código | TÓPICO 01 |
| Título | `unidade.titulo` | CUMPRIMENTOS EM CONTEXTO |
| Material | item do manifesto | WORKBOOK DO ALUNO |
| Edição | item do manifesto | EDIÇÃO 01 · 2026 |
| Hanzi de amostra | primeira estrutura | 你好。 |
| Pinyin | primeira estrutura | Nǐ hǎo. |
| Sentido | primeira estrutura | Olá. |

A capa preserva a identidade visual aprovada, mas atualiza a promessa para a estratégia atual: **“Sistema visual para transformar leitura em produção escrita.”** A linguagem de áudio foi retirada da capa do workbook. O fluxo visual exibido é “observe, escreva, organize, recombine, transfira, produza”.

O workbook B01 produzido atualmente tem **13 páginas físicas**: uma capa e doze páginas pedagógicas. As doze páginas existentes continuam sendo o núcleo de trabalho; a capa funciona como a entrada editorial do produto.

## Frente 2 — geração em massa

O novo comando de produção é:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/colecao_01_batch.json \
  --output-root build/pdf-first
```

O fluxo realiza as seguintes etapas em ordem:

1. valida a configuração do lote;
2. localiza o perfil de template no registro;
3. valida o JSON da unidade;
4. cria um diretório limpo para a unidade;
5. renderiza a capa a partir do conteúdo e da edição;
6. copia a fonte Typst e os assets do perfil;
7. compila o PDF em modo estrito;
8. executa a verificação determinística do PDF;
9. confirma o número esperado de páginas;
10. grava o manifesto individual da build;
11. cria o ZIP distribuível;
12. registra o resultado no relatório consolidado do lote.

O gerador interrompe a unidade que falhar por padrão. A opção `--continue-on-error` permite processar todos os itens e consolidar falhas sem esconder quais tópicos não foram produzidos.

## Componentes do sistema

| Componente | Responsabilidade |
|---|---|
| `content/*.json` | Fonte linguística e pedagógica da unidade |
| `content/pdf_first/*.json` | Seleção de unidades para um lote |
| `templates/registry.json` | Registro de perfis, fontes, assets e páginas esperadas |
| `templates/assets/capa-base.webp` | Fundo-base da capa-mestre |
| `templates/assets/bg-fundo-prime.png` | Fundo dos workbooks pedagógicos |
| `scripts/render_workbook_cover.py` | Capa parametrizada em PNG e SVG |
| `scripts/build_pdf_batch.py` | Orquestração, compilação, QA e empacotamento |
| `prototypes/B01-pdf-first/B01-workbook.typ` | Perfil Typst validado do B01 |
| `build/pdf-first/` | Saída reproduzível do lote |

## Estrutura do pacote gerado

Cada unidade recebe uma pasta própria. O pacote B01 de exemplo contém:

```text
B01/
├── B01-workbook.pdf
├── B01-content.json
├── B01-cover-content.json
├── B01-workbook-package.zip
├── build-manifest.json
├── README.md
├── workbook.typ
├── report-theme.typ
└── assets/
    ├── bg-fundo-prime.png
    ├── capa-workbook.png
    └── capa-workbook.svg
```

O arquivo `B01-cover-content.json` é uma cópia enriquecida usada apenas pela capa. Ele preserva o JSON linguístico original e acrescenta material, edição e número do tópico sem modificar a fonte editorial.

## Como adicionar um novo tópico

A criação de B02, B03 ou B04 não deve começar pela cópia automática do perfil B01. O processo correto é criar um novo perfil no registro:

```json
{
  "b02-perguntar-responder-v1": {
    "label": "B02 — workbook visual e escrito",
    "source": "prototypes/B02-pdf-first/B02-workbook.typ",
    "expected_pages_without_cover": 12,
    "expected_pages_with_cover": 13,
    "cover_renderer": "scripts/render_workbook_cover.py",
    "cover_asset": "templates/assets/capa-base.webp",
    "background_asset": "templates/assets/bg-fundo-prime.png",
    "status": "draft"
  }
}
```

Depois, o novo tópico deve ser acrescentado ao manifesto de lote com seu próprio `template_profile`. O gerador passará a tratá-lo como uma unidade independente. A capa será reutilizada como sistema, mas o workbook pedagógico deverá ser revisado para as estruturas específicas de B02.

## Portões de qualidade

A produção em massa só deve ser considerada bem-sucedida quando todos os portões abaixo forem aprovados:

| Portão | Pergunta de controle |
|---|---|
| Conteúdo | O JSON passou pela revisão linguística necessária? |
| Template | O perfil existe e aponta para uma fonte própria do tópico? |
| Capa | Título, código, edição, hanzi e pinyin foram preenchidos sem placeholder? |
| Compilação | Typst compilou sem warnings? |
| Estrutura | O PDF tem o número de páginas esperado? |
| Visual | A capa e páginas representativas foram revisadas? |
| Distribuição | O ZIP contém apenas os arquivos necessários ao comprador ou à recompilação? |
| Estado editorial | O tópico está em `piloto`, `aprovado` ou `publicado` conforme o estágio real? |

A compilação automática não substitui o piloto com aluno. O lote confirma consistência técnica; a revisão humana confirma adequação pedagógica e naturalidade do mandarim.

## Estado atual

O fluxo está implementado e validado com B01. O lote produziu uma unidade com **1 PASS**, 13 páginas A4, capa parametrizada, PDF verificado e ZIP distribuível. B02–B04 ainda não devem ser incluídos no lote até possuírem perfis Typst próprios.

O campo `audios` ainda existe nos JSONs históricos por compatibilidade com o schema v1. O fluxo PDF-first não lê esse campo para gerar material e não inclui áudio nos pacotes. Uma migração posterior poderá remover a dependência histórica, mas ela não é necessária para a automação atual.

## References

[1]: https://github.com/tiago-prog/mandarim-em-rede-conteudo "Repositório do conteúdo do Mandarim em Rede"

[2]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/blob/main/templates/registry.json "Registro de perfis de templates"

[3]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/blob/main/scripts/build_pdf_batch.py "Gerador de lotes PDF-first"

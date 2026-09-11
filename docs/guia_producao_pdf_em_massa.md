# Guia de produção em massa — Mandarim em Rede

## Objetivo

Este guia ensina a baixar o repositório, preparar o ambiente, gerar workbooks PDF-first em lote e pedir a uma inteligência artificial que produza os JSONs de conteúdo no formato correto.

O fluxo recomendado é o **PDF-first**. Ele gera uma capa parametrizada, compila o workbook do perfil correto, verifica o PDF e cria um pacote ZIP por tópico. O áudio não faz parte desse processo.

> **Regra principal:** primeiro crie e revise o conteúdo JSON; depois associe esse conteúdo a um perfil de template Typst validado. Não use o layout de B01 automaticamente para um tópico diferente apenas porque o comando aceita o arquivo.

## 1. Baixar o repositório

O repositório oficial está no GitHub [1]. No terminal, execute:

```bash
git clone https://github.com/tiago-prog/mandarim-em-rede-conteudo.git
cd mandarim-em-rede-conteudo
```

Se o repositório já estiver instalado, atualize-o com:

```bash
git pull origin main
```

## 2. Preparar o ambiente

O gerador usa Python, Typst, Poppler e duas bibliotecas Python. Python executa a automação. Typst compila os PDFs. Poppler fornece o comando `pdfinfo`, usado para confirmar o número de páginas. CairoSVG e Pillow renderizam a capa parametrizada.

### Linux ou macOS

Verifique primeiro as ferramentas:

```bash
python3 --version
typst --version
pdfinfo -v
```

Crie um ambiente virtual e instale as dependências:

```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

### Windows PowerShell

Use Python 3.11 ou superior e instale Typst e Poppler de acordo com a configuração do computador. Depois, dentro da pasta do repositório, execute:

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
py -m pip install --upgrade pip
py -m pip install -r requirements.txt
```

Os comandos seguintes podem ser executados com `python` no Windows ou `python3` no Linux e macOS. O comando `pdfinfo` precisa estar disponível no `PATH` do sistema.

## 3. Validar um JSON antes de gerar

O validador PDF-first verifica os campos essenciais da unidade, a quantidade de estruturas, a sequência pedagógica, o status editorial e o pacote de extensões.

Para validar o B01 de exemplo:

```bash
python3 scripts/validate_pdf_first.py \
  content/B01-cumprimentos-em-contexto.json \
  --json
```

Uma resposta válida contém:

```json
{
  "valid": true,
  "errors": [],
  "warnings": [],
  "codigo": "B01",
  "audio_included": false
}
```

Os JSONs históricos podem apresentar este aviso:

```text
unidade.audios é histórico e será ignorado no fluxo PDF-first
```

Esse aviso não bloqueia a produção. Ele informa que o campo antigo foi preservado para compatibilidade, mas nenhum áudio será gerado ou incluído.

## 4. Gerar um lote de PDFs

O manifesto de lote de exemplo está em `content/pdf_first/colecao_01_batch.json`. Ele seleciona o B01, define o perfil de template, o material e a edição.

Execute:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/colecao_01_batch.json \
  --output-root build/pdf-first
```

O processo faz automaticamente o seguinte:

| Etapa | Ação |
|---:|---|
| 1 | Confirma a estrutura do manifesto de lote |
| 2 | Localiza o perfil em `templates/registry.json` |
| 3 | Valida o JSON PDF-first |
| 4 | Gera a capa com os dados do tópico |
| 5 | Copia a fonte Typst e os assets necessários |
| 6 | Compila o workbook em modo estrito |
| 7 | Verifica o PDF produzido |
| 8 | Confirma o número esperado de páginas |
| 9 | Cria o manifesto individual da build |
| 10 | Cria o ZIP distribuível |

O resultado do B01 aparece em:

```text
build/pdf-first/B01/
├── B01-workbook.pdf
├── B01-workbook-package.zip
├── B01-content.json
├── B01-cover-content.json
├── B01-workbook.verify.json
├── build-manifest.json
├── README.md
├── workbook.typ
├── report-theme.typ
└── assets/
    ├── bg-fundo-prime.png
    ├── capa-workbook.png
    └── capa-workbook.svg
```

O relatório geral do lote aparece em:

```text
build/pdf-first/batch-report.json
build/pdf-first/batch-report.md
```

O B01 atual produz **13 páginas A4**: uma capa e doze páginas pedagógicas.

## 5. Gerar vários tópicos no mesmo lote

O manifesto de lote possui uma lista chamada `units`. Cada item aponta para um JSON e para um perfil de template.

Um lote com quatro tópicos terá esta forma:

```json
{
  "schema_version": "pdf-first-batch-v1",
  "produto": "Mandarim em Rede",
  "template_registry": "templates/registry.json",
  "output_label": "colecao-01-piloto",
  "units": [
    {
      "id": "B01",
      "source": "content/B01-cumprimentos-em-contexto.json",
      "template_profile": "b01-cumprimentos-v2",
      "material": "WORKBOOK DO ALUNO",
      "edicao": "EDIÇÃO 01 · 2026"
    },
    {
      "id": "B02",
      "source": "content/B02-perguntar-responder-e-devolver.json",
      "template_profile": "b02-perguntar-responder-v1",
      "material": "WORKBOOK DO ALUNO",
      "edicao": "EDIÇÃO 01 · 2026"
    }
  ]
}
```

A inclusão de um item não cria automaticamente o template. O perfil `b02-perguntar-responder-v1` precisa existir no registro e apontar para uma fonte Typst própria. Se o perfil não existir, o gerador interromperá a unidade com a mensagem `perfil inexistente`. Isso é uma proteção intencional.

Para processar todos os itens e registrar falhas sem interromper o restante, use:

```bash
python3 scripts/build_pdf_batch.py \
  content/pdf_first/colecao_01_batch.json \
  --output-root build/pdf-first \
  --continue-on-error
```

## 6. Como pedir a uma IA para gerar um JSON

A IA deve produzir **apenas o conteúdo estruturado**. Ela não deve criar o PDF, alterar o template, inventar campos ou transformar o JSON em um roteiro de áudio.

Use o prompt pronto disponível em [prompt_para_gerar_json_pdf_first.md](prompt_para_gerar_json_pdf_first.md). O procedimento recomendado é:

1. escolha o código e o título do tópico;
2. descreva a situação comunicativa;
3. informe o nível do aluno;
4. informe quais estruturas, palavras e hanzi devem aparecer;
5. cole o prompt completo na IA;
6. peça saída em JSON válido, sem comentários e sem Markdown;
7. salve a resposta como `content/B02-nome-do-topico.json`;
8. execute o validador;
9. faça a revisão linguística humana;
10. somente depois associe o tópico a um perfil Typst.

A IA deve receber informações suficientes para produzir conteúdo específico. Um pedido genérico como “crie um JSON sobre restaurante” tende a gerar estruturas desconectadas, vocabulário excessivo e resultados difíceis de encaixar no layout.

## 7. Campos essenciais do JSON de uma unidade

A unidade PDF-first usa estes campos principais:

| Campo | Função |
|---|---|
| `codigo` | Identificador, como `B02` |
| `titulo` | Nome comercial do tópico |
| `nivel` | Nível do estudante |
| `status` | Estado editorial atual |
| `objetivo_comunicativo` | O que o aluno aprenderá a fazer |
| `resultado_minimo` | Evidência concreta ao final |
| `situacao_principal` | Cena central do tópico |
| `estruturas` | Hanzi, pinyin, sentido e função |
| `sequencia` | Caminho de estudo visual e escrito |
| `pacotes` | Páginas essenciais e complementos |
| `proxima_unidade_sugerida` | Continuidade da coleção |

Cada item de `estruturas` precisa conter `funcao`, `mandarim`, `pinyin`, `sentido_funcional` e `tipo`. Os tipos permitidos são `fixo`, `substituivel`, `particula`, `operador` e `base`.

A sequência recomendada é:

```json
[
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
]
```

O campo `audios` não é necessário para uma nova unidade PDF-first. Se estiver presente por compatibilidade com arquivos históricos, será ignorado pelo gerador.

## 8. Prompt curto para usar com outra IA

O prompt completo está no arquivo [prompt_para_gerar_json_pdf_first.md](prompt_para_gerar_json_pdf_first.md). A versão resumida é:

```text
Você é editor pedagógico e linguístico do produto Mandarim em Rede.
Crie uma unidade PDF-first de mandarim em JSON válido.

Tema: [DESCREVA O TEMA]
Código: [B02]
Título: [TÍTULO]
Nível: [iniciante]
Situações: [DESCREVA AS SITUAÇÕES]
Estruturas obrigatórias: [LISTE AS ESTRUTURAS]
Hanzi-alvo: [LISTE OS HANZI]
Palavras obrigatórias: [LISTE AS PALAVRAS]
Próximo tópico: [DESCREVA A CONTINUIDADE]

Regras:
- Use exatamente o schema PDF-first v1.
- Não crie áudio.
- Não inclua o campo audios.
- Entregue entre 2 e 12 estruturas.
- Cada estrutura deve ter função, hanzi, pinyin, sentido e tipo.
- Use a sequência situar, observar, reconhecer, ler, recuperar, escrever, reorganizar, recombinar, produzir, revisar.
- Mantenha o vocabulário no nível informado.
- Não invente informações culturais sem necessidade.
- Não escreva explicações fora do JSON.
- Retorne somente JSON válido.
```

## 9. Revisão humana antes da produção

A validação automática confirma a forma do arquivo. Ela não confirma a naturalidade do mandarim, a adequação do pinyin, a dificuldade das estruturas ou a qualidade pedagógica das situações.

Antes de adicionar um tópico ao lote, confira:

| Pergunta | Critério |
|---|---|
| A situação é concreta? | O aluno sabe onde e por que usará a forma? |
| As estruturas são realmente necessárias? | Nenhuma forma foi adicionada apenas para preencher espaço? |
| O pinyin está correto? | Tons, separação e pontuação foram revisados? |
| Os hanzi têm prioridade clara? | O aluno sabe o que reconhecer e o que escrever? |
| O vocabulário reaparece? | Cada palavra importante aparece em referência, prática e produção? |
| A progressão é possível? | O tópico não exige conteúdo que só seria ensinado depois? |
| O perfil visual existe? | O layout foi revisado para esse tópico específico? |

## 10. Erros comuns

| Mensagem ou problema | Causa provável | Solução |
|---|---|---|
| `perfil inexistente` | O tópico foi colocado no lote sem template registrado | Criar e revisar um perfil Typst próprio |
| `fonte inexistente` | O caminho em `source` está errado | Usar caminho relativo à raiz do repositório |
| `unidade.estruturas deve conter entre 2 e 12 itens` | Quantidade de estruturas fora do limite | Reduzir ou ampliar o núcleo com revisão pedagógica |
| `unidade.codigo deve seguir o formato A01` | Código fora do padrão | Usar `B02`, `B03` ou outro código com uma letra e dois números |
| `typst: command not found` | Typst não está instalado ou não está no PATH | Instalar Typst e repetir `typst --version` |
| `pdfinfo: command not found` | Poppler não está instalado ou não está no PATH | Instalar Poppler e repetir `pdfinfo -v` |
| `No module named cairosvg` | Dependências Python não instaladas | Ativar o ambiente virtual e executar `pip install -r requirements.txt` |
| `paginação inesperada` | O perfil espera quantidade diferente de páginas | Revisar o template e atualizar o registro somente após QA |
| Aviso sobre `audios` | O JSON é histórico | O aviso é esperado; o fluxo não gera áudio |

## 11. Limpar e gerar novamente

O gerador limpa a pasta de cada unidade antes de reconstruí-la. Para limpar o lote inteiro manualmente:

```bash
rm -rf build/pdf-first
```

No Windows PowerShell:

```powershell
Remove-Item -Recurse -Force build/pdf-first
```

Depois, execute novamente o comando do lote.

## 12. Estado atual e limite importante

O fluxo está validado com B01. Ele gera a capa, o workbook de 13 páginas, o relatório e o ZIP.

B02, B03 e B04 já possuem conteúdo em JSON, mas ainda precisam de perfis Typst próprios. Não é correto adicionar esses tópicos ao lote usando o perfil B01 apenas para acelerar a produção. O próximo trabalho técnico é criar, revisar e registrar cada perfil de template.

## References

[1]: https://github.com/tiago-prog/mandarim-em-rede-conteudo "Repositório do conteúdo do Mandarim em Rede"

[2]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/blob/main/scripts/build_pdf_batch.py "Gerador de lotes PDF-first"

[3]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/blob/main/schema/pdf_first_unit_v1.schema.json "Schema de unidade PDF-first"

[4]: https://github.com/tiago-prog/mandarim-em-rede-conteudo/blob/main/templates/registry.json "Registro de perfis de templates"

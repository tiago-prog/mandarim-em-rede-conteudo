# Achados do PDF de referência

Arquivo analisado: `conteudo-para-usar-como-referencia(1).pdf` (442 páginas; primeiras páginas exibem um curso HSK 1 com vocabulário e frases de exemplo).

## Padrões observados

- Cabeçalho repetido com o título do curso em todas as páginas.
- Estrutura unitária numerada por palavra: número, hanzi, pinyin, classe/função, frase em pinyin, frase em hanzi e tradução em português.
- Apresentação linear, limpa e de baixa densidade visual.
- Separação consistente entre palavra-alvo e frase de exemplo.
- Rodapé com fonte/URL e número de página.
- Uso de caracteres chineses em tamanho maior que o texto de apoio.
- O material funciona como referência lexical, mas não como workbook interativo: há pouca área de recuperação, escrita, escolha ou produção.
- A referência favorece uma camada de banco lexical e exemplos que pode alimentar os módulos do Mandarim em Rede, mas deve ser adaptada ao método pedagógico do repositório.

## Implicações para os templates

1. Criar um componente reutilizável de cartão lexical com hanzi, pinyin, classe, sentido, exemplo em pinyin, exemplo em hanzi e tradução.
2. Permitir duas densidades: modo `reference` para consulta e modo `workbook` para atividades.
3. Não copiar integralmente a diagramação linear: preservar a clareza da referência e acrescentar recuperação, escrita, recombinação e produção.
4. Separar campos linguísticos de campos de atividade no JSON.
5. Manter fonte e paginação parametrizadas para que a coleção possa usar a mesma base visual.

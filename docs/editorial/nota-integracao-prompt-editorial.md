# Integração do prompt editorial Unidade Rica v2

## Status

O prompt editorial `prompt-editorial-unidade-rica-v2.txt` foi incorporado como referência de produção para unidades PDF-first do Mandarim em Rede.

## Compatibilidade confirmada

O prompt é compatível com o fluxo ativo nos seguintes pontos:

- `schema_version` igual a `1.0`;
- produto `Mandarim em Rede`;
- `status` inicial `draft`;
- código de unidade no padrão `[A-Z][0-9]{2}`;
- estruturas entre 6 e 10 itens;
- tipos permitidos pelo pipeline;
- sequência pedagógica de dez etapas;
- ausência do campo `audios` nos novos arquivos;
- pacotes essenciais `R1`, `R2`, `R3`, `R4` e `V1`;
- conteúdo visual e escrito sem inclusão de áudio proprietário.

## Divergência técnica

O schema ativo `schema/pdf_first_unit_v1.schema.json` usa `additionalProperties: false` dentro de `unidade`. Portanto, os seguintes campos de riqueza pedidos pelo prompt ainda são rejeitados pelo schema atual:

```text
contexto_emocional
dificuldade_principal
hanzi_alvo
palavras_chave
artefato_pratico
criterios_autoavaliacao
```

A unidade também pode incluir `proxima_unidade_sugerida`, que já é aceita pelo schema.

## Decisão nesta etapa

O prompt foi registrado sem alterar o schema, o validador ou os templates ativos. Isso evita quebrar unidades existentes e mantém a integração reversível.

Até a criação de uma versão de schema compatível, existem duas opções válidas:

1. **Modo compatível imediato:** usar todos os campos obrigatórios do prompt que já são aceitos pelo schema e manter os campos ricos fora do JSON, em um briefing editorial complementar.
2. **Modo Unidade Rica v2:** atualizar schema, validador, templates Typst, schemas de lote e testes para aceitar e renderizar os campos ricos.

A segunda opção deve ser feita como uma migração versionada, preferencialmente com `pdf_first_unit_v2.schema.json`, sem substituir silenciosamente o contrato v1.

## Regra de produção

Não enviar uma unidade produzida pelo prompt diretamente ao pipeline enquanto os campos ricos ainda não tiverem sido incorporados ao schema. Primeiro validar o contrato escolhido.

## Campos recomendados para a futura v2

```json
{
  "contexto_emocional": "...",
  "dificuldade_principal": "...",
  "hanzi_alvo": [
    {
      "hanzi": "...",
      "pinyin": "...",
      "sentido": "...",
      "prioridade": "alta"
    }
  ],
  "palavras_chave": [
    {
      "hanzi": "...",
      "pinyin": "...",
      "sentido": "...",
      "categoria": "acao"
    }
  ],
  "artefato_pratico": "...",
  "criterios_autoavaliacao": ["..."]
}
```

A versão futura deve definir enumerações, cardinalidades, campos obrigatórios condicionais e regras de renderização antes de receber conteúdo em escala.

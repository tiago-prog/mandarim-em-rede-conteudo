import json
from pathlib import Path
ROOT=Path('/home/ubuntu/mandarim-em-rede-conteudo')
CONTENT=ROOT/'content/pdf_first'
PROMPTS={
'B02':['Qual ícone combina com uma troca de pergunta e resposta?','Qual ícone combina com uma pergunta que devolve a conversa?'],
'B03':['Qual ícone combina com uma pessoa?','Qual ícone combina com um objeto identificado?'],
'B04':['Qual ícone combina com algo que pertence a alguém?','Qual ícone combina com uma especificação?'],
'B05':['Qual ícone combina com uma informação numérica?','Qual ícone combina com um telefone?'],
'B06':['Qual ícone combina com um horário?','Qual ícone combina com uma agenda?'],
'B07':['Qual ícone combina com localização?','Qual ícone combina com uma direção?'],
'B08':['Qual ícone combina com um café ou restaurante?','Qual ícone combina com um pedido?'],
'B09':['Qual ícone combina com uma preferência?','Qual ícone combina com uma escolha entre opções?'],
'B10':['Qual ícone combina com um pedido de ajuda?','Qual ícone combina com colaboração?'],
'B11':['Qual ícone combina com uma rotina?','Qual ícone combina com atividades organizadas?'],
}
for path in sorted(CONTENT.glob('B[0-9][0-9]-*.json')):
    data=json.loads(path.read_text(encoding='utf-8')); u=data['unidade']; code=u['codigo']
    prompts=PROMPTS[code]
    u['matching']={
      'instrucao':'Ligue cada situação ao ícone que melhor combina com a intenção. Não olhe a resposta; fale sua escolha em voz alta.',
      'itens':[
        {'prompt':prompts[0], 'asset_a':f'{code}-a', 'asset_b':f'{code}-b', 'resposta':'a'},
        {'prompt':prompts[1], 'asset_a':f'{code}-a', 'asset_b':f'{code}-b', 'resposta':'b'},
      ]
    }
    path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(code)

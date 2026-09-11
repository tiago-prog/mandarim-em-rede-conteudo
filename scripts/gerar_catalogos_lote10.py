import json
from pathlib import Path
ROOT=Path('/home/ubuntu/mandarim-em-rede-conteudo')
cat=ROOT/'content/catalogo/colecao_01_matriz.json'
colecao='Coleção 01 · Primeiras interações'
items=[
('B01',1,'Entrada na interação','cumprimentar em contexto',[],['你好','我','你'],['B02'],'piloto'),
('B02',2,'Entrada na interação','perguntar, responder e devolver',['B01'],['你好','我','你'],['B03'],'draft'),
('B03',3,'Entrada na interação','identificar pessoas e objetos',['B02'],['你','我','吗','呢'],['B04'],'draft'),
('B04',4,'Entrada na interação','perguntar e responder posse',['B03'],['这','那','谁','是'],['B05'],'draft'),
('B05',5,'Situações práticas','informar números e dados pessoais',['B04'],['我的','你的','书','朋友'],['B06'],'draft'),
('B06',6,'Situações práticas','perguntar e informar horários',['B05'],['几','多少','有','人'],['B07'],'draft'),
('B07',7,'Situações práticas','localizar pessoas e objetos',['B06'],['现在','点','开始','下午'],['B08'],'draft'),
('B08',8,'Situações práticas','fazer pedidos em café ou restaurante',['B07'],['在哪里','这里','那里','在'],['B09'],'draft'),
('B09',9,'Preferências e escolhas','expressar gostos e escolher',['B08'],['要','请','这个','谢谢'],['B10'],'draft'),
('B10',10,'Preferências e escolhas','expressar preferências e recusas',['B09'],['喜欢','不','还是','什么'],['B11'],'draft'),
('B11',11,'Preferências e escolhas','dizer capacidade e pedir ajuda',['B10'],['会','能','帮','谢谢'],[],'draft'),
]
data={'schema_version':'collection-map-v1','produto':'Mandarim em Rede','colecao':colecao,'nivel':'iniciante','unidades':[]}
for code,order,module,func,pre,rec,prep,status in items:
    data['unidades'].append({'codigo':code,'ordem':order,'modulo':module,'funcao':func,'status':status,'pre_requisitos':pre,'recicla':rec,'introduz':[],'prepara':prep,'vocabulario_novo_maximo':8})
cat.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')

# Build lexical index from B02-B11 plus core B01 expressions.
entries=[
('你好','nǐ hǎo','olá','B01'),('我','wǒ','eu','B01'),('你','nǐ','você','B01'),('叫','jiào','chamar-se','B01'),('什么','shénme','o que/qual','B01')]
for code in [f'B{i:02d}' for i in range(2,12)]:
    path=next((ROOT/'content/pdf_first').glob(f'{code}-*.json'))
    u=json.loads(path.read_text())['unidade']
    for item in u['palavras_chave']:
        record=(item['hanzi'],item['pinyin'],item['sentido'],code)
        if not any(x[0]==record[0] for x in entries): entries.append(record)
# Assign future recycling based on catalog order.
order={x[0]:x[1] for x in items}
lex=[]
for hanzi,pinyin,sentido,first in entries:
    recycling=[code for code,ordv in order.items() if ordv>order.get(first,1) and any(hanzi==r for row in items for r in row[5])][:3]
    lex.append({'hanzi':hanzi,'pinyin':pinyin,'sentido':sentido,'primeira_unidade':first,'reciclar_em':recycling,'prioridade':'alta' if first in {'B01','B02','B03','B04'} else 'media','status':'ativo'})
vocab={'schema_version':'cumulative-vocabulary-v1','produto':'Mandarim em Rede','colecao':colecao,'entradas':lex}
(ROOT/'content/catalogo/vocabulario_cumulativo.json').write_text(json.dumps(vocab,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'units':len(items),'lexical_entries':len(lex)},ensure_ascii=False))

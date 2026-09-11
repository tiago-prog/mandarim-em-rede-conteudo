#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONTENT = ROOT / 'content' / 'pdf_first'

EDITORIAL = {
 'B02': {
  'preparacao':['Quem está falando?','O que essa pessoa quer saber?','Feche o mapa. Tente sozinho.','O que ainda ficou estranho?'],
  'reorder':'Monte a pergunta na ordem certa.',
  'recombine':'Troque só o que precisa mudar.',
  'scenarios':['Crie uma troca sua depois do cumprimento. Fale primeiro; escreva depois.','Crie 3 trocas suas. Não copie as frases prontas.'],
  'criteria':['Distingo 吗 de 呢','Faço pergunta e resposta','Devolvo a pergunta com 呢','Troco só o slot','Falo sem consultar o mapa'],
 },
 'B03': {
  'preparacao':['Quem está perto? Quem está longe?','É pessoa ou objeto?','Feche o mapa. Tente a pergunta.','O que ainda ficou estranho?'],
  'reorder':'Monte a pergunta na ordem certa.',
  'recombine':'Troque só o referente. Mantenha o demonstrativo.',
  'scenarios':['Escolha dois objetos e duas pessoas. Fale cada pergunta antes de escrever.','Crie 4 trocas suas sem consultar o mapa de decisão.'],
  'criteria':['Escolho 这 ou 那 certo','Uso 什么 para objetos','Uso 谁 para pessoas','Troco só o referente','Falo sem consultar o mapa'],
 },
 'B04': {
  'preparacao':['Olhe o objeto. De quem ele é?','Escolha o possuidor.','Feche o mapa. Monte a pergunta.','O que ainda ficou estranho?'],
  'reorder':'Monte a expressão na ordem certa.',
  'recombine':'Troque só o elemento indicado.',
  'scenarios':['Escolha três objetos. Fale de quem são antes de escrever.','Faça duas perguntas e responda sem consultar o mapa.'],
  'criteria':['Uso 我的 para mim','Uso 你的 para você','Coloco 的 no lugar certo','Troco só o objeto','Falo sem consultar o mapa'],
 },
 'B05': {
  'preparacao':['Qual informação é numérica?','A pergunta pede dado curto ou aberto?','Fale o número antes de conferir.','O que ainda ficou estranho?'],
  'reorder':'Monte a expressão numérica na ordem certa.',
  'recombine':'Troque só o número ou a informação.',
  'scenarios':['Pergunte e informe idade e telefone. Fale antes de escrever.','Dê duas informações numéricas sem olhar o mapa.'],
  'criteria':['Escolho 几 para idade','Uso 多少 para quantidade aberta','Produzo números com ritmo estável','Respondo sem inverter a ordem','Falo sem consultar o mapa'],
 },
 'B06': {
  'preparacao':['Imagine o compromisso.','Ouça o número antes da unidade.','Pergunte e responda em voz alta.','O que ainda ficou estranho?'],
  'reorder':'Monte a expressão de horário na ordem certa.',
  'recombine':'Troque só o horário.',
  'scenarios':['Pergunte e informe dois horários. Fale cada horário antes de escrever.','Combine um encontro usando um horário novo, sem mapa.'],
  'criteria':['Coloco 点 depois do número','Reconheço 半 como meia hora','Pergunto quando com 什么时候','Respondo com período e horário','Falo sem consultar o mapa'],
 },
 'B07': {
  'preparacao':['O que você quer localizar?','É pessoa, objeto ou sala?','Fale a pergunta antes de olhar a resposta.','O que ainda ficou estranho?'],
  'reorder':'Monte a pergunta de localização na ordem certa.',
  'recombine':'Troque só o lugar ou o referente.',
  'scenarios':['Pergunte onde estão dois itens. Fale primeiro; escreva depois.','Dê duas localizações sem consultar o mapa.'],
  'criteria':['Uso 在 para localizar','Distingo 这里 de 那里','Pergunto onde sem traduzir','Respondo com lugar claro','Falo sem consultar o mapa'],
 },
 'B08': {
  'preparacao':['Visualize o cardápio.','Escolha item e quantidade.','Faça o pedido em voz alta.','O que ainda ficou estranho?'],
  'reorder':'Monte o pedido na ordem certa.',
  'recombine':'Troque só o item ou a quantidade.',
  'scenarios':['Escolha dois itens. Fale cada pedido antes de escrever.','Faça um pedido e confirme a escolha sem consultar o mapa.'],
  'criteria':['Uso 要 para pedir','Uso 请 para ser cortês','Confirmo a escolha com este item','Faço o fechamento social','Falo sem consultar o mapa'],
 },
 'B09': {
  'preparacao':['Escolha duas opções.','É preferência ou recusa?','Diga a escolha em voz alta.','O que ainda ficou estranho?'],
  'reorder':'Monte a escolha na ordem certa.',
  'recombine':'Troque só a opção.',
  'scenarios':['Diga do que gosta e não gosta. Fale antes de escrever.','Escolha entre duas opções sem consultar o mapa.'],
  'criteria':['Digo gosto com 喜欢','Formo a recusa com 不喜欢','Entendo a escolha com 还是','Mantenho a opção explícita','Falo sem consultar o mapa'],
 },
 'B10': {
  'preparacao':['Qual é a tarefa?','É habilidade ou possibilidade?','Peça ajuda sem abandonar a conversa.','O que ainda ficou estranho?'],
  'reorder':'Monte o pedido de ajuda na ordem certa.',
  'recombine':'Troque só a tarefa.',
  'scenarios':['Diga o que consegue fazer e peça ajuda. Fale primeiro.','Use 能 para dizer que pode tentar, sem consultar o mapa.'],
  'criteria':['Distingo 会 de 能 no contexto','Formo a negativa com 不会','Peço ajuda com clareza','Continuo após uma dificuldade','Falo sem consultar o mapa'],
 },
 'B11': {
  'preparacao':['Escolha uma atividade do banco.','Organize pessoa, verbo e objeto.','Fale uma frase sem consultar.','O que ainda ficou estranho?'],
  'reorder':'Monte a frase na ordem certa.',
  'recombine':'Troque só a atividade.',
  'scenarios':['Monte três frases sobre seu dia. Fale antes de escrever.','Pergunte e responda sobre duas atividades sem consultar o mapa.'],
  'criteria':['Coloco o verbo antes do objeto','Pergunto atividade com 做什么','Produzo frases de rotina','Recombino três atividades','Falo sem consultar o mapa'],
 },
}

for path in sorted(CONTENT.glob('B[0-9][0-9]-*.json')):
    data=json.loads(path.read_text(encoding='utf-8'))
    unit=data['unidade']; code=unit['codigo']
    if code not in EDITORIAL: continue
    e=EDITORIAL[code]
    unit['preparacao']=e['preparacao']
    unit['atividades']['reorganizacao']['instrucao']=e['reorder']
    unit['atividades']['recombinacao']['instrucao']=e['recombine']
    for scenario, new_instruction in zip(unit['producao']['cenarios'], e['scenarios']):
        scenario['instrucao']=new_instruction
    unit['criterios_autoavaliacao']=e['criteria']
    unit['status']='revisao_visual'
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(code, path.name)

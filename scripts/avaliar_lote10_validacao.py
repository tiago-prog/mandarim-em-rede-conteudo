import json, subprocess
from pathlib import Path
root=Path('/home/ubuntu/mandarim-em-rede-conteudo')
rows=[]
for code in [f'B{i:02d}' for i in range(2,12)]:
    path=next((root/'content/pdf_first').glob(f'{code}-*.json'))
    p=subprocess.run(['python3',str(root/'scripts/validate_pdf_first_v2.py'),str(path),'--json'],capture_output=True,text=True)
    d=json.loads(p.stdout)
    rows.append({'codigo':d['codigo'],'valid':d['valid'],'warnings':d['warnings'],'errors':d['errors']})
print(json.dumps(rows,ensure_ascii=False,indent=2))

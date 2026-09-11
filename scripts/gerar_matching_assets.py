from pathlib import Path

OUT=Path('/home/ubuntu/mandarim-em-rede-conteudo/templates/b-family/matching')
OUT.mkdir(parents=True,exist_ok=True)

def svg(body, label):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 90" role="img" aria-label="{label}">
  <g fill="none" stroke="#173754" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">{body}</g>
</svg>\n'''
assets={
'B02-a':('<path d="M18 20h54a8 8 0 0 1 8 8v25a8 8 0 0 1-8 8H48l-14 10 3-10H18a8 8 0 0 1-8-8V28a8 8 0 0 1 8-8z"/><path d="M25 38h40M25 49h25"/>','fala'),
'B02-b':('<path d="M38 20a22 22 0 1 0 20 34"/><path d="M60 54l15 10"/><path d="M48 31c0-5 9-6 9 0 0 4-5 5-5 9M52 47v1"/>','pergunta'),
'B03-a':('<circle cx="42" cy="25" r="11"/><path d="M20 68c2-17 12-25 22-25s20 8 22 25"/>','pessoa'),
'B03-b':('<path d="M28 28l25-12 28 13-25 13-28-14z"/><path d="M28 28v29l28 15 25-14V29M56 42v30"/>','objeto'),
'B04-a':('<circle cx="39" cy="25" r="10"/><path d="M18 68c2-16 11-24 21-24s19 8 21 24"/><path d="M67 30h30v24H67zM73 30v-6h18v6"/>','posse'),
'B04-b':('<path d="M18 29h54v35H18z"/><path d="M27 29v-7h36v7M27 41h36"/><path d="M82 32l6 6 13-15"/>','especificacao'),
'B05-a':('<circle cx="48" cy="44" r="30"/><path d="M48 26v36M36 35c3-7 18-7 21 0 3 8-18 8-21 16-3 8 17 10 22 2"/>','numero'),
'B05-b':('<rect x="30" y="12" width="42" height="66" rx="7"/><path d="M39 22h24M39 61h24M45 69h12"/><path d="M82 35h20v25H82z"/>','telefone'),
'B06-a':('<circle cx="54" cy="44" r="30"/><path d="M54 25v20l14 9"/>','relogio'),
'B06-b':('<rect x="22" y="22" width="62" height="52" rx="4"/><path d="M22 36h62M35 14v16M71 14v16M34 48h8M49 48h8M64 48h8M34 60h8M49 60h8"/>','agenda'),
'B07-a':('<path d="M52 76S25 49 25 32a27 27 0 0 1 54 0c0 17-27 44-27 44z"/><circle cx="52" cy="32" r="8"/>','localizacao'),
'B07-b':('<path d="M18 72V30l28-14 28 14v42z"/><path d="M36 72V48h20v24M18 38h56"/><path d="M85 45h20M98 38l7 7-7 7"/>','direcao'),
'B08-a':('<path d="M28 30h44l-5 40H33zM24 30h52M37 22c0-8 9-8 9 0M54 22c0-8 9-8 9 0"/>','cafe'),
'B08-b':('<path d="M25 38h50v23a12 12 0 0 1-12 12H37a12 12 0 0 1-12-12zM75 44h11a10 10 0 0 1 0 20H75M32 25c0-7 8-7 8 0M48 25c0-7 8-7 8 0"/>','pedido'),
'B09-a':('<path d="M54 70S20 51 20 30c0-14 18-19 29-7 11-12 29-7 29 7 0 21-24 40-24 40z"/>','preferencia'),
'B09-b':('<circle cx="48" cy="45" r="27"/><path d="M30 45h36M48 27v36M83 29l22 22M105 29L83 51"/>','escolha'),
'B10-a':('<path d="M36 72V41c0-6 9-6 9 0v13-27c0-6 9-6 9 0v27-31c0-6 9-6 9 0v32-22c0-6 9-6 9 0v24c0 10-7 15-17 15H48c-7 0-12-5-12-12z"/>','ajuda'),
'B10-b':('<circle cx="38" cy="27" r="10"/><circle cx="76" cy="27" r="10"/><path d="M18 68c2-15 10-22 20-22s18 7 20 22M56 68c2-15 10-22 20-22s18 7 20 22"/><path d="M48 55h18M60 49l6 6-6 6"/>','colaboracao'),
'B11-a':('<circle cx="49" cy="45" r="25"/><path d="M49 14v8M49 68v8M18 45h8M72 45h8M27 23l6 6M65 61l6 6M71 23l-6 6M33 61l-6 6"/>','rotina'),
'B11-b':('<rect x="22" y="18" width="58" height="58" rx="4"/><path d="M35 34l5 5 9-10M35 52l5 5 9-10M35 67l5 5 9-10M57 35h13M57 53h13M57 68h13"/>','atividades'),
}
for key,(body,label) in assets.items():
    (OUT/f'{key}.svg').write_text(svg(body,label),encoding='utf-8')
print(f'generated {len(assets)} SVG assets in {OUT}')

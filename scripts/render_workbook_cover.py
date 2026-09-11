#!/usr/bin/env python3
from __future__ import annotations

import argparse
import base64
import json
from pathlib import Path
from xml.sax.saxutils import escape

import cairosvg
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_BASE = ROOT / "templates" / "assets" / "capa-base.webp"
WHITE = "#F7F5EE"
GOLD = "#C9A94E"
MUTED = "#D9E1E5"
NAVY = "#173755"


def text(x: float, y: float, content: str, size: int, *, family: str = "Noto Sans", weight: str = "400", fill: str = WHITE, anchor: str = "middle", letter: float = 0) -> str:
    return (
        f'<text x="{x}" y="{y}" font-family="{family}" font-size="{size}px" '
        f'font-weight="{weight}" fill="{fill}" text-anchor="{anchor}" '
        f'letter-spacing="{letter}px">{escape(content)}</text>'
    )


def load_unit(path: Path) -> dict:
    data = json.loads(path.read_text(encoding="utf-8"))
    return data.get("unidade", data)


def first_structure(unit: dict) -> tuple[str, str, str]:
    structures = unit.get("estruturas", [])
    if not structures:
        return "你好。", "Nǐ hǎo.", "Olá."
    item = structures[0]
    return item.get("mandarim", "你好。"), item.get("pinyin", "Nǐ hǎo."), item.get("sentido_funcional", "Olá.")


def cover_svg(unit: dict, base: Path) -> tuple[str, int, int]:
    with Image.open(base) as image:
        width, height = image.size
    encoded = base64.b64encode(base.read_bytes()).decode("ascii")
    title = str(unit.get("titulo", "Tópico sem título")).upper()
    code = str(unit.get("codigo", "B01")).upper()
    topic_number = str(unit.get("numero", "")).strip() or f"TÓPICO {code[1:] if len(code) > 1 else code}"
    if not topic_number.upper().startswith("TÓPICO"):
        topic_number = f"TÓPICO {topic_number}"
    material = str(unit.get("material", "WORKBOOK DO ALUNO")).upper()
    edition = str(unit.get("edicao", "EDIÇÃO 01 · 2026")).upper()
    hanzi, pinyin, meaning = first_structure(unit)
    title_size = 43 if len(title) <= 25 else 37 if len(title) <= 33 else 32
    material_size = 31 if len(material) <= 22 else 26
    hanzi_size = 82 if len(hanzi) <= 5 else 68
    masks = """
      <rect x="225" y="505" width="998" height="145" fill="#173755"/>
      <rect x="225" y="775" width="998" height="220" fill="#173755"/>
      <rect x="225" y="1010" width="998" height="260" fill="#173755"/>
      <rect x="380" y="1260" width="700" height="370" fill="#173755"/>
      <rect x="75" y="1900" width="1300" height="88" fill="#173755"/>
      <line x1="85" y1="1908" x2="1362" y2="1908" stroke="#C9A94E" stroke-width="2"/>
    """
    content = [
        text(width / 2, 603, "Sistema visual para transformar", 27),
        text(width / 2, 638, "leitura em produção escrita.", 27),
        text(width / 2, 812, topic_number, 27, weight="700", fill=GOLD, letter=2),
        text(width / 2, 875, title, title_size, family="DejaVu Serif", weight="700", letter=0.6),
        text(width / 2, 966, material, material_size, weight="700", letter=1.0),
        text(width / 2, 1055, "OBSERVE · ESCREVA · ORGANIZE", 24, weight="700", letter=1.0),
        text(width / 2, 1098, "RECOMBINE · TRANSFIRA · PRODUZA", 24, weight="700", letter=0.5),
        text(width / 2, 1308, "DA LEITURA À PRODUÇÃO ESCRITA", 29, weight="700", fill=GOLD, letter=1.0),
        text(width / 2, 1362, "Observe a situação. Use o mapa. Produza em uma situação nova.", 22, fill=MUTED),
        text(width / 2, 1480, hanzi, hanzi_size, family="Noto Sans CJK SC"),
        text(width / 2, 1550, f"{pinyin} · {meaning}", 24, fill=GOLD),
        text(103, 1966, "MANDARIM EM REDE · SISTEMA VISUAL E ESCRITO", 15, anchor="start", letter=0.2),
        text(1342, 1966, f"{code} · {edition}", 15, anchor="end", letter=0.2),
    ]
    svg = f'''<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">
  <image href="data:image/webp;base64,{encoded}" x="0" y="0" width="{width}" height="{height}" preserveAspectRatio="none"/>
  <g>{masks}</g>
  <g>{''.join(content)}</g>
</svg>
'''
    return svg, width, height


def render(unit_path: Path, output: Path, base: Path) -> None:
    unit = load_unit(unit_path)
    svg, width, height = cover_svg(unit, base)
    output.parent.mkdir(parents=True, exist_ok=True)
    svg_path = output.with_suffix(".svg")
    svg_path.write_text(svg, encoding="utf-8")
    cairosvg.svg2png(bytestring=svg.encode("utf-8"), write_to=str(output), output_width=width, output_height=height)
    with Image.open(output) as image:
        image.convert("RGB").save(output, format="PNG", dpi=(300, 300), optimize=True)
    print(json.dumps({"unit": str(unit_path), "output": str(output), "svg": str(svg_path), "size": [width, height]}, ensure_ascii=False))


def main() -> int:
    parser = argparse.ArgumentParser(description="Renderiza a capa parametrizada de um workbook PDF-first.")
    parser.add_argument("unit_json", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--base", type=Path, default=DEFAULT_BASE)
    args = parser.parse_args()
    render(args.unit_json, args.output, args.base)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

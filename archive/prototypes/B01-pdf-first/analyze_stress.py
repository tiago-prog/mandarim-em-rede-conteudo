#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path

import fitz

ROOT = Path(__file__).resolve().parent
PDF = ROOT / "B01-workbook-visual-escrito.pdf"
SRC = ROOT / "B01-workbook.typ"
OUT = ROOT / "stress_metrics.json"

text = SRC.read_text(encoding="utf-8")
pdf = fitz.open(PDF)

# The source is intentionally organized with one explicit page marker per page.
page_chunks = re.split(r"// Página \d+ —[^\n]*\n", text)[1:]
source_pages = []
for number, chunk in enumerate(page_chunks, start=1):
    sections = re.findall(r'#section\("([^"]+)"', chunk)
    titles = re.findall(r'#page-title\("([^"]+)"', chunk)
    writeboxes = len(re.findall(r'#writebox\(', chunk))
    checkboxes = len(re.findall(r'#check\(', chunk))
    table_calls = len(re.findall(r'#table\(', chunk))
    cards = len(re.findall(r'#card\(', chunk))
    action_terms = re.findall(
        r'\b(?:Escolha|escolha|Escreva|escreva|Leia|leia|Reconheça|reconheça|Ligue|ligue|Complete|complete|Tente|tente|Marque|marque|Produza|produza|Observe|observe|Use|use|Consulte|consulte|Compare|compare|Reorganize|reorganize|Troque|troque|Identifique|identifique|Registre|registre)\b',
        chunk,
    )
    heights_mm = [float(value) for value in re.findall(r'height: ([0-9.]+)mm', chunk)]
    source_pages.append({
        "page": number,
        "titles": titles,
        "sections": sections,
        "writebox_count": writeboxes,
        "checkbox_count": checkboxes,
        "table_count": table_calls,
        "card_count": cards,
        "action_term_count": len(action_terms),
        "action_terms": action_terms,
        "writebox_heights_mm": heights_mm,
        "minimum_writebox_height_mm": min(heights_mm) if heights_mm else None,
        "maximum_writebox_height_mm": max(heights_mm) if heights_mm else None,
    })

pdf_pages = []
for index, page in enumerate(pdf, start=1):
    rect = page.rect
    blocks = page.get_text("dict")["blocks"]
    spans = []
    for block in blocks:
        for line in block.get("lines", []):
            for span in line.get("spans", []):
                spans.append(span)
    nonempty = [span for span in spans if span.get("text", "").strip()]
    sizes = [float(span["size"]) for span in nonempty]
    bboxes = [span["bbox"] for span in nonempty]
    if bboxes:
        x0 = min(b[0] for b in bboxes)
        y0 = min(b[1] for b in bboxes)
        x1 = max(b[2] for b in bboxes)
        y1 = max(b[3] for b in bboxes)
        occupied = (x1 - x0) * (y1 - y0) / (rect.width * rect.height)
        vertical = (y1 - y0) / rect.height
    else:
        x0 = y0 = x1 = y1 = occupied = vertical = 0
    drawings = page.get_drawings()
    image_count = len(page.get_images(full=True))
    page_text = page.get_text("text")
    pdf_pages.append({
        "page": index,
        "characters": len(page_text),
        "words": len(page.get_text("words")),
        "text_spans": len(nonempty),
        "min_font_pt": min(sizes) if sizes else None,
        "max_font_pt": max(sizes) if sizes else None,
        "text_bbox": [round(x0, 2), round(y0, 2), round(x1, 2), round(y1, 2)],
        "text_area_ratio": round(occupied, 4),
        "text_vertical_ratio": round(vertical, 4),
        "drawing_count": len(drawings),
        "image_count": image_count,
    })

metrics = {
    "pdf": {
        "path": str(PDF),
        "pages": len(pdf),
        "width_pt": round(pdf[0].rect.width, 3),
        "height_pt": round(pdf[0].rect.height, 3),
    },
    "cover": {
        "present": "Capa editorial do workbook" in text,
        "pdf_page": 1 if "Capa editorial do workbook" in text else None,
        "graphic_only": not pdf_pages[0]["text_spans"] if pdf_pages else False,
    },
    "source": {
        "path": str(SRC),
        "page_markers": len(page_chunks),
        "total_writeboxes": sum(p["writebox_count"] for p in source_pages),
        "total_checkboxes": sum(p["checkbox_count"] for p in source_pages),
        "total_tables": sum(p["table_count"] for p in source_pages),
        "total_cards": sum(p["card_count"] for p in source_pages),
        "minimum_writebox_height_mm": min(
            p["minimum_writebox_height_mm"] for p in source_pages if p["minimum_writebox_height_mm"] is not None
        ),
    },
    "source_pages": source_pages,
    "pdf_pages": pdf_pages,
}
OUT.write_text(json.dumps(metrics, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(f"WROTE {OUT}")
print(f"PDF pages={len(pdf)} source_page_markers={len(page_chunks)}")
print(f"writeboxes={metrics['source']['total_writeboxes']} checkboxes={metrics['source']['total_checkboxes']} tables={metrics['source']['total_tables']} cards={metrics['source']['total_cards']}")
print(f"minimum_writebox_height_mm={metrics['source']['minimum_writebox_height_mm']}")
for page in pdf_pages:
    min_font = f"{page['min_font_pt']:.2f}pt" if page["min_font_pt"] is not None else "none"
    print(
        f"page={page['page']:02d} chars={page['characters']:4d} min_font={min_font} "
        f"vertical={page['text_vertical_ratio']:.3f} drawings={page['drawing_count']} images={page['image_count']}"
    )

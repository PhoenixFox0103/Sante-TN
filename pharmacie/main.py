from pathlib import Path
import sys
import webview

BASE = Path(getattr(sys, "_MEIPASS", Path(__file__).resolve().parent))
INDEX = BASE / "web" / "index.html"
if not INDEX.exists():
    raise FileNotFoundError(f"Fichier introuvable : {INDEX}")
webview.create_window(
    "PharmaLink Pharmacie",
    INDEX.as_uri(),
    width=1360,
    height=860,
    min_size=(1000, 680),
    resizable=True,
    background_color="#eef4f2"
)
webview.start(private_mode=False, debug=False)

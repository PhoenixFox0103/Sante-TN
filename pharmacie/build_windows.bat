@echo off
py -m pip install -r requirements.txt
py -m PyInstaller --noconfirm --clean --windowed --name PharmaLink-Pharmacie --add-data "web;web" main.py
echo.
echo EXE cree dans dist\PharmaLink-Pharmacie\PharmaLink-Pharmacie.exe
pause

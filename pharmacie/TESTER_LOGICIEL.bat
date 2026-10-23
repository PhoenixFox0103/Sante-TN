@echo off
cd /d "%~dp0"
echo Dossier lance : %CD%
py -m pip install -r requirements.txt
py main.py
pause

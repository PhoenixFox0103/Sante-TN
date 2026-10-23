@echo off
cd /d "%~dp0"
echo Suppression des anciennes compilations...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist PharmaLink-Pharmacie.spec del /q PharmaLink-Pharmacie.spec
py -m pip install -r requirements.txt
py -m PyInstaller --noconfirm --clean --windowed --name PharmaLink-Pharmacie --add-data "web;web" main.py
echo.
echo NOUVEL EXE : %CD%\dist\PharmaLink-Pharmacie\PharmaLink-Pharmacie.exe
pause

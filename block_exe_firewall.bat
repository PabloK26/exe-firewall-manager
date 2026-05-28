@echo off
setlocal enabledelayedexpansion
color 0C
title Firewall Tool STD

:: ADMIN CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo =====================================
echo        FIREWALL TOOL STD
echo =====================================
echo.
echo 1 - CUAL ES MI FUNCIONALIDAD?
echo 2 - BLOQUEAR carpeta
echo 3 - DESBLOQUEAR carpeta
echo 0 - SALIR
echo.
set /p op=Opcion: 

if "%op%"=="1" goto FUNC
if "%op%"=="2" goto BLOQ
if "%op%"=="3" goto DESBLOQ
if "%op%"=="0" exit

goto MENU

:: =========================
:: CUAL ES MI FUNCIONALIDAD?
:: =========================
:FUNC
cls
echo =====================================
echo Script automatizado para crear y eliminar reglas de bloqueo (entrada y salida)
echo en el Firewall de Windows mediante deteccion automatica de todos de archivos .exe
echo dentro de una carpeta seleccionada, inclusive en subcarpetas.
echo =====================================
pause
goto MENU

:: =========================
:: BLOQUEAR
:: =========================
:BLOQ
cls
set /p carpeta=Ruta carpeta: 

if not exist "%carpeta%" (
    echo.
    echo No existe la carpeta especificada
    echo.
    pause
    goto MENU
)

for /r "%carpeta%" %%G in (*.exe) do (

    set "name=%%~nG"

    echo Bloqueando !name!

    netsh advfirewall firewall add rule name="BLOCK_!name!_OUT" dir=out action=block program="%%G" enable=yes >nul
    netsh advfirewall firewall add rule name="BLOCK_!name!_IN" dir=in action=block program="%%G" enable=yes >nul
)

echo Listo.
pause
goto MENU


:: =========================
:: DESBLOQUEAR
:: =========================
:DESBLOQ
cls
set /p carpeta=Ruta carpeta: 

if not exist "%carpeta%" (
    echo No existe
    pause
    goto MENU
)

for /r "%carpeta%" %%G in (*.exe) do (

    set "name=%%~nG"

    echo Eliminando reglas !name!

    netsh advfirewall firewall delete rule name="BLOCK_!name!_OUT" >nul
    netsh advfirewall firewall delete rule name="BLOCK_!name!_IN" >nul
)

echo Listo.
pause
goto MENU

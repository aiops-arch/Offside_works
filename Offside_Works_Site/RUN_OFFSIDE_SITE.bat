@echo off
setlocal

cd /d "%~dp0"
set "PORT=8000"
set "BUSY="

netstat -ano | findstr /R /C:":%PORT% .*LISTENING" >nul 2>nul
if not errorlevel 1 (
    set "PORT=8001"
)

where python >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=python"
    goto run
)

where py >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=py"
    goto run
)

echo Python was not found.
echo Install Python or run this site by double-clicking index.html.
pause
exit /b 1

:run
echo Starting Offside Works site on http://localhost:%PORT%/
start "" "http://localhost:%PORT%/"
%PYTHON_CMD% -m http.server %PORT%


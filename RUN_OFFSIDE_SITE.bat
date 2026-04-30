@echo off
setlocal

cd /d "%~dp0"

if exist "Offside_Works_Site\index.html" (
    cd /d "%~dp0Offside_Works_Site"
) else if exist "offsidewebsite.html" (
    copy /Y "offsidewebsite.html" "index.html" >nul
)

set "PORT=8000"
netstat -ano | findstr /R /C:":%PORT% .*LISTENING" >nul 2>nul
if not errorlevel 1 set "PORT=8001"

where python >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=python"
    goto run_site
)

where py >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=py"
    goto run_site
)

echo Python was not found on this computer.
echo You can still open the site by double-clicking index.html or offsidewebsite.html.
pause
exit /b 1

:run_site
echo Starting Offside Works site...
echo URL: http://localhost:%PORT%/
start "" "http://localhost:%PORT%/"
%PYTHON_CMD% -m http.server %PORT%

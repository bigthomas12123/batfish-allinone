@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

where java >nul 2>nul
if errorlevel 1 (
  echo [ERROR] java not found in PATH. Please install JDK 21+ and add it to PATH.
  echo         https://adoptium.net/
  pause
  exit /b 1
)

echo Starting Batfish allinone (API: http://127.0.0.1:9996) ...
java -Xmx4g -jar "%~dp0allinone.jar" -runclient false -coordinatorargs "-templatedirs %~dp0questions -containerslocation %~dp0containers"
pause

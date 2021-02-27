@echo off
cls

set "JAVA_HOME=C:\AdoptOpenJDK10"

cd sbrw
set "SELFDIR=%~dp0"

echo "Starting Openfire..."
start cmd.exe /c "%SELFDIR%\bin\sbrwopenfirelauncher.bat"

echo "Starting Freeroam MP server..."
cd "%SELFDIR%\freeroam"
start cmd.exe /c "freeroamd.exe"

echo "Starting Race MP server..."
cd "%SELFDIR%\race"
start cmd.exe /c "%JAVA_HOME%\java -jar race.jar 9998"

echo "Starting Core server..."
cd "%SELFDIR%\core"
start cmd.exe /c "%JAVA_HOME%\java" -jar core.jar

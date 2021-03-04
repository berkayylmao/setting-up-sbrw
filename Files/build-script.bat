@echo off
cls

set "JAVA_HOME=C:\AdoptOpenJDK10"

mkdir sbrw
cd sbrw
set "SELFDIR=%CD%"

pushd %CD%
cd ..
cd ..
cd ..
set "REPOS=%CD%"
popd

echo "Building SBRW-Core..."
cd "%REPOS%\soapbox-race-core"
call mvn clean package

mkdir "%SELFDIR%\core"
if not exist "%SELFDIR%\core\project-defaults.yml" copy /Y "project-defaults.yml" "%SELFDIR%\core\project-defaults.yml"
copy /Y "target\core-thorntail.jar" "%SELFDIR%\core\core.jar"

echo "Building WUGG-Freeroam..."
cd "%REPOS%\freeroam\cmd\freeroamd"
go build freeroamd.go

mkdir "%SELFDIR%\freeroam"
copy /Y "freeroamd.exe" "%SELFDIR%\freeroam\freeroamd.exe"
copy /Y "config.toml" "%SELFDIR%\freeroam\config.toml"

echo "Copying Nilzao-RaceSync..."
cd "%REPOS%\sbrw-mp-sync-2018"

mkdir "%SELFDIR%\race\keys"
copy /Y "sbrw-mp.jar" "%SELFDIR%\race\race.jar"

echo "============= SBRW Projects Completed ============="

echo "Building Openfire..."
cd "%REPOS%\openfire"
call mvn clean verify -pl distribution -am

cd "distribution\target\distribution-base"

mkdir "%SELFDIR%\openfire"
if exist "%SELFDIR%\openfire\conf" del /F /Q /S "conf" > NUL
if exist "%SELFDIR%\openfire\conf" rmdir /Q /S "conf" > NUL

robocopy "%REPOS%\openfire\distribution\target\distribution-base" "%SELFDIR%\openfire" /S /E
copy /Y "%SELFDIR%\..\Build tools\sbrwopenfirelauncher.bat" "%SELFDIR%\openfire\bin\sbrwopenfirelauncher.bat"

echo "Building Openfire RestAPI Plugin..."
cd "%REPOS%\openfire-restAPI-plugin"
call mvn clean package

copy /Y "target\restAPI-openfire-plugin-assembly.jar" "%SELFDIR%\openfire\plugins\restAPI.jar"

echo "Building Openfire Non-SASL Authentication Plugin..."
cd "%REPOS%\openfire-nonSaslAuthentication-plugin"
call mvn clean package

copy /Y "target\nonSaslAuthentication-openfire-plugin-assembly.jar" "%SELFDIR%\openfire\plugins\nonSaslAuthentication.jar"

echo "============= Openfire Projects Completed ============="

echo "Done!"
pause

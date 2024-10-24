@echo off
for /F %%i in ('git tag --list --sort=committerdate') do set BUILDTAG=%%i
for /F %%i in ('git rev-parse HEAD') do set BUILDCOMMIT=%%i
set BUILDCOMMIT=%BUILDCOMMIT:~0,8%
for /F %%i in ('git branch --show-current') do set BUILDBRANCH=%%i

echo %BUILDTAG% %BUILDCOMMIT% %BUILDBRANCH%

echo MSGVER: .ASCIZ  "%BUILDTAG%"> ..\..\src\version.inc

SET VERSION=%BUILDTAG:~1%

pushd ..\..\src
call build_by_turbo8.bat
bkbin2wav-windows-386.exe -i ponydiamonds_ru.bin -o ponydiamonds_ru.wav
bkbin2wav-windows-386.exe -i ponydiamonds_en.bin -o ponydiamonds_en.wav
popd

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN

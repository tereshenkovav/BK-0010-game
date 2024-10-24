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
popd

SET BKEMUDIR=C:\BKEmu-313-x32

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU /WINARC=Win32 /x64=
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN /WINARC=Win32 /x64=

SET BKEMUDIR=C:\BKEmu-313-x64

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU /WINARC=Win64 /x64=_x64
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN /WINARC=Win64 /x64=_x64

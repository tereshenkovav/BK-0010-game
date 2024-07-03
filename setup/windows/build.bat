SET VERSION=0.9.0
SET BKEMUDIR=C:\BKEmu-313-x32

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU /WINARC=Win32 /x64=
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN /WINARC=Win32 /x64=

SET BKEMUDIR=C:\BKEmu-313-x64

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU /WINARC=Win64 /x64=_x64
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN /WINARC=Win64 /x64=_x64

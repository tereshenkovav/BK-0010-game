if NOT "%~1" == "" goto mainproc

echo "Argument - lang code" 
exit

:mainproc

rm -f PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip
cd files
7z a -mx9 ..\PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip bk.ini
7z a -mx9 ..\PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip scripts\Autorun\monitor_load.bkscript
cd ..

7z a -mx9 PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip %BKEMUDIR%\BK.exe

SET TMPDIR=%TEMP%\U7fcha2tk9yGl
mkdir %TMPDIR%\bin
copy ..\..\src\ponydiamonds_%1.bin %TMPDIR%\bin\ponydiamonds.bin
mkdir %TMPDIR%\dll
copy %BKEMUDIR%\dll\BKOscScrOGL.dll %TMPDIR%\dll
copy %BKEMUDIR%\dll\BKScreenOGL.dll %TMPDIR%\dll
mkdir %TMPDIR%\rom
copy %BKEMUDIR%\rom\bk10_017_mon.rom %TMPDIR%\rom
copy %BKEMUDIR%\rom\bk10_106_basic1.rom %TMPDIR%\rom
copy %BKEMUDIR%\rom\bk10_107_basic2.rom %TMPDIR%\rom
copy %BKEMUDIR%\rom\bk10_108_basic3.rom %TMPDIR%\rom
echo BK.exe /b ponydiamonds.bin > %TMPDIR%\run_game.bat

7z a -mx9 PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip %TMPDIR%\bin
7z a -mx9 PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip %TMPDIR%\dll
7z a -mx9 PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip %TMPDIR%\rom
7z a -mx9 PonyDiamonds-%2-%VERSION%-BKEmulator-Win32.zip %TMPDIR%\run_game.bat

if NOT "%~1" == "" goto mainproc

echo "Argument - lang code" 
exit

:mainproc

rm -f PonyDiamonds-%2-%VERSION%-BK0010.zip
cd ..\..\src
bkbin2wav-windows-386.exe -i ponydiamonds_%1.bin -o ponydiamonds_%1.wav
7z a -mx9 ..\setup\bk0010\PonyDiamonds-%2-%VERSION%-BK0010.zip ponydiamonds_%1.bin
7z a -mx9 ..\setup\bk0010\PonyDiamonds-%2-%VERSION%-BK0010.zip ponydiamonds_%1.Wav
cd ..\setup\bk0010

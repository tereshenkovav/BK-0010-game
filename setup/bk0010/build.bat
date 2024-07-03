SET VERSION=0.9.0

pushd ..\..\src
bkbin2wav-windows-386.exe -i ponydiamonds_ru.bin -o ponydiamonds_ru.wav
bkbin2wav-windows-386.exe -i ponydiamonds_en.bin -o ponydiamonds_en.wav
popd

SmartZipBuilder.exe script.szb /LANGL=ru /LANGH=RU
SmartZipBuilder.exe script.szb /LANGL=en /LANGH=EN

UTF8toKOI8R.exe strings-ru.utf8 strings.inc
macro11.exe -I . -rt11 -ysl 64 -yus ponydiamonds.asm -o ponydiamonds.obj
pclink11.exe ponydiamonds.obj /T:1000
Sav2BkBin ponydiamonds.sav ponydiamonds.bin
copy ponydiamonds.bin ponydiamonds_ru.bin
del ponydiamonds.obj
del ponydiamonds.sav

copy strings-en.utf8 strings.inc
macro11.exe -I . -rt11 -ysl 64 -yus ponydiamonds.asm -o ponydiamonds.obj
pclink11.exe ponydiamonds.obj /T:1000
Sav2BkBin ponydiamonds.sav ponydiamonds.bin
copy ponydiamonds.bin ponydiamonds_en.bin
del ponydiamonds.obj
del ponydiamonds.sav

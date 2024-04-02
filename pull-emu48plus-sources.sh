#!/bin/bash

set -eu

cd ./app/src/main/cpp/ || exit 1

[ -d ./emu48plus.bkp ] && rm -fr ./emu48plus.bkp
[ -d ./emu48plus ] && mv ./emu48plus ./emu48plus.bkp

echo "Pulling Emu48+ sources"
wget -c "https://www.hpcalc.org/hp48/pc/emulators/e48sp65plus.zip"
unzip e48sp65plus.zip source.zip
unzip -d emu48plus source.zip
rm e48sp65plus.zip source.zip

echo "Correct filenames' case"
cd emu48plus || exit 1
for i in $(fd -e h -e c -e H -e C); do
    mv "$i" "$(echo "$i" | tr '[:upper:]' '[:lower:]')";
done
sed -i 's|Emu48\.h|emu48.h|g' ./*.c ./*.h
sed -i 's|Emu48Dll\.h|emu48dll.h|g' ./*.c ./*.h
sed -i 's|Opcodes\.h|opcodes.h|g' ./*.c ./*.h
sed -i 's|Ops\.h|ops.h|g' ./*.c ./*.h

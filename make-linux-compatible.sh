#!/bin/zsh

set -eu

cd "$(dirname "$0")" || exit 1
CWD=$(pwd)

echo "> remove those ugly ^M characters"
fd -e c \
   -e h \
   -e C \
   -e H \
   -e java \
   -e kml \
   -e KML \
   -e kmi \
   -e htm \
   -e pro \
   -e xml \
   -e txt \
   -e gradle \
   -e properties \
   -x sed -i 's|||g'

cd ./app/src/main/cpp/core/ || exit 1

echo "> translitterate windows-encoded ß to 'ss'"
sed -i 's/'$(echo "\0337")'/ss/g' ./*

echo "> Correct filenames' case"
for f in ./*; do
    dos2unix "$f" >/dev/null 2>&1

    echo "$f" | grep -q "[A-Z]" && mv "$f" "$(echo "$f" | tr '[:upper:]' '[:lower:]')"
done

cd "$CWD" || exit 1

echo "> fix includes for lowercase filenames"
sed -i 's|Emu48\.h|emu48.h|g' $(grep -l "Emu48\.h[^t]" * -r)
sed -i 's|Emu48Dll\.h|emu48dll.h|g' $(grep -l "Emu48Dll\.h" * -r)
sed -i 's|Opcodes\.h|opcodes.h|g' $(grep -l "Opcodes\.h" * -r)
sed -i 's|Ops\.h|ops.h|g' $(grep -l "Ops\.h" * -r)

echo "> make gradlew executable"
chmod +x ./gradlew

echo "> gitignore secrets"
echo "keystore.properties" >> .gitignore
echo "keystore.kjs" >> .gitignore

echo "> patch app/build.gradle to add custom suffix to build"
SUFFIX=${SUFFIX:-gwh}
BUILD_SUFFIXES=" versionNameSuffix \"-${SUFFIX}\"\n        versionName"
ESCAPED_BUILD_SUFFIXES="$(echo "${BUILD_SUFFIXES}" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/\$/\\$/g')"
sed -i 's/ versionName/'"${ESCAPED_BUILD_SUFFIXES}"'/' app/build.gradle
sed -i 's/Emu48-v$versionName/$applicationId-v$versionName$versionNameSuffix/' app/build.gradle

echo "> prettify all C code"
clang-format -i $(fd -e c -e h)

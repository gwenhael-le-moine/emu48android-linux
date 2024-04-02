#!/bin/bash

cd "$(dirname "$0")" || exit 1

KEYSTORE_FILE=${KEYSTORE_FILE:-./keystore.jks}
ALIAS=key-emu48

echo "Generating $KEYSTORE_FILE…"
keytool -genkey -keystore "$KEYSTORE_FILE" -keyalg RSA -validity 9125 -alias $ALIAS

echo -n "Type again the password (will not echo): "
read -s password
echo

echo "Generating ./keystore.properties…"
cat <<EOF > ./keystore.properties
storeFile=$KEYSTORE_FILE
storePassword=$password
keyAlias=$ALIAS
keyPassword=$password
EOF

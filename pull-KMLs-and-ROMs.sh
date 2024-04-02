#!/bin/bash

set -eu

cd "$(dirname "$0")" || exit 1

cd ./app/src/main/assets/ || exit 1

[ -d ./calculators.bkp ] && rm -fr ./calculators.bkp
cp -a ./calculators ./calculators.bkp

cd ./calculators || exit 1

rm -fr ./realcalcs* ./rom.* ./gxrom* ./sxrom* ./*.ico ./*.kml ./*.png ./*.kmi ./readme-rom.49g.txt

echo "Pulling Eric Rechlin's Real Calcs KML Scripts for Emu48 and Emu48+"
wget -c "https://www.hpcalc.org/hp48/pc/emulators/realcalcs.zip"
unzip realcalcs.zip
rm realcalcs.zip
mv ./docs ./realcalcs-docs
mv ./skins/* ./
rm -fr ./skins

wget -c "https://www.hpcalc.org/hp49/pc/emulators/realcalcsplus.zip"
unzip realcalcsplus.zip
rm realcalcsplus.zip
mv ./docs ./realcalcsplus-docs
mv ./skins/* ./
rm -fr ./skins

echo " …removing the medium versions"
rm ./*-m.kml ./*-m.png ./*-mc.kml ./*-mc.png ./*-muc.kml ./*-muc.png

echo "Pulling ROM for 38g"
curl "https://www.hpcalc.org/hp38/pc/38grom.zip" --output - | funzip > "rom.38g"

echo "Pulling ROM for 39g"
curl "https://www.hpcalc.org/hp39/pc/rom3940.zip" --output - | funzip > "rom.39g"

echo "Pulling ROM for 48S(X)"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-a.zip" --output - | funzip > "sxrom-a"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-b.zip" --output - | funzip > "sxrom-b"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-c.zip" --output - | funzip > "sxrom-c"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-d.zip" --output - | funzip > "sxrom-d"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-e.zip" --output - | funzip > "sxrom-e"
curl "https://www.hpcalc.org/hp48/pc/emulators/sxrom-j.zip" --output - | funzip > "sxrom-j"

echo "Pulling ROM for 48G(X)"
curl "https://www.hpcalc.org/hp48/pc/emulators/gxrom-l.zip" --output - | funzip > "gxrom-l"
curl "https://www.hpcalc.org/hp48/pc/emulators/gxrom-m.zip" --output - | funzip > "gxrom-m"
curl "https://www.hpcalc.org/hp48/pc/emulators/gxrom-p.zip" --output - | funzip > "gxrom-p"
curl "https://www.hpcalc.org/hp48/pc/emulators/gxrom-r.zip" --output - | funzip > "gxrom-r"

cp sxrom-j rom.48s
cp gxrom-r rom.48g

echo "Pulling ROM for 49G(+) / 50g"
wget -c "https://www.hpcalc.org/hp49/pc/rom/hp4950emurom.zip"
unzip hp4950emurom.zip
rm hp4950emurom.zip
mv ./readme.txt ./readme-rom.49g.txt

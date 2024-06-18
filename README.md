Post-fork changes by Gwenhael Le Moine:
- rename the app and Java packages to avoid confusion
- add Makefile and helper scripts
- Assets:
  - ROMs
    - Pull unpatched ROMs from hpcalc.org using the script `pull-KMLs-and-ROMs.sh`
  - Skins
    - Pull Eric Rechlin's Real Calcs from hpcalc.org using the script `pull-KMLs-and-ROMs.sh`
  - Emu48+ source
    - rename directory from `core/` to `emu48plus/`
    - Pull upstream Emu48+ source from hpcalc.org using the script `pull-emu48plus-sources.sh`
    - fix the case of Emu48+ source files to allow compilation on GNU/Linux


Also see original ReadMe.txt for upstream changes and information

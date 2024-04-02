.PHONY: release debug clean mrproper pull-assets keystore

release:
	./gradlew assembleRelease assembleReleaseUnitTest
	find . -name \*.apk

debug:
	./gradlew assembleDebug assembleDebugUnitTest
	find . -name \*.apk

clean:
	./gradlew clean
	[ -e ./app/src/main/cpp/emu48plus.bkp ] && rm -fr ./app/src/main/cpp/emu48plus.bkp
	[ -e ./app/src/main/assets/calculators.bkp ] && rm -fr ./app/src/main/assets/calculators.bkp

mrproper: clean

pull-assets:
	bash ./pull-KMLs-and-ROMs.sh
	zsh ./pull-emu48plus-sources.sh

keystore:
	bash ./gen-keystore.sh

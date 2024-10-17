.PHONY: release release-with-assets debug debug-with-assets clean mrproper pull-emu48plus pull-assets keystore linux-compatible

release:
	./gradlew assembleRelease assembleReleaseUnitTest
	find . -name \*.apk

release-with-assets: pull-assets release

debug:
	./gradlew assembleDebug assembleDebugUnitTest
	find . -name \*.apk

debug-with-assets: pull-assets debug

clean:
	./gradlew clean
	-rm -fr ./app/src/main/cpp/emu48plus.bkp
	-rm -fr ./app/src/main/assets/calculators.bkp

mrproper: clean
	-rm -fr ./app/src/main/assets/calculators/*

linux-compatible:
	zsh ./make-linux-compatible.sh

pull-emu48plus:
	zsh ./pull-emu48plus-sources.sh

pull-assets:
	bash ./pull-KMLs-and-ROMs.sh

keystore:
	bash ./gen-keystore.sh

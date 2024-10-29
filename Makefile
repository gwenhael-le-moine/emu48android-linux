.PHONY: release release-with-assets debug debug-with-assets clean mrproper pull-emu48plus pull-assets keystore linux-compatible undo-linux-compatible

release:
	./gradlew assembleRelease assembleReleaseUnitTest
	find . -name \*.apk

debug:
	./gradlew assembleDebug assembleDebugUnitTest
	find . -name \*.apk

clean:
	./gradlew clean
	-rm -fr ./app/src/main/cpp/emu48plus.bkp
	-rm -fr ./app/src/main/assets/calculators.bkp

mrproper: clean
	-rm -fr ./app/src/main/assets/calculators/*

linux-compatible:
	zsh ./make-linux-compatible.sh

undo-linux-compatible:
	git reset --hard HEAD
	rm -f app/src/main/cpp/core/emu48.c
	rm -f app/src/main/cpp/core/emu48.h
	rm -f app/src/main/cpp/core/opcodes.h

keystore:
	bash ./gen-keystore.sh

# These are leftovers from a previous iteration,
# neither necessary not up-to-date but ncie to keep around for reference
release-with-assets: pull-assets release

debug-with-assets: pull-assets debug

pull-emu48plus:
	zsh ./pull-emu48plus-sources.sh

pull-assets:
	bash ./pull-KMLs-and-ROMs.sh

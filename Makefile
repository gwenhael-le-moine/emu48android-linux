.PHONY: release debug clean mrproper

release:
	./gradlew assembleRelease assembleReleaseUnitTest
	find . -name \*.apk

debug:
	./gradlew assembleDebug assembleDebugUnitTest
	find . -name \*.apk

clean:
	./gradlew clean

mrproper: clean

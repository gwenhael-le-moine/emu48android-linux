.PHONY: release debug clean mrproper keystore

release:
	./gradlew assembleRelease assembleReleaseUnitTest
	find . -name \*.apk

debug:
	./gradlew assembleDebug assembleDebugUnitTest
	find . -name \*.apk

clean:
	./gradlew clean

mrproper: clean

keystore:
	keytool -genkey -keystore ./keystore.jks -keyalg RSA -validity 9125 -alias key0

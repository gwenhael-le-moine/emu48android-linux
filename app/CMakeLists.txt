# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

project(Emu48android-ng)

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.6.0)

#add_compile_options(-DDEBUG_DISPLAY)
#add_compile_options(-DDEBUG_SOUND)
#add_compile_options(-DDEBUG_DEBUGGER)
#add_compile_options(-DDEBUG_FLASH)
#add_compile_options(-DDEBUG_IO)
#add_compile_options(-DDEBUG_SERIAL)

#add_compile_options(-DDEBUG_ANDROID_WAVE_OUT)
#add_compile_options(-DDEBUG_ANDROID_TIMER)
#add_compile_options(-DDEBUG_ANDROID_PAINT)
#add_compile_options(-DDEBUG_ANDROID_THREAD)
#add_compile_options(-DDEBUG_ANDROID_FILE)
#add_compile_options(-DDEBUG_ANDROID_SERIAL)

#add_compile_options(-DNEW_WIN32_SOUND_ENGINE)

# For the library LodePNG
add_compile_options(-DLODEPNG_NO_COMPILE_ENCODER)
add_compile_options(-DLODEPNG_NO_COMPILE_DISK)
add_compile_options(-DLODEPNG_NO_COMPILE_ANCILLARY_CHUNKS)
add_compile_options(-DLODEPNG_NO_COMPILE_ERROR_TEXT)
add_compile_options(-DLODEPNG_NO_COMPILE_CPP)
# add_compile_options(-DLODEPNG_NO_COMPILE_CRC) # Disabled to use new CRC function from lodepng.

add_compile_options(-DEMUXX=48)

#add_compile_options(-Wno-error=implicit-function-declaration)
add_compile_options(-fpermissive)
add_compile_options(-Wno-error=incompatible-pointer-types)

if(CMAKE_BUILD_TYPE STREQUAL Release)
        message("RELEASE BUILD")
        add_compile_options(-Ofast)
endif()

include_directories(src/main/cpp/win32)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

add_library( # Sets the name of the library.
        native-lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        src/main/cpp/emu48plus/apple.c
        src/main/cpp/emu48plus/disasm.c
        src/main/cpp/emu48plus/dismem.c
        src/main/cpp/emu48plus/display.c
        src/main/cpp/emu48plus/disrpl.c
        src/main/cpp/emu48plus/engine.c
        src/main/cpp/emu48plus/external.c
        src/main/cpp/emu48plus/fetch.c
        src/main/cpp/emu48plus/files.c
        src/main/cpp/emu48plus/i28f160.c
        src/main/cpp/emu48plus/keyboard.c
        src/main/cpp/emu48plus/keymacro.c
        src/main/cpp/emu48plus/kml.c
        src/main/cpp/emu48plus/lodepng.c
        src/main/cpp/emu48plus/lowbat.c
        src/main/cpp/emu48plus/mops.c
        src/main/cpp/emu48plus/mru.c
        src/main/cpp/emu48plus/opcodes.c
        src/main/cpp/emu48plus/pch.c
        src/main/cpp/emu48plus/redeye.c
        src/main/cpp/emu48plus/romcrc.c
        src/main/cpp/emu48plus/rpl.c
        src/main/cpp/emu48plus/serial.c
        src/main/cpp/emu48plus/settings.c
        src/main/cpp/emu48plus/sound.c
        src/main/cpp/emu48plus/stack.c
        src/main/cpp/emu48plus/symbfile.c
        src/main/cpp/emu48plus/timer.c

# Unused source files from original Emu48:
#        src/main/cpp/emu48plus/cursor.c
#        src/main/cpp/emu48plus/ddeserv.c
#        src/main/cpp/emu48plus/debugger.c
#        src/main/cpp/emu48plus/Emu48.c #-> To rewrite
#	 src/main/cpp/emu48plus/pngcrc.c # Disabled to use new CRC function from lodepng.
#        src/main/cpp/emu48plus/sndenum.c
#        src/main/cpp/emu48plus/udp.c

        src/main/cpp/win32-layer.c
        src/main/cpp/android-layer.c
        src/main/cpp/android-emu.c # Emu48.c rewrite
        src/main/cpp/emu-jni.c
)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
        native-lib
        android
        jnigraphics
        OpenSLES
        log)

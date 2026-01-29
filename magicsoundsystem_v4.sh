# Build Script for magicsystem.dll using ApolloCrossDev 1.0
# Willem Drijver
# 29 January 2025

clear
rm -f *.o *.dll

PREFIX=/home/willem/ApolloCrossDev/Compilers/GCC-6.50-Stable

$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c magicsoundsystem.cpp -o magicsoundsystem.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c magicothersystem.cpp -o magicothersystem.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c audio_utils.cpp -o audio_utils.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c dll.c -o dll.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c dllimport.c -o dllimport.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c dllstartup.c -o dllstartup.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c dlltables.c -o dlltables.o

$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c apollo/ApolloCrossDev_LibC.c -o apollo/ApolloCrossDev_LibC.o
$PREFIX/bin/m68k-amigaos-gcc -DAPOLLO  -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer -c apollo/ApolloCrossDev_Debug.c -o apollo/ApolloCrossDev_Debug.o

$PREFIX/bin/vasmm68k_mot -Fhunk -m68080 -m68881 -opt-speed apollo/ApolloCrossDev_LibASM.s -o apollo/ApolloCrossDev_LibASM.o

$PREFIX/bin/m68k-amigaos-gcc -noixemul -O3 -m68080 -ffast-math -fomit-frame-pointer \
    audio_utils.o \
    magicsoundsystem.o \
    magicothersystem.o \
    dll.o \
    dllimport.o \
    dllstartup.o \
    dlltables.o \
    apollo/ApolloCrossDev_LibASM.o \
    apollo/ApolloCrossDev_LibC.o \
    apollo/ApolloCrossDev_Debug.o \
    -o magicsystem.dll \
    -lSDL \
    -lc \
    -lstdc++ \
    -lvorbis \
    -lvorbisfile \
    -logg \
    -lvorbis \
    -lvorbisfile \
    -logg \
    -ltimidity \
    -lm

rm -f *.o 
#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm tcl tk

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package hp15c

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
mv -v /usr/lib/hp15c/* ./AppDir/bin

mkdir -p ./AppDir/share/fonts
cp -v /usr/share/fonts/HP-15C_Simulator_Font.ttf ./AppDir/share/fonts
cp -r /usr/lib/tcl8* ./AppDir/shared/lib
cp -r /usr/lib/tk8.6 ./AppDir/shared/lib

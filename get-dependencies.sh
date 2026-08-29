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
echo "Getting app..."
echo "---------------------------------------------------------------"
VERSION=5.1.00
echo "$VERSION" > ~/version
wget https://hp-15c-simulator.de/versions/${VERSION}/HP-15C_${VERSION}_Source.zip
bsdtar -xf ./HP-15C_${VERSION}_Source.zip

mkdir -p ./AppDir/bin
mkdir -p ./AppDir/share/fonts
mv -v css icons lib msgs images HP-15C.tcl ./AppDir/bin
mv -v HP-15C_Simulator_Font.ttf ./AppDir/share/fonts

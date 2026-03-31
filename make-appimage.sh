#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q hp15c | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/hp15c.desktop
export STARTUPWMCLASS=Hp-15c.tcl
export ALWAYS_SOFTWARE=1

# Deploy dependencies
quick-sharun /usr/bin/wish ./AppDir/bin/*

# Additional changes can be done in between here
mkdir -p ./AppDir/share/fonts
cp -v /usr/share/fonts/HP-15C_Simulator_Font.ttf ./AppDir/share/fonts
cp -v /usr/lib/tcl8.6 ./AppDir/shared/lib

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage

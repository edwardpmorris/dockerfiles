#!/bin/bash

if [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Navigate to the folder containing your makefile and execute:"
  echo "docker run --rm -v \"\$(pwd):/src\" conoria/pkgbuilder:manjaro"
  exit 1
fi

echo "Updating base"
pacman -Sy --noprogressbar --noconfirm
pacman -S --noprogressbar --noconfirm archlinux-keyring manjaro-keyring
pacman -Su --noprogressbar --noconfirm

echo "Cleaning up the package folder"
rm -rf src pkg *.pkg.tar.xz

echo "Installing packages and building package"
deps=$(awk '/depends/{a=1} a; /)/{a=0}' PKGBUILD | sed "s/optdepends.*'[^']*'/ /" | sed 's/^[^=]*=(//' | sed 's/)//g' | sed "s/'//g")
yes | sudo -u maker pacaur -S --needed $deps
sudo -u maker makepkg --cleanbuild --clean --force

echo "Checking package with namcap"
result=$(find *.pkg.tar.xz)
namcap $result

echo "Testing if package can be installed"
yes | pacman -U $result

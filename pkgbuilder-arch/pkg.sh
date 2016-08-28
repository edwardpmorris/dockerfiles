#!/bin/bash

if [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Navigate to the folder containing your makefile and execute:"
  echo "docker run --rm -v \"\$(pwd):/src\" conoria/pkgbuilder:arch"
  exit 1
fi

echo "Updating base"
pacman -Sy --noprogressbar --noconfirm
pacman -S --noprogressbar --noconfirm archlinux-keyring manjaro-keyring
pacman -Su --noprogressbar --noconfirm

echo "Installing packages and building package"
deps=$(awk '/depends\=/{print}' PKGBUILD | sed 's/.*(//g' | sed 's/)//g' | sed "s/'//g")
sudo -u maker pacaur -S --needed --noconfirm $deps
sudo -u maker makepkg -cf --noconfirm

echo "Checking package with namcap"
result=$(find *.pkg.tar.xz)
namcap $result

echo "Testing if package can be installed"
yes | pacman -U $result

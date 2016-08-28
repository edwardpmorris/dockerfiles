#!/bin/bash

if [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Navigate to the folder containing your makefile and execute:"
  echo "docker run --rm -v \"\$(pwd):/src\" conoia/pkgbuilder"
  exit 1
fi

echo "Updating base"
pacman -Sy --noprogressbar --noconfirm
pacman -S --noprogressbar --noconfirm archlinux-keyring manjaro-keyring
pacman -Su --noprogressbar --noconfirm

echo "Installing dependencies and building package"
sudo -u maker makepkg -scf --noconfirm

echo "Checking package with namcap"
result=$(find *.pkg.tar.xz)
namcap $result

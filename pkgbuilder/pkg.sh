#!/bin/bash

if [ $# -eq 0 ] || [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Navigate to the folder containing your makefile and execute:"
  echo "docker run --rm -v \"\$(pwd):/src\" conoia/pkgbuilder"
  exit 1
fi

echo "Updating base"
pacman -Sy --noprogressbar --noconfirm
pacman -S --noprogressbar --noconfirm archlinux-keyring
pacman -Su --noprogressbar --noconfirm

echo "Installing packages and building packge"
sudo -u maker makepkg -scf ---noprogressbar --noconfirm

echo "Checking package with namcap"
result=$(find *.pkg.tar.xz)
if (result 
namcap $result

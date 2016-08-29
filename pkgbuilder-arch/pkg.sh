#!/bin/bash

if [ "$1" == '--help' ] || [ "$1" == '-h' ]; then
  echo "Navigate to the folder containing your makefile and execute:"
  echo "docker run --rm -it -v \"\$(pwd):/src\" conoria/pkgbuilder:arch"
  exit 1
fi

echo "Updating base"
pacman -Sy --noprogressbar --noconfirm
pacman -S --noprogressbar --noconfirm archlinux-keyring
pacman -Su --noprogressbar --noconfirm

echo "Cleaning up the package folder"

rm -rf src pkg *.pkg.tar.xz

echo "Installing dependencies and building package"
read -t 3 -p "Run interactively (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        promptresp=""
    ;;
    * )
        echo "Running without prompts. If you encounter errors, try interactive mode"
	promptresp="y"
    ;;
esac
deps=$(awk '/depends/{a=1} a; /)/{a=0}' PKGBUILD | sed "s/optdepends.*'[^']*'/ /" | sed 's/^[^=]*=(//' | sed 's/)//g' | sed "s/'//g")
if [ "$promptresp" = "y" ]; then
  yes | sudo -u maker pacaur -S --needed $deps
else
  sudo -u maker pacaur -S --needed $deps
fi
sudo -u maker makepkg --cleanbuild --clean --force

echo "Checking package with namcap"
result=$(find *.pkg.tar.xz)
namcap $result

echo "Testing if package can be installed"
yes | pacman -U $result

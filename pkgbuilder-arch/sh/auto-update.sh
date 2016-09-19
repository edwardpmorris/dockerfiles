#!/bin/bash

set -e

sudo pacman -Syyu --noconfirm
sudo ./mkimage-arch.sh

cd ..
docker run archlinux bash
str=$(docker ps -a | grep "archlinux")
docker export "${str%% *}" | xz > archlinux.tar.xz
docker rm "${str%% *}"
docker rmi archlinux
docker build -t conoria/pkgbuilder:arch .
docker rmi $(docker images -q --filter "dangling=true") 2>&1 || echo $?
docker push conoria/pkgbuilder:arch
sed -i '$d' README.md
date +%D >> README.md

cd ..
git add pkgbuilder-arch/README.md
git add pkgbuilder-arch/archlinux.tar.xz
git commit -m "Auto-update pkgbuilder:arch"
git push

echo "Full auto-update process complete"

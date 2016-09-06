#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
pacman -Syyu --noconfirm
./mkimage-arch.sh
cd ..
docker run archlinux bash
str=$(docker ps -a | grep "archlinux")
docker export "${str%% *}" | xz > archlinux.tar.xz
docker rm "${str%% *}"
docker rmi archlinux
docker build -t conoria/pkgbuilder:arch .
docker rmi $(docker images -q --filter "dangling=true")
docker push conoria/pkgbuilder:arch
cd ..
git add pkgbuilder-manjaro/archlinux.tar.xz
git commit -m "Auto-update pkgbuilder:arch"
git push
echo "Full auto-update process complete"

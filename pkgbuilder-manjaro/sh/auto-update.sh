#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
pacman -Syyu --noconfirm
./mkimage-manjaro.sh
docker run manjaro bash
str=$(docker ps -a | grep "manjaro")
docker export "${str%% *}" | xz > ../manjarolinux.tar.xz
docker rm "${str%% *}"
docker rmi manjaro
docker build -t conoria/pkgbuilder:manjaro .
docker rmi $(docker images -q --filter "dangling=true")
docker push conoria/pkgbuilder:manjaro
cd ../..
git add pkgbuilder-manjaro/manjarolinux.tar.xz
git commit -m "Auto-update pkgbuilder:manjaro"
git push
echo "Full auto-update process complete"

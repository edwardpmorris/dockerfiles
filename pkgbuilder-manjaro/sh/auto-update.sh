#!/bin/bash

set -e

sudo pacman -Syyu --noconfirm
sudo ./mkimage-manjaro.sh

cd ..
docker run manjaro bash
str=$(docker ps -a | grep "manjaro")
docker export "${str%% *}" | xz > manjarolinux.tar.xz
docker rm "${str%% *}"
docker rmi manjaro
docker build -t conoria/pkgbuilder:manjaro .
docker rmi $(docker images -q --filter "dangling=true") 2>&1 || echo $?
docker push conoria/pkgbuilder:manjaro
sed -i '$d' README.md
date +%D >> README.md

cd ..
git add pkgbuilder-manjaro/README.md
git add pkgbuilder-manjaro/manjarolinux.tar.xz
git commit -m "Auto-update pkgbuilder:manjaro"
git push

echo "Full auto-update process complete"

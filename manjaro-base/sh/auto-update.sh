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
docker build -t conoria/manjaro-base .
docker rmi $(docker images -q --filter "dangling=true") 2>&1 || echo $?
docker push conoria/manjaro-base
sed -i '$d' README.md
date +%D >> README.md

cd ..
git add manjaro-base/README.md
git add manjaro-base/manjarolinux.tar.xz
git commit -m "Auto-update manjaro-base"
git push

echo "Full auto-update process complete"

#!/bin/bash

export GOPATH=/opt/go

git config --global user.email "mail@example.com"
git config --global user.name "Done, Gitter"

cd $GOPATH/src/github.com/emersion/neutron

git submodule init
git submodule update

yes 8 | make build-client

sed -i 's/https:\/\/github.com\/ProtonMail\/WebClient.git/https:\/\/github.com\/vpapadopou\/Neutron-WebClient.git/g' .gitmodules
git submodule sync
cd public
git stash
git stash clear
git checkout public
git reset --hard 3dc709cbfc1337919d0e3bec55077f3f91b0ae6e
git pull origin public

cd ..

make build-client

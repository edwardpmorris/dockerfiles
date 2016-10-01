# neutron-webclient

__WARNING: This does not currently build! There is an issue with the angular version in the install commands. I have tried piping `yes 7` and even wrote an expect script, but for some reason these do not work from within Docker build. You must build this image interactively in an alpine:edge container and use `docker commit` to save it to an image.__

## Description

A clean(ish) Alpine-based image used to run [Neutron](https://github.com/emersion/neutron) with the [Neutron-WebClient](https://github.com/vpapadopou/Neutron-WebClient) UI. The database and config should be run independent of the container. 

## Build interactively
```
docker run -it --name neutron alpine:edge sh
```
### Inside the container:
```
apk update && apk add --no-cache sudo go nodejs python git make g++
adduser maker -D
mkdir -p /opt/go
export GOPATH=/opt/go
git config --global user.email "mail@example.com"
git config --global user.name "Done, Gitter" 
go get -u github.com/emersion/neutron
chown -R maker:users /opt/go
## ---------------------------------------
# We execute the following as user `maker`
## ---------------------------------------
sudo -u maker sh
export GOPATH=/opt/go
cd $GOPATH/src/github.com/emersion/neutron
git config --global user.email "mail@example.com"
git config --global user.name "Done, Gitter"
git submodule init
git submodule update
make build-client # choose angular#1.5.8
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
exit
## ---------------------------------------
# We are root again.
## ---------------------------------------
echo "cd $GOPATH/src/github.com/emersion/neutron/ && go run neutron.go ." > /usr/bin/neutron
chmod +x /usr/bin/neutron
mkdir -p /config
mv $GOPATH/src/github.com/emersion/neutron/db /config
mv $GOPATH/src/github.com/emersion/neutron/config.json /config
ln -s /config/db $GOPATH/src/github.com/emersion/neutron/
ln -s /config/config.json $GOPATH/src/github.com/emersion/neutron/
rm -rf /tmp/*
## ---------------------------------------
# Leave the container running for now.
## ---------------------------------------
```
### Then, back on your host machine:
```
docker commit neutron conoria/neutron
docker stop neutron
docker rm neutron
```
### Use the following Dockerfile:
```
FROM conoria/neutron

MAINTAINER Conor Anderson <conor@conr.ca>

USER maker

ENV  GOPATH=/opt/go

EXPOSE  4000

CMD  '/usr/bin/neutron'
```
### Build the final image:
```
docker build -t conoria/neutron-webclient .
```

## Usage
Use the `docker-compose.yml` included in this repo or run:
```
docker run -v $PWD/config:/config -p 4000:4000 conoria/neutron-webclient

```

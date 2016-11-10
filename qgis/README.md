# qgis 

Inspired from [kartoza/docker-qgis-desktop](https://github.com/kartoza/docker-qgis-desktop), runs QGIS in a Docker container. This image is similar, but is based on the Ubuntu packages from the QGIS downloads page. As such, this image is probably a little bloated. Mostly, I was looking for a way to have a fully-featured QGIS install on Manjaro without needing to compile from the AUR.

## Usage

If you user is in the docker group, run the commands below. If not, run as root and specify which user's home volume you want to use e.g. `-v /home/maker:/home/maker`.

```
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
docker run --rm -it \
  -v /home/conor:/home/conor \
  -v $XSOCK:$XSOCK \
  -v $XAUTH:$XAUTH \
  -e XAUTHORITY=$XAUTH \
  -e DISPLAY=unix$DISPLAY \
  conoria/qgis
```

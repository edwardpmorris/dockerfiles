# qgis 

Inspired from [kartoza/docker-qgis-desktop](https://github.com/kartoza/docker-qgis-desktop), runs QGIS in a Docker container. This image is similar, but is based on the QGIS downloads packages.

## Usage

Run the following commands:
```
xhost +
docker run --rm --name="qgis-desktop-ltr" \
	-i -t \
	-v ${HOME}:/home/${USER} \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	conoria/qgis
xhost -

```

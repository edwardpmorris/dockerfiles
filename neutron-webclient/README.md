# neutron-webclient

__WARNING: This does not currently build! There is an issue with the angular version in the install commands. I have tried piping `yes 7` and even wrote an expect script, but for some reason these do not work from within Docker build. You must build this image interactively in an alpine:edge container and use `docker commit` to save it to an image.__

A clean(ish) Alpine-based image used to run [Neutron](https://github.com/emersion/neutron) with the [Neutron-WebClient](https://github.com/vpapadopou/Neutron-WebClient) UI. The database and config should be run independent of the container. 

## Usage

Use `docker-compose.yml` or:

```
docker run -v $PWD/config:/config -p 4000:4000 conoria/neutron-webclient

```

# neutron-webclient

__WARNING: This does not currently build__

A clean(ish) Alpine-based image used to run [Neutron](https://github.com/emersion/neutron) with the [Neutron-WebClient](https://github.com/vpapadopou/Neutron-WebClient) UI. The database and config should be run independent of the container. 

## Usage

Use `docker-compose.yml` or:

```
docker run -v $PWD/config:/config -p 4000:4000 conoria/neutron-webclient

```

FROM ubuntu:16.04

MAINTAINER Conor Anderson <conor@conr.ca>

RUN apt-get update -qq && apt-get install -y --no-install-recommends curl &&\
    curl http://qgis.org/downloads/qgis-2016.gpg.key | apt-key add &&\
    echo "deb http://qgis.org/debian xenial main" >> /etc/apt/sources.list &&\
    apt-get update -qq && apt-get -y dist-upgrade &&\
    apt-get -y install qgis python-qgis &&\
    apt-get autoremove -y --purge curl &&\
    apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*
    
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD ["/start.sh"]


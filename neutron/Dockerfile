FROM alpine:edge

MAINTAINER Conor Anderson <conor@conr.ca>

RUN  apk update && apk add --no-cache go nodejs python git make g++ sudo bash

RUN  adduser maker -D

RUN  mkdir -p /opt/go

ENV  GOPATH=/opt/go

RUN  git config --global user.email "mail@example.com" && \
     git config --global user.name "Done, Gitter" && \ 
     go get -u github.com/emersion/neutron && \
     chown -R maker:users /opt/go

COPY deploy.sh /opt/deploy.sh

RUN  chmod +x /opt/deploy.sh &&\
     sudo -u maker /opt/deploy.sh

RUN  cd $GOPATH/src/github.com/emersion/neutron && \
     echo "cd $PWD && go run neutron.go ." > /usr/bin/neutron && \
     chmod +x /usr/bin/neutron && \
     mkdir -p /config && \
     mv $GOPATH/src/github.com/emersion/neutron/db /config && \
     mv $GOPATH/src/github.com/emersion/neutron/config.json /config && \
     ln -s /config/db $GOPATH/src/github.com/emersion/neutron/ && \
     ln -s /config/config.json $GOPATH/src/github.com/emersion/neutron/

EXPOSE  4000

CMD  '/usr/bin/neutron'

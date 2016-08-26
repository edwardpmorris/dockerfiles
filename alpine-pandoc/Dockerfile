## Start from my the miniscule alpine

FROM alpine:latest

MAINTAINER Conor I. Anderson <conor.anderson@mail.utoronto.ca>

## Add the ghc repo courtesy of mitchty/alpine-ghc

COPY mitch.tishmack@gmail.com-55881c97.rsa.pub /etc/apk/keys/mitch.tishmack@gmail.com-55881c97.rsa.pub
RUN echo "https://s3-us-west-2.amazonaws.com/alpine-ghc/8.0" >> /etc/apk/repositories

## Install the Haskell platform and pandoc

RUN apk update && apk upgrade &&\
  apk add ghc cabal stack linux-headers musl-dev gmp-dev zlib-dev make git
RUN cabal update && cabal install pandoc pandoc-crossref pandoc-citeproc

## Update PATH

ENV PATH ${PATH}:/root/.cabal/bin

## Clean-up

RUN apk del ghc cabal stack linux-headers musl-dev make && \
	rm -rf /tmp/*

CMD ["bash"]

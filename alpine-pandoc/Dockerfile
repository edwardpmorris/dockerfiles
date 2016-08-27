## Start from the miniscule alpine

FROM alpine:latest

MAINTAINER Conor I. Anderson <conor.anderson@mail.utoronto.ca>

## Add the ghc repo courtesy of mitchty/alpine-ghc

COPY mitch.tishmack@gmail.com-55881c97.rsa.pub /etc/apk/keys/mitch.tishmack@gmail.com-55881c97.rsa.pub
RUN echo "https://s3-us-west-2.amazonaws.com/alpine-ghc/8.0" >> /etc/apk/repositories

## Install the Haskell platform and pandoc, and clean-up

RUN apk update && apk upgrade &&\
  apk add ghc cabal stack linux-headers musl-dev gmp-dev zlib-dev make git && \
  cabal update && \
  cabal install hsb2hs && \
  cabal install --flags="embed_data_files" \
	--enable-executable-stripping --disable-documentation --global \
	pandoc pandoc-citeproc && \
  apk del --purge ghc cabal stack linux-headers musl-dev make && \
  rm -rf /usr/local/bin/aeson-pretty /usr/local/bin/json2yaml /usr/local/bin/yaml2json \
         /root/.ghc /root/.cabal /usr/local/lib /usr/local/share

CMD ["sh"]

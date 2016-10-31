FROM alpine:edge
MAINTAINER conor@conr.ca
RUN apk update && apk add --no-cache git \
                   mercurial \
                   wget \
                   supervisor \
                   mariadb-client \
                   mariadb-client-libs \
                   mariadb-dev \
                   python \
                   python2-dev \
                   py2-pip \
                   py-setuptools \
                   py-mysqldb \
                   py2-yaml \
                   py2-psutil \
                   gcc \
                   g++ \
                   zeromq-dev \
                   libxml2-dev \
                   libxslt-dev \
                   libffi-dev \
                   pkgconf \
                   py-lxml \
                   tmux \
                   perl-convert-tnef \
                   curl \
                   stow \
                   sudo \
                   lua5.2 \
                   lua5.2-dev \
                   unzip \
                   s6 \
                   file \
                   gettext \
                   make

ENV LIBSODIUM_VER=1.0.0

RUN mkdir -p /tmp/build &&\
    cd /tmp/build &&\ 
    curl -L -O https://github.com/jedisct1/libsodium/releases/download/${LIBSODIUM_VER}/libsodium-${LIBSODIUM_VER}.tar.gz &&\
    tar -xzf libsodium-${LIBSODIUM_VER}.tar.gz &&\
    cd libsodium-${LIBSODIUM_VER} &&\
    ./configure --prefix=/usr/local/stow/libsodium-${LIBSODIUM_VER} &&\
    make -j4 &&\
    rm -rf /usr/local/stow/libsodium-${LIBSODIUM_VER} &&\
    mkdir -p /usr/local/stow/libsodium-${LIBSODIUM_VER} &&\
    make install &&\
    stow -d /usr/local/stow -R libsodium-${LIBSODIUM_VER} &&\
    cd / &&\
    rm -rf libsodium-${LIBSODIUM_VER} libsodium-${LIBSODIUM_VER}.tar.gz &&\
    pip install 'pip>=1.5.6' 'setuptools>=5.3' && hash pip && pip install 'pip>=1.5.6' 'setuptools>=5.3' tox &&\
    rm -rf /usr/lib/python2.7/dist-packages/setuptools.egg-info

RUN mkdir -p /opt

WORKDIR /opt

RUN git clone https://github.com/nylas/sync-engine.git && rm -rf /opt/sync-engine/.git
# ENV TAG=60d8f1de4630c51c5fe208b620274c6df2e0a6f9
# RUN curl -L -O https://github.com/nylas/sync-engine/archive/${TAG}.zip && unzip ${TAG}.zip && rm ${TAG}.zip && mv sync-engine-${TAG} sync-engine

WORKDIR /opt/sync-engine

RUN sed -i 's/setproctitle==1.1.8/setproctitle==1.1.10/g' requirements.txt &&\
    sed -i 's/.*imapclient.*/imapclient/' requirements.txt && \
    sed -i '/psutil/d' requirements.txt
   

RUN find . -name \*.pyc -delete &&\
    pip install -r requirements.txt && pip install -e . && \
    adduser -D -H inbox && \
    mkdir -p /etc/inboxapp

ADD config.json /etc/inboxapp/config-env.json
ADD secrets.yml /etc/inboxapp/secrets-env.yml
RUN chmod 0644 /etc/inboxapp/config-env.json && chmod 0600 /etc/inboxapp/secrets-env.yml && chown -R inbox:inbox /etc/inboxapp

RUN mkdir -p /var/lib/inboxapp/parts && mkdir -p /var/log/inboxapp && chown inbox:inbox /var/log/inboxapp &&\
    chown -R inbox:inbox /var/lib/inboxapp && chown -R inbox:inbox /opt/sync-engine

RUN mkdir -p /etc/s6/inbox-start && mkdir -p /etc/s6/inbox-api
ADD s6-inbox-start.sh /etc/s6/inbox-start/run
ADD s6-inbox-api.sh /etc/s6/inbox-api/run

RUN chmod o+x /etc/s6/inbox-start/run && chmod o+x /etc/s6/inbox-api/run &&\
    ln -s /usr/bin/s6-finish /etc/s6/inbox-start/finish &&\
    ln -s /usr/bin/s6-finish /etc/s6/inbox-api/finish

WORKDIR /opt/sync-engine/
VOLUME /var/lib/inboxapp
EXPOSE 5555
ENTRYPOINT [ s6-svscan -t 0 /etc/s6 ]
CMD [ s6-svscan -t 0 /etc/s6 ]

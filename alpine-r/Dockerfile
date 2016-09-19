## Starts with the miniscule alpine image, installs R, patches and installs httpuv, and cleans up

FROM alpine:edge

MAINTAINER Conor I. Anderson <conor.anderson@mail.utoronto.ca>

RUN apk update && apk add --no-cache R R-dev curl openssl-dev curl-dev libxml2-dev gcc g++ git coreutils && \
    R -q -e "install.packages('Rcpp', repo='https://cran.rstudio.com')" && \
    curl -L -O https://cran.r-project.org/src/contrib/httpuv_1.3.3.tar.gz \
	&& tar xvf httpuv_1.3.3.tar.gz \
	&& sed -i -e 's/__USE_MISC/_GNU_SOURCE/g' httpuv/src/libuv/src/fs-poll.c \
	&& tar -cf httpuv_1.3.3.tar.gz httpuv \
	&& R CMD INSTALL httpuv_1.3.3.tar.gz \
	&& rm -rf httpuv_1.3.3.tar.gz httpuv /tmp/*

CMD ["R"]


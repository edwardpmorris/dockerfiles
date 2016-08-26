## Start with the miniscule alpine image

FROM alpine:edge

MAINTAINER Conor I. Anderson <conor.anderson@mail.utoronto.ca>

## Install R and a few build tools

RUN apk update && apk add --no-cache R R-dev curl openssl-dev curl-dev gcc g++ git coreutils

## Install httpuv because it seems to be needed quite often and needs to be patched

RUN R -q -e "install.packages('Rcpp', repo='https://cran.rstudio.com')"
RUN curl -L -O https://cran.r-project.org/src/contrib/httpuv_1.3.3.tar.gz \
	&& tar xvf httpuv_1.3.3.tar.gz \
	&& sed -i -e 's/__USE_MISC/_GNU_SOURCE/g' httpuv/src/libuv/src/fs-poll.c \
	&& tar -cf httpuv_1.3.3.tar.gz httpuv \
	&& R CMD INSTALL httpuv_1.3.3.tar.gz \
	&& rm -r httpuv_1.3.3.tar.gz httpuv

CMD ["R"]


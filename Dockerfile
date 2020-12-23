FROM rust:1.48-alpine3.12

ENV VIPS_VERSION=8.10.1

RUN apk add --update --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main --virtual .build-deps \
            build-base \
            pkgconfig \
            glib-dev \
            expat-dev \
            tiff-dev \
            libjpeg-turbo-dev \
            libexif-dev \
            giflib-dev \
            librsvg-dev \
            lcms2-dev \
            libpng-dev \
            orc-dev \
            libwebp-dev \
            libheif-dev \
            libimagequant-dev 

RUN wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz 

RUN mkdir vips

RUN tar xvzf vips-${VIPS_VERSION}.tar.gz -C vips --strip-components 1

WORKDIR /vips

RUN ./configure --enable-debug=no --without-python

RUN make

RUN make install

RUN ldconfig /etc/ld.so.conf.d

WORKDIR /

RUN rm -rf vips

RUN rm -f vips-${VIPS_VERSION}.tar.gz

WORKDIR /usr/src/dali

COPY . .

RUN RUSTFLAGS="-C target-feature=-crt-static $(pkg-config vips --libs)" cargo install --path .

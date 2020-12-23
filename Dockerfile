FROM alpine:3.12

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
            libimagequant-dev && \
    wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz && \
    mkdir vips &&\
    tar xvzf vips-${VIPS_VERSION}.tar.gz -C vips --strip-components 1 && \
    cd /vips && \
    ./configure --enable-debug=no --without-python --without-OpenEXR --disable-static --enable-silent-rule && \
    make install-strip  && \
    ldconfig /etc/ld.so.conf.d && \
    rm -rf /vips && rm -f /vips-${VIPS_VERSION}.tar.gz  && \
    apk del .build-deps && \
    apk add --update --no-cache libgsf glib expat tiff libjpeg-turbo libexif giflib librsvg lcms2 libpng orc libwebp && \
    apk add --update --no-cache libimagequant --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main && \
    apk add --update --no-cache libimagequant --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community libheif=1.6.2-r1 && \
    apk add --update --no-cache libimagequant --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libde265=1.0.4-r0 && \
    export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain nightly    

CMD /usr/local/bin/vips
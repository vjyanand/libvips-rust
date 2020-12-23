FROM vjyanand/libvips:latest

RUN apk add --update --no-cache git

RUN git clone https://github.com/vjyanand/libvips-rust

RUN pwd

WORKDIR /usr/src/dali

RUN pwd

RUN ls

RUN cp -r /libvips-rust .

WORKDIR /usr/src/dali/libvips-rust

RUN RUSTFLAGS="-C target-feature=-crt-static $(pkg-config vips --libs)" cargo install --path .


FROM vjyanand/libvips:latest

RUN apk add --update --no-cache git

RUN git clone https://github.com/vjyanand/libvips-rust

WORKDIR /usr/src/dali

COPY . .

RUN RUSTFLAGS="-C target-feature=-crt-static $(pkg-config vips --libs)" cargo install --path .


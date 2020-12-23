FROM vjyanand/libvips:latest

WORKDIR /usr/src/dali

COPY . .

RUN RUSTFLAGS="-C target-feature=-crt-static $(pkg-config vips --libs)" cargo install --path .


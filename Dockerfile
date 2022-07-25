FROM debian:stable-slim as build

RUN apt update &&\
    apt install -y \
    curl \
    bzip2

WORKDIR aria2
RUN curl -sSL https://github.com/q3aql/aria2-static-builds/releases/download/v1.36.0/aria2-1.36.0-linux-gnu-64bit-build1.tar.bz2 | tar -xj &&\
    mv aria2-1.36.0-linux-gnu-64bit-build1/aria2c .

FROM gcr.io/distroless/static

COPY --from=build aria2/aria2c .
COPY aria2.conf .

VOLUME ["/download"]

ENTRYPOINT ["/aria2c", "--conf-path=/aria2.conf"]

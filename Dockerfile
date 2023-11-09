FROM debian:stable-slim

ARG AUTOCONF_VERSION="2.71" \
    INSTALL_PATH="/opt/autoconf"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y \
    build-essential \
    curl

RUN mkdir -p /tmp/autoconf ${INSTALL_PATH}

COPY --from=undeadline/m4:1.4.19 /opt/m4/bin/m4 /usr/bin/m4

WORKDIR /tmp/autoconf
RUN curl https://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz --output autoconf.tar.gz
RUN tar -xzf autoconf.tar.gz 
RUN cd autoconf-${AUTOCONF_VERSION} && ./configure --prefix=${INSTALL_PATH} && make && make install
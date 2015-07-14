FROM debian:8
MAINTAINER confirm IT solutions, dbarton

ADD ssl.patch /tmp/ssl.patch
ADD apt-src.list /etc/apt/sources.list.d/src.list
WORKDIR /usr/src
RUN apt-get -q update \
    && apt-get install -y openssl devscripts build-essential libssl-dev \
    && apt-get source -y squid3 \
    && apt-get build-dep -y squid3 \
    && cd squid3-3* \
    && patch -p1 -i /tmp/ssl.patch \
    && debuild -us -uc \
    && apt-get install -y logrotate squid-langpack \
    && cd .. \
    && dpkg -i squid3_3*.deb squid3-common*.deb \
    && apt-get install -fy \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/* \
    && rm -rf /tmp/*

VOLUME ['/etc/squid3']

EXPOSE 3128 80 443

WORKDIR /etc/squid3
CMD squid3 -N

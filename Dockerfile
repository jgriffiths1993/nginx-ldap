FROM ubuntu:latest

MAINTAINER Joshua Griffiths "jgriffiths.1993@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y --force-yes update && \
    apt-get -y --force-yes install liblz-dev git libpcre3-dev libldap2-dev libssl-dev gcc make wget
RUN mkdir -p /tmp/sources

RUN wget -qO- http://nginx.org/download/nginx-1.6.2.tar.gz | tar -C /tmp/sources -xzf -

RUN git clone https://github.com/kvspb/nginx-auth-ldap.git /tmp/sources/auth-ldap

RUN cd /tmp/sources/nginx-1.6.2 &&\
    ./configure \
        --with-http_ssl_module\
        --add-module=/tmp/sources/auth-ldap\
        --prefix=/etc/nginx\
        --sbin-path=/usr/sbin\
        --conf-path=nginx.conf\
        --error-log-path=/dev/stderr\
        --http-log-path=/dev/stdout\
        --user=www-data\
        --group=www-data &&\
    make install

RUN mkdir -p /etc/nginx/conf.d

RUN apt-get -y --force-yes remove gcc make &&\
    apt-get -y --force-yes autoremove

RUN rm -rf /tmp/* &&\
    rm -rf /var/lib/apt/lists/*

ADD nginx.conf /etc/nginx/nginx.conf

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

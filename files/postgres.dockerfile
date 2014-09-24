FROM ubuntu:14.04

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install \
    build-essential \
    bison \
    build-essential \
    cmake \
    curl \
    libncurses5-dev \
    mysql-client \
    mysql-server

RUN \
  sed -i 's|key_buffer|# key_buffer|g' /etc/mysql/my.cnf && \
  sed -i 's|myisam-recover|myisam-recover-options|g' /etc/mysql/my.cnf && \
  sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD helper/setup_database /opt/setup_database

WORKDIR /data
VOLUME /data

EXPOSE 3306

CMD mysqld --datadir=/data --user=mysql
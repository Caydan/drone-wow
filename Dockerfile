FROM ubuntu:latest

MAINTAINER Millenium Studio <contact@millenium-studio.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN echo 'deb http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.0/ubuntu trusty main' > /etc/apt/sources.list.d/mariadb.list
RUN echo 'deb-src http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.0/ubuntu trusty main' >> /etc/apt/sources.list.d/mariadb.list

# Install basic packages
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    openssl \
    git

# Install project packages
RUN apt-get install -y \
    libmariadbclient-dev \
    libmysql++-dev \
    libreadline6-dev \
    libace-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libtool

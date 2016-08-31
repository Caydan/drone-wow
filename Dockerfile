FROM debian:jessie
MAINTAINER Millenium Studio <contact@millenium-studio.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN echo 'deb [arch=amd64,i386] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/debian jessie main' > /etc/apt/sources.list.d/mariadb.list
RUN echo 'deb-src http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/debian jessie main' >> /etc/apt/sources.list.d/mariadb.list

# Install basic packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    clang \
    cmake \
    openssl \
    git

# Install project packages
RUN apt-get install -y \
    mariadb-server \
    libmariadbclient-dev \
    libmysql++-dev \
    libreadline6-dev \
    libace-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    libtool \
    binutils-dev \
    libncurses-dev \
    libtbb-dev \
    libiberty-dev \
    libboost-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-iostreams-dev

# Set clang as default compiler
ENV CC clang
ENV CXX clang++

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
    libiberty-dev
    
ARG boost_version=1.59.0
ARG boost_dir=boost_1_59_0
ENV boost_version ${boost_version}

RUN wget http://downloads.sourceforge.net/project/boost/boost/${boost_version}/${boost_dir}.tar.gz \
    && tar xfz ${boost_dir}.tar.gz \
    && rm ${boost_dir}.tar.gz \
    && cd ${boost_dir} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=shared runtime-link=shared install \
    && cd .. && rm -rf ${boost_dir} && ldconfig    

# Set clang as default compiler
ENV CC clang
ENV CXX clang++

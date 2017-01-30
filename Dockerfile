FROM debian:jessie
MAINTAINER FAT <contact@fat.sh>

ENV DEBIAN_FRONTEND noninteractive

# System essentals
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    wget

# Install llvm/clang repo
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo 'deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main' > /etc/apt/sources.list.d/clang.list
RUN echo 'deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main' >> /etc/apt/sources.list.d/clang.list

# Install percona packages from apt
RUN wget -O - https://repo.percona.com/apt/percona-release_0.1-4.jessie_all.deb
RUN dpkg -i percona-release_0.1-4.jessie_all.deb

# Install basic compilation packages
RUN apt-get update && apt-get install -y \
    build-essential \
    clang-3.9 \
    cmake \
    openssl \
    git

# Install project packages
RUN apt-get update && apt-get install -y \
    percona-server-client-5.5 \
    libperconaserverclient18-dev \
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

ENV CC clang
ENV CXX clang++

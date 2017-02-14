FROM debian:jessie-slim
MAINTAINER FAT <contact@fat.sh>

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://deb.debian.org/debian stretch main' > /etc/apt/sources.list.d/debian-stretch.list
RUN echo 'Package: *\nPin: release a=jessie\nPin-Priority: 900' > /etc/apt/preferences.d/debian-stretch
RUN echo 'Package: libboost-dev\nPin: release a=stretch\nPin-Priority: 910' >> /etc/apt/preferences.d/debian-stretch

RUN echo 'deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main' > /etc/apt/sources.list.d/clang.list
RUN apt-key adv --fetch-keys http://apt.llvm.org/llvm-snapshot.gpg.key

RUN apt-get update && apt-get install -y \
    wget

RUN wget https://repo.percona.com/apt/percona-release_0.1-4.jessie_all.deb \
    && dpkg -i percona-release_0.1-4.jessie_all.deb \
    && rm percona-release_0.1-4.jessie_all.deb

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    make \
    gcc \
    g++ \
    clang-3.9 \
    percona-server-client-5.5 \
    libperconaserverclient18-dev \
    libssl-dev \
    libbz2-dev \
    libncurses-dev \
    libreadline6-dev \
    libace-dev \
    gdb \
    curl \
    libboost-all-dev

ENV CC clang-3.9
ENV CXX clang++-3.9

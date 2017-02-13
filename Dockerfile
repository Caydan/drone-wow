FROM debian:jessie-slim
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

RUN echo 'deb http://deb.debian.org/debian stretch main' > /etc/apt/sources.list.d/debian-stretch.list
RUN echo 'APT::Default-Release "jessie";' > /etc/apt/apt.conf.d/default-release

# Install percona packages from apt
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.jessie_all.deb \
    && dpkg -i percona-release_0.1-4.jessie_all.deb \
    && rm percona-release_0.1-4.jessie_all.deb

RUN apt-get update && apt-get install -t stretch -y \
    libboost-dev

RUN apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*

ENV CC clang-3.9
ENV CXX clang++-3.9

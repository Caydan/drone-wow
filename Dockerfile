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
RUN echo 'deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main' >> /etc/apt/sources.list.d/clang.list

# Install percona packages from apt
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.jessie_all.deb
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
    libiberty-dev \
    && rm -rf /var/lib/apt/lists/*

ENV CC clang-3.9
ENV CXX clang++-3.9

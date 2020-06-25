FROM ubuntu:16.04

LABEL Version="1.0"
LABEL Maintainer="Nicolas Gargaud <ngargaud@aldebaran-robotics.com>"
LABEL Description="Slave image to build toolchain package"

ENV DEBIAN_FRONTEND noninteractive
ENV PIP_DEFAULT_TIMEOUT 1000
RUN apt-get update && apt-get install -y apt-utils ca-certificates locales \
    nano htop git curl wget tree python3 python3-dev python3-pip \
    build-essential gdb automake autoconf pkg-config \
    libtool libudev-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade cmake qibuild

ENV CPPFLAGS "-Wall -std=c++11"
WORKDIR /opt/workspace
COPY scripts .

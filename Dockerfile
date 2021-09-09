FROM ubuntu:20.04

LABEL Version="1.0"
LABEL Maintainer="Nicolas Gargaud <ngargaud@aldebaran-robotics.com>"
LABEL Description="Slave image to build toolchain package"

ENV USER_UID 1000
ENV USER_NAME builder
ENV PATH=$PATH:/root/.local/bin
ENV DEBIAN_FRONTEND noninteractive
ENV PIP_DEFAULT_TIMEOUT 1000
RUN apt-get update && apt-get install -y apt-utils ca-certificates locales sudo \
    nano htop git curl wget tree python3 python3-dev python3-pip default-jdk \
    build-essential gdb automake autoconf pkg-config \
    libtool libudev-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade cmake && pip3 install --upgrade qibuild

RUN adduser --disabled-password --gecos "" $USER_NAME --uid $USER_UID \
  && usermod -aG sudo $USER_NAME && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo "$USER_NAME:$USER_NAME" | chpasswd

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod 0740 /usr/bin/entrypoint.sh

USER $USER_NAME
WORKDIR /opt/workspace
COPY scripts /opt/scripts
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

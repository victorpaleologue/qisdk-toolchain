FROM ubuntu:20.04

LABEL Version="1.0"
LABEL Maintainer="Nicolas Gargaud <ngargaud@aldebaran-robotics.com>"
LABEL Description="Slave image to build toolchain package"

ENV USER_UID 1000
ENV USER_NAME builder
ENV PATH=$PATH:/root/.local/bin
ENV DEBIAN_FRONTEND noninteractive
ENV PIP_DEFAULT_TIMEOUT 1000
ENV CPPFLAGS "-Wall -std=c++11 -fPIC"
ENV CXXFLAGS "-Wall -std=c++11 -fPIC"

RUN apt-get update && apt-get install -y apt-utils ca-certificates locales sudo \
    nano htop git curl wget tree python3 python3-dev python3-pip default-jdk \
    build-essential gdb automake autoconf pkg-config \
    libtool libudev-dev \
    '^libxcb.*-dev' libx11-xcb-dev libgl1-mesa-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade cmake && pip3 install --upgrade qibuild
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN adduser --disabled-password --gecos "" $USER_NAME --uid $USER_UID \
  && usermod -aG sudo $USER_NAME && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo "$USER_NAME:$USER_NAME" | chpasswd

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

COPY scripts /opt/scripts
RUN chown -R $USER_NAME:$USER_NAME /opt/scripts

USER $USER_NAME
WORKDIR /opt/workspace

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

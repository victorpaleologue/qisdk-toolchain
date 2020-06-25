#!/bin/bash

export LIBUSB_VER="v1.0.22"
export EXTRACT_DIR="/tmp/libusb"
export INSTALL_DIR="/opt/libusb_${LIBUSB_VER}"
export GIT_URL="https://github.com/libusb/libusb.git"

function build_and_install()
{
  ./bootstrap.sh
  if [ $# -eq 0 ]; then
    ./configure
  else
    ./configure --prefix ${INSTALL_DIR}
  fi
  make -j4
  make install
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIBUSB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

#!/bin/bash

export LIB_VER=${LIB_VER:-"OpenSSL_1_0_2u"}
export NAME="openssl"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/opt/build/${NAME}"
export GIT_URL="https://github.com/openssl/openssl.git"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./config
  else
    ./config --prefix=${INSTALL_DIR} --openssldir=${INSTALL_DIR}
  fi
  make -j4
  make install_sw
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}
echo "${LIB_VER}" >> ${INSTALL_DIR}/VERSION

# install on the system for the next tasks
build_and_install
cd ..
rm -rf ${EXTRACT_DIR}

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output /opt/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi
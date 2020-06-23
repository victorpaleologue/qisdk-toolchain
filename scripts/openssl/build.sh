#!/bin/bash

export SSL_VER="OpenSSL_1_0_2u"
export EXTRACT_DIR="/tmp/openssl"
export INSTALL_DIR="/opt/openssl_${SSL_VER}"
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

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${SSL_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

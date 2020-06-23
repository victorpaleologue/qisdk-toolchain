#!/bin/bash

export ZLIB_VER="v1.2.11"
export EXTRACT_DIR="/tmp/zlib"
export INSTALL_DIR="/opt/zlib_${ZLIB_VER}"
export GIT_URL="https://github.com/madler/zlib.git"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./configure
  else
    ./configure --prefix ${INSTALL_DIR}
  fi
  make -j4
  make install
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${ZLIB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

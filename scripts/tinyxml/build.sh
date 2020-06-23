#!/bin/bash

export TINYXML_VER="8.0.0"
export EXTRACT_DIR="/tmp/tinyxml"
export INSTALL_DIR="/opt/tinyxml_${TINYXML_VER}"
export GIT_URL="https://github.com/leethomason/tinyxml2.git"

function build_and_install()
{
  mkdir build
  cd build

  if [ $# -eq 0 ]; then
    cmake ..
  else
    cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} ..
  fi
  make -j4
  make install

  cd ..
  rm -rf build
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${TINYXML_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

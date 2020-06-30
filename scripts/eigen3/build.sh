#!/bin/bash

export LIB_VER="3.3.7"
export NAME="eigen"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/opt/build/${NAME}"
export GIT_URL="https://gitlab.com/libeigen/eigen.git"

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

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}
echo "${LIB_VER}" >> ${INSTALL_DIR}/VERSION


# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

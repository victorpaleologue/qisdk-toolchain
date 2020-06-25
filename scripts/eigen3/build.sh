#!/bin/bash

export EIGEN_VER="3.3.7"
export EXTRACT_DIR="/tmp/eigen"
export INSTALL_DIR="/opt/eigen_${EIGEN_VER}"
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

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${EIGEN_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

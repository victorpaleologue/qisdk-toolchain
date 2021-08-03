#!/bin/bash

export LIB_VER=${LIB_VER:-"3.3.7"}
export NAME="eigen"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/tmp/build/${NAME}"
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
  sudo make install

  cd ..
  rm -rf build
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}
sudo echo "${LIB_VER}" >> ${INSTALL_DIR}/VERSION


# install on the system for the next tasks
build_and_install
cd ..
rm -rf ${EXTRACT_DIR}

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  sudo qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output /tmp/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi

#!/bin/bash

export LIB_VER=${LIB_VER:-"v1.2.11"}
export NAME="zlib"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/tmp/build/${NAME}"
export GIT_URL="https://github.com/madler/zlib.git"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./configure
  else
    ./configure --prefix ${INSTALL_DIR}
  fi
  make -j4
  sudo make install
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
  sudo qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output /tmp/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi

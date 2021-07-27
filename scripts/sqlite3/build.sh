#!/bin/bash

export LIB_VER=${LIB_VER:-"3320300"}
export NAME="sqlite3"
export EXTRACT_DIR="/tmp/"
export INSTALL_DIR="/tmp/build/${NAME}"
export PKG_URL="https://www2.sqlite.org/2020/sqlite-autoconf-${LIB_VER}.tar.gz"

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

mkdir -p "${EXTRACT_DIR}" && cd "${EXTRACT_DIR}"
wget "${PKG_URL}" && tar -xf "sqlite-autoconf-${LIB_VER}.tar.gz" && cd "sqlite-autoconf-${LIB_VER}"
build_and_install ${INSTALL_DIR}
sudo echo '${LIB_VER}' | sudo tee -a ${INSTALL_DIR}/VERSION

# install on the system for the next tasks
build_and_install
cd ..
sudo rm -rf ${EXTRACT_DIR}/sqlite*

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  sudo qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output /tmp/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi

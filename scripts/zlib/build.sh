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
  if [ $# -eq 0 ]; then
    # No argument passed: installing in the system.
    echo "Installing ZLib in the system"
    sudo make install
  else
    # Argument passed: installing in a custom location.
    echo "Installing ZLib in $1"
    make install
  fi
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}
sudo echo '${LIB_VER}' | sudo tee -a ${INSTALL_DIR}/VERSION

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  sudo qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output /tmp/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi

# install on the system for the next tasks
build_and_install
cd ..
sudo rm -rf ${EXTRACT_DIR}

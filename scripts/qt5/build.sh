#!/bin/bash

# https://wiki.qt.io/Building_Qt_5_from_Git
export LIB_VER=${LIB_VER:-"5.12"}
export NAME="qt5"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/tmp/build/${NAME}"
export GIT_URL="git://code.qt.io/qt/qt5.git"

function build_and_install()
{
  mkdir build
  cd build

  if [ $# -eq 0 ]; then
    ../configure -developer-build -opensource -nomake examples -nomake tests -confirm-license
  else
    ../configure -developer-build -opensource -nomake examples -nomake tests -confirm-license -prefix $1
  fi
  make -j4

  if [ $# -eq 0 ]; then
    # No argument passed: installing in the system.
    echo "Installing $NAME in the system"
    sudo make install
  else
    # Argument passed: installing in a custom location.
    echo "Installing $NAME in $1"
    make install
  fi

  cd ..
  sudo rm -rf build
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}
git submodule update --init --recursive
mkdir -p qtbase/mkspecs/features

build_and_install ${INSTALL_DIR}
sudo echo '${LIB_VER}' | sudo tee -a ${INSTALL_DIR}/VERSION

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  sudo qitoolchain make-package --auto --name ${NAME} --version ${LIB_VER} --target linux64 ${INSTALL_DIR} --output ${WORKSPACE_PATH}
else
  echo "Qibuild is not installed, skipping packaging"
fi

# install on the system for the next tasks
build_and_install
cd ..
sudo rm -rf ${EXTRACT_DIR}

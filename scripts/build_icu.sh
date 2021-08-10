#!/bin/bash

export LIB_VER=${LIB_VER:-"release-67-1"}  # boost depends on it so if you change here remember to update boost script
export NAME="icu"
export EXTRACT_DIR="/tmp/${NAME}"
export INSTALL_DIR="/tmp/build/${NAME}"
export GIT_URL="https://github.com/unicode-org/icu.git"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./runConfigureICU Linux
  else
    ./runConfigureICU Linux --prefix $1
  fi
  make -j4
  sudo make install
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
cd ${EXTRACT_DIR}/icu4c/source
build_and_install ${INSTALL_DIR}
sudo echo '${LIB_VER}' | sudo tee -a ${INSTALL_DIR}/VERSION

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

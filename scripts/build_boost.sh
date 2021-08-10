#!/bin/bash

set -e

export LIB_VER=${LIB_VER:-"64"}
export NAME="boost"
export EXTRACT_DIR="/tmp/"
export INSTALL_DIR="/tmp/build/${NAME}"
export PKG_URL="http://sourceforge.net/projects/boost/files/boost/1.${LIB_VER}.0/boost_1_${LIB_VER}_0.tar.gz"
export ICU_ROOT="/usr/local/lib/icu/67.1/"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./bootstrap.sh --with-python-version=3.5 --with-python=$(which python3) --with-icu=${ICU_ROOT}
  else
    ./bootstrap.sh --with-python-version=3.5 --with-python=$(which python3) --with-icu=${ICU_ROOT} --prefix="${INSTALL_DIR}"
  fi

  echo "Building Boost with C++ flags: ${CPPFLAGS}"
  if [ -n "${CPPFLAGS}" ]; then
    ./b2 -a cxxflags="${CPPFLAGS}"
  else
    ./b2 -a
  fi

  sudo ./b2 install
  sudo ldconfig
}

# install boost from source (specific version is needed)
# with https://stackoverflow.com/questions/5539557/boost-and-python-3-x
curl -L -v "${PKG_URL}" | tar -C ${EXTRACT_DIR}/ -xz
cd ${EXTRACT_DIR}/boost_1_${LIB_VER}_0/
build_and_install ${INSTALL_DIR}
sudo echo '${LIB_VER}' | sudo tee -a ${INSTALL_DIR}/VERSION

# install on the system for the next tasks
build_and_install
cd ..
rm -rf ${EXTRACT_DIR}/boost*

if [ -x "$(command -v qibuild)" ]; then
  echo "------------ Building qitoolchain package ----------------"
  sudo qitoolchain make-package --auto --name ${NAME} --version "1.${LIB_VER}.0" --target linux64 ${INSTALL_DIR} --output /tmp/workspace/
else
  echo "Qibuild is not installed, skipping packaging"
fi

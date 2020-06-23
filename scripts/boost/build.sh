#!/bin/bash

export BOOST_MINOR_VER=64
export EXTRACT_DIR="/tmp/"
export INSTALL_DIR="/opt/boost_1_${BOOST_MINOR_VER}"
export PKG_URL="http://sourceforge.net/projects/boost/files/boost/1.${BOOST_MINOR_VER}.0/boost_1_${BOOST_MINOR_VER}_0.tar.gz"
export ICU_ROOT="/usr/local/lib/icu/67.1/"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./bootstrap.sh --with-python-version=3.5 --with-python=$(which python3) --with-icu=${ICU_ROOT}
  else
    ./bootstrap.sh --with-python-version=3.5 --with-python=$(which python3) --with-icu=${ICU_ROOT} --prefix="${INSTALL_DIR}"
  fi

  ./b2 -a cxxflags="${CPPFLAGS}" && ./b2 install && ldconfig
}

# install boost from source (specific version is needed)
# with https://stackoverflow.com/questions/5539557/boost-and-python-3-x
curl -L -v "${PKG_URL}" | tar -C ${EXTRACT_DIR}/ -xz
cd ${EXTRACT_DIR}/boost_1_${BOOST_MINOR_VER}_0/
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
#build_and_install
rm -rf ${EXTRACT_DIR}/boost*

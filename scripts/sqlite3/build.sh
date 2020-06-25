#!/bin/bash

export SQLITE_VER="3320300"
export EXTRACT_DIR="/tmp/"
export INSTALL_DIR="/opt/sqlite-${SQLITE_VER}"
export PKG_URL="https://www2.sqlite.org/2020/sqlite-autoconf-${SQLITE_VER}.tar.gz"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./configure
  else
    ./configure --prefix ${INSTALL_DIR}
  fi
  make -j4
  make install
}

mkdir -p "${EXTRACT_DIR}" && cd "${EXTRACT_DIR}"
wget "${PKG_URL}" && tar -xf "sqlite-autoconf-${SQLITE_VER}.tar.gz" && cd "sqlite-autoconf-${SQLITE_VER}"
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}/sqlite*

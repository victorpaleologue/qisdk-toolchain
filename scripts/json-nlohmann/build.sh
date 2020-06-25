#!/bin/bash

export JSON_VER="v3.8.0"
export EXTRACT_DIR="/tmp/json"
export INSTALL_DIR="/opt/json_${JSON_VER}"
export GIT_URL="https://github.com/nlohmann/json.git"

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

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${JSON_VER}
cd ${EXTRACT_DIR}
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

#!/bin/bash

export ICU_VER="release-67-1" # boost depends on it so if you change here remember to update boost script
export EXTRACT_DIR="/tmp/icu"
export INSTALL_DIR="/opt/icu_${ICU_VER}"
export GIT_URL="https://github.com/unicode-org/icu.git"

function build_and_install()
{
  if [ $# -eq 0 ]; then
    ./runConfigureICU Linux
  else
    ./runConfigureICU Linux --prefix $1
  fi
  make -j4
  make install
}

git clone ${GIT_URL} ${EXTRACT_DIR} -b ${ICU_VER}
cd ${EXTRACT_DIR}/icu4c/source
build_and_install ${INSTALL_DIR}

# install on the system for the next tasks
build_and_install
rm -rf ${EXTRACT_DIR}

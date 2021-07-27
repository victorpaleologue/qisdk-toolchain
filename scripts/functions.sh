function clone_and_cd {
    git clone ${GIT_URL} ${EXTRACT_DIR} -b ${LIB_VER}
    cd ${EXTRACT_DIR}
}

export -f clone_and_cd
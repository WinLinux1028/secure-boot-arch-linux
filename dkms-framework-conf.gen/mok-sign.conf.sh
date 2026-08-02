#!/usr/bin/env sh

set -e

THIS_FILE_PATH="$( readlink -e "$0" )"
THIS_FILE_DIR_NAME="$( dirname "${THIS_FILE_PATH}" )"
THIS_FILE_NAME="$( basename "${THIS_FILE_PATH}" )"
OUT_FILE_DIR_NAME="$( basename "${THIS_FILE_DIR_NAME}" .gen )"
OUT_FILE_NAME="$( basename "${THIS_FILE_NAME}" .sh )"
cd "$( dirname "${THIS_FILE_PATH}" )/../"

source ./config.sh

mkdir -p "${OUT_FILE_DIR_NAME}"
cat << EOF > "${OUT_FILE_DIR_NAME}/${OUT_FILE_NAME}"
mok_signing_key="$( pwd )/mok/mok.key"
mok_certificate="$( pwd )/mok/mok.crt"
EOF

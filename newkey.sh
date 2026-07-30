#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

TODAY="$( date --date '00:00:00' +%s )"
DAYS="$( expr \( "${END_DATE}" - "${TODAY}" \) / 86400 )"

mkdir -p mok
cd mok

openssl req \
    -new \
    -x509 \
    -newkey rsa:2048 \
    -sha256 \
    -nodes \
    -days "${DAYS}" \
    -subj "${SUBJECT}" \
    -keyout mok.key \
    -out mok.crt
openssl x509 -outform DER -in mok.crt -out mok.cer

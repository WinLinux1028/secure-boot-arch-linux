#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

TODAY_UNIX_TIME="$( date --date '00:00:00' +%s )"
END_DATE_UNIX_TIME="$( date --date "${END_DATE}" +%s )"
DAYS="$( expr \( "${END_DATE_UNIX_TIME}" - "${TODAY_UNIX_TIME}" \) / 86400 )"

mkdir -p mok
cd mok

openssl req \
    -new \
    -x509 \
    -newkey rsa:4096 \
    -sha3-512 \
    -nodes \
    -days "${DAYS}" \
    -subj "${SUBJECT}" \
    -keyout mok.key \
    -out mok.crt
openssl x509 -outform DER -in mok.crt -out mok.cer

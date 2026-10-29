#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

sbsign --key mok/mok.key --cert mok/mok.crt /usr/lib/fwupd/efi/fwupdx64.efi

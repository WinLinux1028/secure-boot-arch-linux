#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

mkdir -p "${EFI_DIR}"
cp -f /usr/share/shim-signed/shimx64.efi "${EFI_DIR}/BOOTX64.EFI"
cp -f /usr/share/shim-signed/mmx64.efi "${EFI_DIR}/"

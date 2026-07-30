#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

mkdir -p "$( dirname "${GRUB_CFG}" )"
grub-mkconfig -o "${GRUB_CFG}"

mkdir -p "${EFI_DIR}"
grub-mkstandalone --format=x86_64-efi --sbat /usr/share/grub/sbat.csv --output="${EFI_DIR}/grubx64_.efi" "boot/grub/grub.cfg=${GRUB_CFG}"
sbsign --key mok/mok.key --cert mok/mok.crt --output "${EFI_DIR}/grubx64.efi" "${EFI_DIR}/grubx64_.efi"
rm -f "${EFI_DIR}/grubx64_.efi"

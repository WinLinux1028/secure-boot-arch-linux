#!/usr/bin/env sh

EFI_DIR="/boot/efi/EFI/BOOT"
GRUB_CFG="/boot/grub/grub.cfg"
SUBJECT="/CN=MOK `hostname`"
END_DATE="$( date --date "9999-12-31" +%s )"
AUR_HELPER="sudo -u ${SUDO_USER} yay -S"
BOOTENTRY_NAME='Arch Linux'

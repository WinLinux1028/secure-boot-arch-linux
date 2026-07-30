#!/usr/bin/env sh

EFI_DIR="/boot/efi/EFI/BOOT"
GRUB_CFG="/boot/grub/grub.cfg"
SUBJECT="/CN=MOK `hostname`"
END_DATE="9999-12-31"
AUR_HELPER_PKG_INSTALL="sudo -u ${SUDO_USER} yay -S"
BOOTENTRY_NAME='Arch Linux'

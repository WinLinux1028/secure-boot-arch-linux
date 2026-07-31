#!/usr/bin/env sh

EFI_DIR="/boot/efi/EFI/BOOT"
GRUB_CFG="/boot/grub/grub.cfg"
SUBJECT="/CN=MOK `hostname`"
END_DATE="9999-12-31" # This is the maximum value.
AUR_HELPER_PKG_INSTALL="sudo -u ${SUDO_USER} yay -S" # Running AUR helpers as root is considered dangerous.
BOOTENTRY_NAME='Arch Linux' # Optional: If not specified, a boot entry will not be added.

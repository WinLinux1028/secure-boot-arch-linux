#!/usr/bin/env sh

set -e
cd "$( dirname "$( readlink -e "$0" )" )"
source ./config.sh

INSTALL_PACKAGES=()
if ! pacman -Q grub; then
    INSTALL_PACKAGES+=('grub')
fi
if ! pacman -Q sbsigntools; then
    INSTALL_PACKAGES+=('sbsigntools')
fi
if ! pacman -Q shim-signed; then
    INSTALL_PACKAGES+=('shim-signed')
fi
if [ ${#INSTALL_PACKAGES[@]} -ne 0 ]; then
    ${AUR_HELPER} "${INSTALL_PACKAGES[@]}"
fi

./update-grub.sh
./update-shim.sh

ESP_DIR="$( findmnt -n -o TARGET -T "${EFI_DIR}" )"
if [ -n "${BOOTENTRY_NAME}" ]; then
    EXISTING_SAME_NAME_BOOT_ENTRY="$( efibootmgr | grep -P "^Boot[0-9A-Fa-f]+?[^\s]*?\s+?${BOOTENTRY_NAME}" | sed -nE 's/^Boot([0-9A-Fa-f]+).*?$/\1/p' )"
    for bootnum in ${EXISTING_SAME_NAME_BOOT_ENTRY}; do
        efibootmgr --bootnum "${bootnum}" --delete-bootnum
    done

    ESP_PART="$( findmnt -n -o SOURCE -T "${EFI_DIR}" )"
    DISK="/dev/$( lsblk -nd -o PKNAME "${ESP_PART}" )"
    ESP_PART_NUM="$( lsblk -nd -o PARTN "${ESP_PART}" )"
    RELATIVE_EFI_DIR="${EFI_DIR#${ESP_DIR}}"
    efibootmgr --unicode --create --label "${BOOTENTRY_NAME}" --disk "${DISK}" --part "${ESP_PART_NUM}" --loader "${RELATIVE_EFI_DIR}/BOOTX64.EFI"
fi

rm -rf pacman-hooks
for script in pacman-hooks.gen/*.sh; do
    "${script}"
done
mkdir -p /etc/pacman.d/hooks
ln -si "$( pwd )/pacman-hooks"/* /etc/pacman.d/hooks/

rm -rf systemd-services
for script in systemd-services.gen/*.sh; do
    "${script}"
done
mkdir -p /etc/systemd/system
ln -si "$( pwd )/systemd-services"/* /etc/systemd/system/
systemctl daemon-reload
for service in systemd-services/*; do
    echo $service 
done

mkdir -p /etc/initcpio/post
ln -si "$( pwd )/mkinitcpio-hooks"/* /etc/initcpio/post/

cp -f mok/mok.cer "${ESP_DIR}/"

echo "✅️ Installation successful!"
echo "MokManager will launch during the first boot in Secure Boot mode, so please enroll the mok.csr file located at the root of the ESP."

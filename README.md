# Secure Boot Setup Tool for Arch Linux
Makes it easy to use Secure Boot on Arch Linux and other Arch-based distributions.

## How to use
1. Clone this repository.
2. Place it in a directory of your choice.
   - It must not be deleted after installation, so it is recommended to place it somewhere out of the way.
   - Since it contains the MOK private key, it should be placed in an encrypted location owned by `root`.
3. Configure `config.sh`.
   - A sample is provided, so please modify it to match your environment.
4. Run `newkey.sh`.
5. Run `install.sh`.
6. Reboot and open your BIOS/UEFI settings.
7. Enable Secure Boot.
8. MokManager will launch. Enroll `mok.cer`, which is located at the root of the ESP.
9. The system should now boot normally.

## FAQ
### Q. Changes are not applied after running `grub-mkconfig`.
A. Run the included `update-grub.sh` instead of `grub-mkconfig` (no arguments required).
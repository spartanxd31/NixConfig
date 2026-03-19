{ config, pkgs, ... }: {
  #Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    useOSProber = true; # Optional, but recommended for dual boot
    efiSupport = true;
    device = "nodev"; # Or specify your boot device
    extraEntries = ''
      menuentry "Reboot to UEFI Firmware Settings" --class efi {
          fwsetup
      }
    '';
  };

  boot.supportedFilesystems = [ "ntfs" ];
}

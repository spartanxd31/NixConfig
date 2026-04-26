{ config, pkgs, ... }: {
  # File system configuration
  fileSystems."/mnt/gamehdd" = {
    device = "UUID=325A332C5A32EBEB"; # Replace with actual UUID
    fsType = "ntfs-3g"; # or "ntfs", depending on what blkid says
    options = [ "nofail" "uid=1000" "gid=100" "umask=0022" "rw" ];
  };
}

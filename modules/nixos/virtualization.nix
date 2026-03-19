{ config, pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker_25;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = true;
  };

  services.spice-vdagentd.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = [ pkgs.virtiofsd ];
      swtpm.enable = true;
    };

  };
}

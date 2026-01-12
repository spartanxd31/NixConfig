{ config, pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker_25;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = true;
  };
}

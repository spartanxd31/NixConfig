{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    modesetting.enable = true;

    powerManagement = {

      enable = false;
      finegrained = false;

    };

    open = false;

    nvidiaSettings = true;

    # Use the beta (or latest) package for explicit sync and HDR fixes on Wayland
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.nvidia-container-toolkit.enable = true;

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}

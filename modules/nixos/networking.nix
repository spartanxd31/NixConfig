{ config, pkgs, ... }:
{
  # networking.hostName = "nixos";
  networking.hostName = "burner";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    2102
  ];
  networking.firewall.allowedUDPPorts = [
    5353
    14540
    14550
    14560
    16020
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 7400;
      to = 8000;
    }
  ];

  # networking.enableIPv6 = false;

  networking.interfaces.enp0s20f0u2 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "10.223.42.27";
        prefixLength = 16;

      }
    ];
  };
  #
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
}

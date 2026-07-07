{ config, pkgs, ... }:
{
  # networking.hostName = "nixos";
  networking.hostName = "burner";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openconnect ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [
    5353
    14540
    14550
    14560
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 7400;
      to = 8000;
    }
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

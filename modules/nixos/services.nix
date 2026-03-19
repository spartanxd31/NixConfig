{ config, pkgs, ... }: {
  powerManagement.enable = true;

  systemd.services.ModemManager.enable = false;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.desktopManager.gnome = {

    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  # services.xserver.displayManager.gdm = {
  #   enable = true;
  #   debug = false;
  #   autoLogin.enable = false;
  #   wayland = true;
  #   banner = "Welcome to my NixOS machine!";
  #   autoSuspend = false;
  # };
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland = { enable = true; };
  # };

  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable systemd-resolved with mDNS/LLMNR so .local hosts are resolved.
  services.resolved = {
    enable = true;
    llmnr = "true";
    extraConfig = ''
      MulticastDNS=yes
    '';
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = false;
    openFirewall = true; # Allow mDNS (UDP 5353) through the firewall
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = true;
    drivers = with pkgs; [ hplipWithPlugin cups-filters cups-browsed ];
  };

  # Enable sound.
  #   services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.blueman.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  services.tailscale.enable = true;

  services.udev.extraRules = ''
    # 1. Ignore the device in ModemManager (prevents probing crashes)
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", ENV{ID_MM_DEVICE_IGNORE}="1"

    # 2. Set permissions for JTAG
    SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE:="666"

    # 3. Unbind the JTAG interface (Interface 0) from the serial driver ftdi_sio
    # We use DRIVER=="ftdi_sio" to target the specific driver binding
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="ftdi_sio", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", \
      RUN+="${pkgs.bash}/bin/bash -c 'echo -n %k > /sys/bus/usb/drivers/ftdi_sio/unbind || true'"
  '';
}

{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
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
  # (Moved to gnome.nix)
  # services.xserver.displayManager.gdm = {
  #   enable = true;
  #   debug = false;
  #   autoLogin.enable = false;
  #   wayland = true;
  #   banner = "Welcome to my NixOS machine!";
  #   autoSuspend = false;
  # };

  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable systemd-resolved with mDNS/LLMNR so .local hosts are resolved.
  services.resolved.settings.Resolve = {
    enable = true;
    LLMNR = true;
    # extraConfig = ''
    #   MulticastDNS=yes
    # '';
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
    drivers = with pkgs; [
      hplipWithPlugin
      cups-filters
      cups-browsed
    ];
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

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.hyprland.binPath =
    lib.mkForce "/run/current-system/sw/bin/start-hyprland";
  programs.uwsm.waylandCompositors.hyprland.prettyName = "Hyprland";

  programs.hyprland = {
    enable = true;

    withUWSM = true;
    package = pkgs-unstable.hyprland;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = true;
    };
  };
  services.tailscale.enable = true;

  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [ libimobiledevice ];
  #
  # services.udev.extraRules = ''
  #   # 1. Ignore the device in ModemManager (prevents probing crashes)
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", ENV{ID_MM_DEVICE_IGNORE}="1"
  #
  #   # 2. Set permissions for JTAG
  #   SUBSYSTEM=="usb", ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", MODE:="666"
  #
  #   # 3. Unbind the JTAG interface (Interface 0) from the serial driver ftdi_sio
  #   # We use DRIVER=="ftdi_sio" to target the specific driver binding
  #   ACTION=="add", SUBSYSTEM=="usb", DRIVER=="ftdi_sio", ATTR{idVendor}=="0403", ATTR{idProduct}=="6010", \
  #     RUN+="${pkgs.bash}/bin/bash -c 'echo -n %k > /sys/bus/usb/drivers/ftdi_sio/unbind || true'"
  # '';

  # services.udev.extraRules = ''
  #   # Copy this file to /etc/udev/rules.d/
  #
  #   ACTION!="add|change", GOTO="openocd_rules_end"
  #   SUBSYSTEM!="usb|tty|hidraw", GOTO="openocd_rules_end"
  #
  #   # Please keep this list sorted by VID:PID
  #
  #   # opendous and estick
  #   ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="204f", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Original FT232/FT245 VID:PID
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Original FT2232 VID:PID
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Original FT4232 VID:PID
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Original FT232H VID:PID
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # DISTORTEC JTAG-lock-pick Tiny 2
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8220", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # TUMPA, TUMPA Lite
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a98", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="8a99", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # XDS100v2
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="a6d0", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Xverve Signalyzer Tool (DT-USB-ST), Signalyzer LITE (DT-USB-SLITE)
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca0", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bca1", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # TI/Luminary Stellaris Evaluation Board FTDI (several)
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcd9", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # TI/Luminary Stellaris In-Circuit Debug Interface FTDI (ICDI) Board
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bcda", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # egnite Turtelizer 2
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="bdc8", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Section5 ICEbear
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c140", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="c141", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Amontec JTAGkey and JTAGkey-tiny
  #   ATTRS{idVendor}=="0403", ATTRS{idProduct}=="cff8", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # TI ICDI
  #   ATTRS{idVendor}=="0451", ATTRS{idProduct}=="c32a", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # STLink v1
  #   ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # STLink v2
  #   ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # STLink v2-1
  #   ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Hilscher NXHX Boards
  #   ATTRS{idVendor}=="0640", ATTRS{idProduct}=="0028", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Hitex STR9-comStick
  #   ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002c", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Hitex STM32-PerformanceStick
  #   ATTRS{idVendor}=="0640", ATTRS{idProduct}=="002d", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Altera USB Blaster
  #   ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Amontec JTAGkey-HiSpeed
  #   ATTRS{idVendor}=="0fbb", ATTRS{idProduct}=="1000", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # SEGGER J-Link
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #   ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Raisonance RLink
  #   ATTRS{idVendor}=="138e", ATTRS{idProduct}=="9000", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Debug Board for Neo1973
  #   ATTRS{idVendor}=="1457", ATTRS{idProduct}=="5118", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Olimex ARM-USB-OCD
  #   ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Olimex ARM-USB-OCD-TINY
  #   ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0004", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Olimex ARM-JTAG-EW
  #   ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="001e", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Olimex ARM-USB-OCD-TINY-H
  #   ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Olimex ARM-USB-OCD-H
  #   ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # USBprog with OpenOCD firmware
  #   ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c63", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # TI/Luminary Stellaris In-Circuit Debug Interface (ICDI) Board
  #   ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00fd", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Marvell Sheevaplug
  #   ATTRS{idVendor}=="9e88", ATTRS{idProduct}=="9e8f", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # Keil Software, Inc. ULink
  #   ATTRS{idVendor}=="c251", ATTRS{idProduct}=="2710", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   # CMSIS-DAP compatible adapters
  #   ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"
  #
  #   LABEL="openocd_rules_end"
  #
  # '';
  #
  services.udev.packages = [ pkgs.openocd ];
}

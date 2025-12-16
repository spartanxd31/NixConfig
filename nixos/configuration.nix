# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      #      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  powerManagement.enable = true;

  #Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  #  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPackages = pkgs.linuxPackages_lqx;

  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;

  services.desktopManager.gnome.enable = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  programs.gamemode.enable = true;

  fonts.packages = with pkgs;
    [
      # other fonts you want...
    ] ++ builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gruvbox-gtk-theme
    gruvbox-dark-icons-gtk
    gruvbox-material-gtk-theme
    playerctl
    git
    nixfmt-classic
    neovim
    procps
    util-linux
    luarocks
    polychromatic
    openrazer-daemon
    gcc
    hyprshot
    python3
    rustc
    htop
    hyprpaper
    hyprpicker
    hyprlock
    hyprland-qt-support
    nwg-look
    qt6Packages.qt6ct
    hyprcursor
    hyprland-qtutils
    hyprland
    icu
    hyprutils
    hypridle
    ntfs3g
    steam
    cliphist
    #mako
    kitty
    tmux
    wl-clipboard
    cargo
    nodejs
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
  ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  environment.sessionVariables = { ENABLE_VK_LAYER_VALVE_steam_overlay = "1"; };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker_25;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # hardware.nvidia-container-toolkit.enable = true;
  programs.steam.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  fileSystems."/mnt/gamehdd" = {
    device = "UUID=325A332C5A32EBEB"; # Replace with actual UUID
    fsType = "ntfs-3g"; # or "ntfs", depending on what blkid says
    options = [ "nofail" "uid=1000" "gid=100" "umask=0022" "rw" ];
  };
  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.grub = {
    enable = true;
    useOSProber = true; # Optional, but recommended for dual boot
    efiSupport = true;
    device = "nodev"; # Or specify your boot device
  };
  #     boot.loader.efi.canTouchEfiVariables = true;

  # TODO: Set your hostname
  networking.hostName = "nixos";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    dom = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" " docker" "openrazer" ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}

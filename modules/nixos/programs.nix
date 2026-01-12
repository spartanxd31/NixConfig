{ inputs, lib, config, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

  programs.gamemode.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.steam.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts.packages = with pkgs;
    [
      # other fonts you want...
    ] ++ builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gruvbox-gtk-theme
    gruvbox-dark-icons-gtk
    gruvbox-material-gtk-theme
    playerctl
    git
    nixfmt-classic
    # neovim
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
    gnomeExtensions.caffeine
    tmux
    wl-clipboard
    cargo
    nodejs
    distrobox
    usbutils
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    openconnect
  ];

  environment.sessionVariables = { ENABLE_VK_LAYER_VALVE_steam_overlay = "1"; };
}

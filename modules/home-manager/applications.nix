{ inputs, config, pkgs, pkgs-unstable, ... }:
let dotfiles = inputs.dotfiles;
in {
  home.packages = with pkgs; [
    # Desktop applications
    discord
    firefox
    heroic
    steam
    obs-studio
    freecad
    via
    zotero

    zoom-us

    # Terminal emulator
    kitty
    btop

    # Wayland/Hyprland utilities
    wofi
    rofi
    waybar
    wlogout
    swaynotificationcenter
    hyprshot
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    hyprcursor
    cliphist
    wl-clipboard

    # X11 utilities
    xorg.xhost
    xorg.xinit

    # System utilities
    distrobox

    # Music
    spicetify-cli
    #remote desktop
    omnissa-horizon-client

  ];

  home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty/";

  programs.kitty = { enable = true; };

  programs.firefox.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.spicetify = let
    spicePkgs =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    theme = spicePkgs.themes.onepunch;
  };

  programs.fastfetch = { enable = true; };
}

{ inputs, config, pkgs, ... }:
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

    # Terminal emulator
    kitty

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
  ];

  home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty/";

  programs.kitty = { enable = true; };

  programs.firefox.enable = true;

  programs.spicetify = let
    spicePkgs =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    theme = spicePkgs.themes.onepunch;
  };

  programs.fastfetch = { enable = true; };
}

{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  dotfiles = inputs.dotfiles;
in
{
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
    prismlauncher

    # X11 utilities
    xhost
    xinit

    # System utilities
    distrobox

    # Music
    spicetify-cli
    #remote desktop
    omnissa-horizon-client

  ];

  programs.obsidian = {
    enable = true;
    package = pkgs-unstable.obsidian;
  };

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      # background_opacity = "0.8";
      hide_window_decorations = "yes";
    };
  };

  programs.firefox.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.onepunch;
    };

  programs.fastfetch = {
    enable = true;
  };
}

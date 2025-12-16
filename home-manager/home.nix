# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.spicetify-nix.homeManagerModules.default
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "dom";
    homeDirectory = "/home/dom";
  };

  home.packages = with pkgs; [
    tree
    bash
    ruff
    unzip
    bat
    hyprcursor
    fzf
    ripgrep
    discord
    godot
    xorg.xhost
    stow
    wofi
    spicetify-cli
    rofi
    tmux
    waybar
    starship
    steam
    lf
    screen
    fd
    icu
    ruff
    freecad
    obs-studio
    xorg.xinit
    swaynotificationcenter
    wlogout
    via
    clang-tools
  ];

  #services.swaync = {
  #  ernable = true;
  #  };

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      theme = spicePkgs.themes.onepunch;
    };

  home.sessionPath = [

    "$HOME/.local/bin"

  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "Domenic Marcelli";
      user.email = "spartanxd31@vt.edu";

    };
  };

  programs.fastfetch = { enable = true; };

  programs.firefox.enable = true;
  #programs.tmux = {
  #enable = true;
  #};
  programs.bash.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.ripgrep = { enable = true; };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.neovim = {
    enable = true;
    # Optional: add extra packages like treesitter, LSPs, etc.
    extraPackages = with pkgs; [ xclip ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

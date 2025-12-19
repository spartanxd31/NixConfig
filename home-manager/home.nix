# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }:
let dotfiles = inputs.dotfiles;
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # let 
  #     dotfiles = inputs.dotfiles;
  #   in {
  #     home.file.".config/ki"
  # }

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
    kitty
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


 home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty/";


  programs.kitty = {
      enable = true;
    };




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

  #TODO: Need to make tpm a submodule to make this work
  home.file.".tmux".source = "${dotfiles}/tmux/.tmux/";

  # programs.tmux = {
  #   enable = true;
  #   plugins = with pkgs.tmuxPlugins; [ tpm tmux-sensible tmux-resurrect ];
  # };

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

  home.file.".config/starship.toml".source =
    "${dotfiles}/starship/.config/starship.toml";

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # home.file.".config/nvim".source = "${dotfiles}/nvim/.config/nvim";

  programs.neovim = {
    enable = true;
    # Optional: add extra packages like treesitter, LSPs, etc.
    extraPackages = with pkgs; [ xclip ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}

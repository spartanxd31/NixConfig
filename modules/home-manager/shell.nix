{ inputs, config, pkgs, ... }:
let dotfiles = inputs.dotfiles;
in {
  programs.bash.enable = true;

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

  programs.ripgrep = { enable = true; };

  #TODO: Need to make tpm a submodule to make this work
  home.file.".tmux".source = "${dotfiles}/tmux/.tmux/";

  # programs.tmux = {
  #   enable = true;
  #   plugins = with pkgs.tmuxPlugins; [ tpm tmux-sensible tmux-resurrect ];
  # };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}

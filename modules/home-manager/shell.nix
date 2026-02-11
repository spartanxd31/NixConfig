{ inputs, config, pkgs, ... }:
let dotfiles = inputs.dotfiles;
in {
  programs.bash.enable = true;

  programs.starship = {

    enable = true;
    # Configuration written to ~/.config/starship.toml
    # Using custom config from dotfiles instead of settings
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

  home.sessionPath = [ "$HOME/.local/bin" ];
}

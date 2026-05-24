{ inputs, config, pkgs, ... }:
let dotfiles = inputs.dotfiles;
in {
  home.packages = with pkgs; [ steam ];

  programs.steam = { enable = true; };
  environment.sessionVariables = { ENABLE_VK_LAYER_VALVE_steam_overlay = "1"; };

}

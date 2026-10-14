{
  imports = [ ../nixos/stylix.nix ];

  # Home Manager-only Stylix target overrides belong here.
  stylix.targets.starship.enable = false;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "orange";
    };
  };
}

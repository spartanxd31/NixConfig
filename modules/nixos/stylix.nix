{ pkgs, ... }: {
  stylix = {
    enable = true;

    # Set base16 scheme to gruvbox-material-dark-hard
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    # Set image for wallpaper and color extraction (optional)
    image = ./Mandalorian.jpg;

    # Polarity (dark or light)
    polarity = "dark";

    # Cursor configuration
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Font configuration
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    # Opacity settings
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };
  };
}

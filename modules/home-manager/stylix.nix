{ pkgs, ... }: {
  stylix = {
    enable = true;

    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    # Cursor configuration - stylix will handle this properly in home-manager
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Control which applications get themed
    autoEnable = true; # Enable most targets by default

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
    };

    image = ./Mandalorian.jpg; # Optional image for color extraction

    # Dark mode configuration
    polarity = "dark"; # Set to "dark" for dark mode, "light" for light mode

    # Override specific targets if needed
    targets = {
      spicetify.enable = false; # Keep custom Onepunch theme for Spotify
      starship.enable = false; # Custom starship config

    };
    # Opacity settings
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
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

  };
  dconf.settings = {
    "org/gnome/desktop/interface" = { accent-color = "orange"; };
  };

}

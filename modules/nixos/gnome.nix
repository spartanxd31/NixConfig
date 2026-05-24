{ config, pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
    gnomeExtensions.caffeine
  ];

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
}

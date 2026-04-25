{ inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [

    hyprland
    hyprland-qtutils
    hyprland-workspaces
    hyprland-autoname-workspaces
    hyprland-protocols
    hyprland-monitor-attached
    hyprshot
    hyprcursor

    rofi
    waybar
    wlogout
    swaynotificationcenter
    wl-clipboard

  ];

  services.hypridle.enable = true;

  programs.hyprlock.enable = true;

  programs.uwsm.enable = true;
}

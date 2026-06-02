{
  inputs,
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages = with pkgs-unstable; [

    # hyprland
    hyprland-qtutils
    hyprland-workspaces
    hyprland-autoname-workspaces
    hyprland-protocols
    hyprland-monitor-attached
    hyprshot
    hyprcursor

    # rofi
    # waybar
    # wlogout
    wl-clipboard
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

  ];

  wayland.windowManager.hyprland = {

    enable = true;
    package = pkgs-unstable.hyprland;
    configType = "hyprlang";

    xwayland = {
      enable = true;
      # force_zero_scaling = true;
    };

    settings = {
      "$mainMod" = "SUPER";
      "$vim_window" = "ctrl, W";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "noctalia msg panel-toggle launcher";
      "$browser" = "zen";
      "$control" = "noctalia msg panel-toggle control-center";

      # Monitor configuration
      "$widescreen_monitor" = "desc:LG Electronics LG ULTRAWIDE 408NTHM93929";
      "$framework_display" = "desc:BOE NE135A1M-NY1";
      monitor = [
        # "eDP-1,highres,auto,1.5"
        "$framework_display,highres,auto,1.5, vrr, 1"
        "$widescreen_monitor , preferred,auto-up,auto, bitdepth, 10, cm, hdr, sdrbrightness, 1.25"

        ",preferred,auto-up,auto"
      ];

      # Environment variables
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "GTK_THEME,Nord"
        "GDK_SCALE,1.5"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "XCURSOR_PATH,$HOME/.icons:/usr/share/icons"
        "HYPRCURSOR_THEME,Future-Cyan-Hyprcursor_Theme"
        "XCURSOR_SIZE,32"
        "HYPRCURSOR_SIZE,32"
      ];

      # Autostart
      exec-once = [
        "noctalia"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "wl-paste --type text --watch cliphist store"
        "hyprctl dispatch workspace 1"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 0;
        resize_on_border = true;
        allow_tearing = false;
        layout = "master";
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 0, 6, default"
        ];
      };

      # Dwindle layout
      dwindle = {
        # pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_on_top = true;
      };

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Input
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      # Device config
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Keybindings
      bind = [
        # Launch programs
        "$mainMod, Q, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, D, exec, $browser"

        # Window management
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod, F, fullscreen"

        # Focus movement (vim keys)
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Window movement (vim keys)
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Waybar toggle
        "SUPER, b, exec,  noctalia msg bar-toggle"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Screenshot
        "$mainMod, Print, exec, hyprshot -m region"

        # Clipboard
        "SUPER, x, exec, cliphist list | rofi -show drun | cliphist decode | wl-copy"

        # Lockscreen
        # "$mainMod, F12, exec, hyprlock"

        # Resize submap
        "ALT, R, submap, resize"
      ]
      ++ (
        # Workspaces 1-9 and 0
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = if i == 9 then 10 else i + 1;
            in
            [
              "$mainMod, ${toString (if i == 9 then 0 else i + 1)}, workspace, ${toString ws}"
              "$mainMod SHIFT, ${toString (if i == 9 then 0 else i + 1)}, movetoworkspace, ${toString ws}"
            ]
          ) 10
        )
      );

      # Repeatable binds (with 'e' flag)
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
      ];

      # Locked binds (with 'l' flag)
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$mainMod SHIFT, M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        # This is the framework button on the framework 13
        ", XF86AudioMedia, exec, $control"
        # Laptop lid switch
        # '', switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1, highres 0x0, 1.5"''
        # '', switch:on:Lid Switch, exec, hyprctl keyword monitor "eDP-1, disable"''
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Workspace rules
      workspace = [
        "1, monitor:$widescreen_monitor, default:true"
        "2, monitor:$widescreen_monitor"
        "3, monitor:$widescreen_monitor"

        "1, monitor:$framework_display, default:true"
        "4, monitor:$framework_display,layout:scrolling,"
        "5, monitor:$framework_display,layout:scrolling,name:coding"
        "6, monitor:$framework_display,layout:scrolling,"

        "m:$widescreen_monitor, layout:dwindle"
        "m:$framework_display, layout:scrolling"
      ];

      # Window rules
      window_rule = [ "suppressevent maximize, class:.*" ];

      # Resize submap
      submap = "resize";
      gesture = [ "3, horizontal, workspace" ];
    };

    # Resize submap keybindings (separate section)
    extraConfig = ''
      submap = resize
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}

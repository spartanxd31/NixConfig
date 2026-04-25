{ inputs, config, pkgs, ... }: {

  wayland.windowManager.hyprland = {

    enable = true;

    xwayland = {
      enable = true;
      # force_zero_scaling = true;
    };

    settings = {
      "$mainMod" = "SUPER";
      "$vim_window" = "ctrl, W";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -show drun";
      "$browser" = "zen";

      # Monitor configuration
      monitor = [ "eDP-1,highres,auto,1.5" "DP-1,preferred,auto-up,auto" ];

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
        "hyprctl dispatch workspace 1 && $terminal"
        "nm-applet &"
        "hyprpaper"
        "swaync"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "hyprctl dispatch workspace 1 && $browser"
        "hypridle"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "wl-paste --type text --watch cliphist store"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
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
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = { new_on_top = true; };

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

        touchpad = { natural_scroll = true; };
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

        # Waybar toggle
        "SUPER, b, exec, pkill waybar || waybar"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Screenshot
        "$mainMod, Print, exec, hyprshot -m region"

        # Clipboard
        "SUPER, x, exec, cliphist list | rofi -show drun | cliphist decode | wl-copy"

        # Lockscreen
        "$mainMod, F12, exec, hyprlock"

        # Resize submap
        "ALT, R, submap, resize"
      ] ++ (
        # Workspaces 1-9 and 0
        builtins.concatLists (builtins.genList (i:
          let ws = if i == 9 then 10 else i + 1;
          in [
            "$mainMod, ${toString (if i == 9 then 0 else i + 1)}, workspace, ${
              toString ws
            }"
            "$mainMod SHIFT, ${
              toString (if i == 9 then 0 else i + 1)
            }, movetoworkspace, ${toString ws}"
          ]) 10));

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
        # Laptop lid switch
        ''
          , switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1, highres 0x0, 1.5"''
        ''
          , switch:on:Lid Switch, exec, hyprctl keyword monitor "eDP-1, disable"''
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Workspace rules
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:eDP-1, default:true"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
      ];

      # Window rules
      windowrulev2 = [ "suppressevent maximize, class:.*" ];

      # Resize submap
      submap = "resize";
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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left =
          [ "custom/notification" "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right =
          [ "network" "cpu" "memory" "battery" "tray" "custom/logout" ];

        "custom/notification" = {
          tooltip-format = false;
          format = "";
          on-click = "swaync-client -t -sw";
          escape = true;

        };
        "hyprland/workspaces" = { format = "{name}"; };
        "clock" = {
          format = "{:%H:%M}  ";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "custom/logout" = {
          format = "⏻";
          on-click = "wlogout";
        };
      };
    };

    # This replaces the 'style.css' file
    style = ''
                        * {
                          border: none;
                          font-family: "JetBrainsMono Nerd Font";
                        }
                        window#waybar {
                          background: rgba(43, 48, 59, 0.5);
                          color: #ffffff;
                        }
                        .modules-left {
                      padding:7px;
                      margin:10 0 5 10;
                      border-radius:10px;
                      background: alpha(@background,.6);
                      box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                  }
                  .modules-center {
                      padding:7px;
                      margin:10 0 5 0;
                      border-radius:10px;
                      background: alpha(@background,.6);
                      box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                  }
                  .modules-right {
                      padding:7px;
                      margin: 10 10 5 0;
                      border-radius:10px;
                      background: alpha(@background,.6);
                      box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
                  }
                        #workspaces button {
                          padding: 0 5px;
                          color: #ffffff;
                        }
                        #workspaces button.active {
                          background-color: #64727D;
                        }
                #custom-notification {
                padding: 0px 5px;
                transition: all .3s ease;
            }
            #bluetooth{
          padding: 0px 5px;
          transition: all .3s ease;

      }
      #network{
          padding: 0px 5px;
          transition: all .3s ease;

      }
      #custom-logout{
          padding: 0px 5px;
          transition: all .3s ease;

      }

    '';
  };

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run,window";
      icon-theme = "Papirus";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      sidebar-mode = true;
    };

  };
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock"; # Or whatever locker you use
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
  };

}

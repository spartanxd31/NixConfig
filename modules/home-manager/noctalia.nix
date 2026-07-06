{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages = with pkgs-unstable; [

    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.noctalia = {

    settings = "./noctalia-config.toml";
    # {
    #
    #   audio = {
    #     enable_overdrive = false;
    #     enable_sounds = false;
    #     notification_sound = "";
    #     sound_volume = 0.5;
    #     volume_change_sound = "";
    #   };
    #
    #   backdrop = {
    #     blur_intensity = 0.5;
    #     enabled = false;
    #     tint_intensity = 0.30000001192092896;
    #   };
    #
    #   bar = {
    #     order = [ "default" ];
    #     default = {
    #       auto_hide = false;
    #       background_opacity = 1.0;
    #       border = "outline";
    #       border_width = 0.0;
    #       capsule = false;
    #       capsule_fill = "surface_variant";
    #       capsule_group = [ ];
    #       capsule_opacity = 1.0;
    #       capsule_padding = 6.0;
    #       capsule_thickness = 0.75999999046325684;
    #       center = [
    #         "notifications"
    #         "clock"
    #         "audio_visualizer"
    #         "control-center"
    #       ];
    #       contact_shadow = false;
    #       enabled = true;
    #       end = [
    #         "caffeine"
    #         "bluetooth"
    #         "network"
    #         "volume"
    #         "brightness"
    #         "battery"
    #         "session"
    #       ];
    #       font_weight = 500;
    #       layer = "top";
    #       margin_edge = 5;
    #       margin_ends = 10;
    #       margin_opposite_edge = 0;
    #       padding = 14;
    #       panel_overlap = 1;
    #       position = "top";
    #       radius = 12;
    #       radius_bottom_left = 12;
    #       radius_bottom_right = 12;
    #       radius_top_left = 12;
    #       radius_top_right = 12;
    #       reserve_space = true;
    #       scale = 1.0;
    #       shadow = true;
    #       show_on_workspace_switch = true;
    #       start = [
    #         "launcher"
    #         "bongocat"
    #         "media"
    #         "workspace_spacer"
    #         "workspaces"
    #         "spacer_system"
    #         "sysmon"
    #       ];
    #       thickness = 34;
    #       widget_spacing = 6;
    #
    #       dead_zone = {
    #         command = "";
    #         middle_command = "";
    #         right_command = "";
    #         scroll_down_command = "";
    #         scroll_up_command = "";
    #       };
    #     };
    #   };
    #
    #   battery = {
    #     warning_threshold = 10;
    #   };
    #
    #   brightness = {
    #     enable_ddcutil = false;
    #     ignore_mmids = [ ];
    #     minimum_brightness = 0.0;
    #     sync_all_monitors = false;
    #   };
    #
    #   calendar = {
    #     enabled = false;
    #     refresh_minutes = 15;
    #   };
    #
    #   control_center = {
    #     hidden_tabs = [ ];
    #     sidebar = "compact";
    #     sidebar_section = "compact";
    #     width = 700;
    #
    #     calendar = {
    #       show_events_card = true;
    #     };
    #
    #     shortcuts = [
    #       { type = "wifi"; }
    #       { type = "bluetooth"; }
    #       { type = "caffeine"; }
    #       { type = "nightlight"; }
    #       { type = "notification"; }
    #       { type = "power_profile"; }
    #     ];
    #   };
    #
    #   desktop_widgets = {
    #     enabled = true;
    #     schema_version = 1;
    #     widget_order = [
    #       "desktop-widget-0000000000000002"
    #       "desktop-widget-0000000000000003"
    #     ];
    #
    #     grid = {
    #       cell_size = 16;
    #       major_interval = 4;
    #       visible = true;
    #     };
    #
    #     widget = {
    #       "desktop-widget-0000000000000002" = {
    #         box_height = 0.0;
    #         box_width = 0.0;
    #         cx = 447.5999755859375;
    #         cy = 786.63995361328125;
    #         enabled = true;
    #         output = "eDP-1";
    #         rotation = 0.0;
    #         type = "sysmon";
    #         settings = {
    #           stat2 = "cpu_temp";
    #         };
    #       };
    #
    #       "desktop-widget-0000000000000003" = {
    #         box_height = 0.0;
    #         box_width = 0.0;
    #         cx = 172.0;
    #         cy = 142.0;
    #         enabled = true;
    #         output = "eDP-1";
    #         rotation = 0.0;
    #         type = "weather";
    #         settings = { };
    #       };
    #     };
    #   };
    #
    #   dock = {
    #     active_monitor_only = false;
    #     active_opacity = 1.0;
    #     active_scale = 1.0;
    #     auto_hide = false;
    #     background_opacity = 0.87999999523162842;
    #     cross_axis_padding = 8;
    #     enabled = false;
    #     icon_size = 48;
    #     inactive_opacity = 0.85000002384185791;
    #     inactive_scale = 0.85000002384185791;
    #     item_spacing = 6;
    #     launcher_custom_image = "";
    #     launcher_custom_image_colorize = false;
    #     launcher_icon = "grid-dots";
    #     launcher_position = "none";
    #     magnification = true;
    #     magnification_scale = 1.4500000476837158;
    #     main_axis_padding = 16;
    #     margin_edge = 8;
    #     margin_ends = 0;
    #     monitors = [ ];
    #     pinned = [ ];
    #     position = "bottom";
    #     radius = 16;
    #     radius_bottom_left = 16;
    #     radius_bottom_right = 16;
    #     radius_top_left = 16;
    #     radius_top_right = 16;
    #     reserve_space = true;
    #     shadow = true;
    #     show_dots = false;
    #     show_instance_count = true;
    #     show_running = true;
    #   };
    #
    #   hooks = {
    #     battery_charging = [ ];
    #     battery_discharging = [ ];
    #     battery_percentage_changed = [ ];
    #     battery_plugged = [ ];
    #     bluetooth_disabled = [ ];
    #     bluetooth_enabled = [ ];
    #     colors_changed = [ ];
    #     logging_out = [ ];
    #     power_profile_changed = [ ];
    #     rebooting = [ ];
    #     session_locked = [ ];
    #     session_unlocked = [ ];
    #     shutting_down = [ ];
    #     started = [ ];
    #     theme_mode_changed = [ ];
    #     wallpaper_changed = [ ];
    #     wifi_disabled = [ ];
    #     wifi_enabled = [ ];
    #   };
    #
    #   idle = {
    #     behavior_order = [
    #       "lock"
    #       "screen-off"
    #       "suspend"
    #     ];
    #     pre_action_fade_seconds = 2.0;
    #
    #     behavior = {
    #       lock = {
    #         action = "lock";
    #         command = "";
    #         enabled = true;
    #         resume_command = "";
    #         timeout = 600.0;
    #       };
    #
    #       screen-off = {
    #         action = "screen_off";
    #         command = "";
    #         enabled = true;
    #         resume_command = "";
    #         timeout = 660.0;
    #       };
    #
    #       suspend = {
    #         action = "lock_and_suspend";
    #         command = "";
    #         enabled = false;
    #         resume_command = "";
    #         timeout = 900.0;
    #       };
    #     };
    #   };
    #
    #   keybinds = {
    #     cancel = [ "Escape" ];
    #     down = [ "Down" ];
    #     left = [ "Left" ];
    #     right = [ "Right" ];
    #     tab_next = [ "Tab" ];
    #     tab_previous = [ "Shift+ISO_Left_Tab" ];
    #     up = [ "Up" ];
    #     validate = [
    #       "Return"
    #       "KP_Enter"
    #       "space"
    #     ];
    #   };
    #
    #   location = {
    #     address = "Blacksburg";
    #     auto_locate = false;
    #     sunrise = "";
    #     sunset = "";
    #   };
    #
    #   lockscreen = {
    #     allow_empty_password = false;
    #     blur_intensity = 0.5;
    #     blurred_desktop = false;
    #     enabled = true;
    #     fingerprint = true;
    #     monitors = [ ];
    #     tint_intensity = 0.30000001192092896;
    #     wallpaper = "";
    #   };
    #
    #   lockscreen_widgets = {
    #     enabled = false;
    #     schema_version = 2;
    #     widget_order = [
    #       "lockscreen-login-box@DP-4"
    #       "lockscreen-login-box@eDP-1"
    #     ];
    #
    #     grid = {
    #       cell_size = 16;
    #       major_interval = 4;
    #       visible = true;
    #     };
    #
    #     widget = {
    #       "lockscreen-login-box@DP-4" = {
    #         box_height = 0.0;
    #         box_width = 0.0;
    #         cx = 1720.0;
    #         cy = 1317.0;
    #         enabled = true;
    #         output = "DP-4";
    #         rotation = 0.0;
    #         type = "login_box";
    #         settings = {
    #           background_color = "surface_variant";
    #           background_opacity = 0.88;
    #           background_radius = 12.0;
    #           input_opacity = 1.0;
    #           input_radius = 6.0;
    #           show_login_button = true;
    #         };
    #       };
    #
    #       "lockscreen-login-box@eDP-1" = {
    #         box_height = 0.0;
    #         box_width = 0.0;
    #         cx = 960.0;
    #         cy = 1157.0;
    #         enabled = true;
    #         output = "eDP-1";
    #         rotation = 0.0;
    #         type = "login_box";
    #         settings = {
    #           background_color = "surface_variant";
    #           background_opacity = 0.88;
    #           background_radius = 12.0;
    #           input_opacity = 1.0;
    #           input_radius = 6.0;
    #           show_login_button = true;
    #         };
    #       };
    #     };
    #   };
    #
    #   nightlight = {
    #     enabled = false;
    #     force = false;
    #     temperature_day = 6500;
    #     temperature_night = 4000;
    #   };
    #
    #   notification = {
    #     background_opacity = 0.97000002861022949;
    #     collapse_on_dismiss = true;
    #     enable_daemon = true;
    #     layer = "top";
    #     monitors = [ ];
    #     offset_x = 20;
    #     offset_y = 8;
    #     position = "top_left";
    #     scale = 1.0;
    #     show_actions = true;
    #     show_app_name = true;
    #   };
    #
    #   osd = {
    #     background_opacity = 0.97000002861022949;
    #     monitors = [ ];
    #     offset_x = 20;
    #     offset_y = 8;
    #     orientation = "horizontal";
    #     position = "top_left";
    #     position_vertical = "top_center";
    #     scale = 1.0;
    #
    #     kinds = {
    #       bluetooth = true;
    #       brightness = true;
    #       caffeine = true;
    #       dnd = true;
    #       keyboard_layout = true;
    #       lock_keys = true;
    #       media = true;
    #       nightlight = true;
    #       power_profile = true;
    #       privacy = true;
    #       volume = true;
    #       volume_input = true;
    #       volume_output = true;
    #       wifi = true;
    #     };
    #   };
    #
    #   plugins = {
    #     enabled = [ ];
    #     source = [
    #       {
    #         auto_update = false;
    #         enabled = true;
    #         kind = "git";
    #         location = "https://github.com/noctalia-dev/official-plugins";
    #         name = "official";
    #       }
    #       {
    #         auto_update = false;
    #         enabled = true;
    #         kind = "git";
    #         location = "https://github.com/noctalia-dev/community-plugins";
    #         name = "community";
    #       }
    #     ];
    #   };
    #
    #   shell = {
    #     app_icon_colorize = false;
    #     avatar_path = "/home/dom/.face";
    #     clipboard_auto_paste = "auto";
    #     clipboard_confirm_clear_history = true;
    #     clipboard_enabled = true;
    #     clipboard_history_max_entries = 100;
    #     clipboard_image_action_command = "";
    #     corner_radius_scale = 1.0;
    #     date_format = "%A, %x";
    #     disable_mipmaps = false;
    #     font_family = "JetBrainsMono Nerd Font";
    #     launch_apps_as_systemd_services = false;
    #     launch_apps_custom_command = "";
    #     middle_click_opens_widget_settings = true;
    #     niri_overview_type_to_launch_enabled = false;
    #     offline_mode = false;
    #     password_style = "default";
    #     polkit_agent = false;
    #     screen_time_enabled = false;
    #     settings_show_advanced = true;
    #     setup_wizard_enabled = true;
    #     shared_gl_context = true;
    #     show_location = true;
    #     telemetry_enabled = true;
    #     time_format = "{:%H:%M}";
    #     ui_scale = 1.0;
    #
    #     animation = {
    #       enabled = true;
    #       speed = 1.0;
    #     };
    #
    #     greeter_sync = {
    #       auto_sync = false;
    #     };
    #
    #     launcher = {
    #       app_grid = false;
    #       categories = true;
    #       compact = false;
    #       session_search = false;
    #       show_icons = true;
    #       sort_by_usage = true;
    #       dmenu = { };
    #     };
    #
    #     mpris = {
    #       blacklist = [ ];
    #     };
    #
    #     panel = {
    #       borders = true;
    #       clipboard_placement = "floating";
    #       clipboard_position = "center";
    #       control_center_placement = "attached";
    #       control_center_position = "auto";
    #       floating_offset = 8;
    #       launcher_placement = "floating";
    #       launcher_position = "center";
    #       open_near_click_clipboard = false;
    #       open_near_click_control_center = false;
    #       open_near_click_launcher = false;
    #       open_near_click_session = false;
    #       open_near_click_wallpaper = false;
    #       polkit_placement = "floating";
    #       polkit_position = "center";
    #       session_placement = "attached";
    #       session_position = "auto";
    #       shadow = true;
    #       transparency_mode = "solid";
    #       wallpaper_placement = "attached";
    #       wallpaper_position = "auto";
    #     };
    #
    #     privacy = {
    #       cam_filter_regex = "";
    #       mic_filter_regex = "";
    #       screen_filter_regex = "";
    #     };
    #
    #     screen_corners = {
    #       enabled = false;
    #       size = 32;
    #     };
    #
    #     screenshot = {
    #       confirm_region = false;
    #       copy_to_clipboard = true;
    #       directory = "";
    #       filename_pattern = "";
    #       freeze_screen = true;
    #       pipe_command = "";
    #       pipe_to_command = false;
    #       save_to_file = true;
    #     };
    #
    #     session = {
    #       power = { };
    #       actions = [
    #         {
    #           action = "lock";
    #           command = "";
    #           countdown_seconds = 0.0;
    #           enabled = true;
    #           glyph = "";
    #           label = "";
    #           shortcut = "1";
    #           variant = "default";
    #         }
    #         {
    #           action = "logout";
    #           command = "";
    #           countdown_seconds = 0.0;
    #           enabled = true;
    #           glyph = "";
    #           label = "";
    #           shortcut = "2";
    #           variant = "default";
    #         }
    #         {
    #           action = "lock_and_suspend";
    #           command = "";
    #           countdown_seconds = 0.0;
    #           enabled = true;
    #           glyph = "";
    #           label = "";
    #           shortcut = "3";
    #           variant = "default";
    #         }
    #         {
    #           action = "reboot";
    #           command = "";
    #           countdown_seconds = 0.0;
    #           enabled = true;
    #           glyph = "";
    #           label = "";
    #           shortcut = "4";
    #           variant = "default";
    #         }
    #         {
    #           action = "shutdown";
    #           command = "";
    #           countdown_seconds = 0.0;
    #           enabled = true;
    #           glyph = "";
    #           label = "";
    #           shortcut = "5";
    #           variant = "destructive";
    #         }
    #       ];
    #     };
    #
    #     shadow = {
    #       alpha = 0.55000001192092896;
    #       direction = "down";
    #     };
    #   };
    #
    #   system.monitor = {
    #     cpu_poll_seconds = 2.0;
    #     cpu_temp_activity_threshold = 60.0;
    #     cpu_temp_critical_threshold = 85.0;
    #     cpu_temp_sensor_path = "";
    #     cpu_usage_activity_threshold = 50.0;
    #     cpu_usage_critical_threshold = 90.0;
    #     disk_pct_activity_threshold = 80.0;
    #     disk_pct_critical_threshold = 95.0;
    #     disk_poll_seconds = 10.0;
    #     enabled = true;
    #     gpu_poll_seconds = 0.0;
    #     gpu_temp_activity_threshold = 60.0;
    #     gpu_temp_critical_threshold = 85.0;
    #     gpu_usage_activity_threshold = 50.0;
    #     gpu_usage_critical_threshold = 95.0;
    #     gpu_vram_activity_threshold = 50.0;
    #     gpu_vram_critical_threshold = 90.0;
    #     memory_poll_seconds = 2.0;
    #     net_rx_activity_threshold = 1.0;
    #     net_rx_critical_threshold = 50.0;
    #     net_tx_activity_threshold = 1.0;
    #     net_tx_critical_threshold = 50.0;
    #     network_poll_seconds = 3.0;
    #     ram_pct_activity_threshold = 60.0;
    #     ram_pct_critical_threshold = 90.0;
    #     swap_pct_activity_threshold = 20.0;
    #     swap_pct_critical_threshold = 80.0;
    #   };
    #
    #   theme = {
    #     builtin = "Gruvbox";
    #     community_palette = "GruvboxAlt";
    #     custom_palette = "";
    #     mode = "dark";
    #     source = "builtin";
    #     wallpaper_scheme = "m3-content";
    #
    #     templates = {
    #       builtin_ids = [ ];
    #       community_ids = [ ];
    #       enable_builtin_templates = true;
    #       enable_community_templates = true;
    #     };
    #   };
    #
    #   wallpaper = {
    #     directory = "/home/dom/Documents/NixConfig/modules/home-manager";
    #     directory_dark = "";
    #     directory_light = "";
    #     edge_smoothness = 0.30000001192092896;
    #     enabled = true;
    #     fill_color = "";
    #     fill_mode = "crop";
    #     per_monitor_directories = false;
    #     transition = [
    #       "fade"
    #       "wipe"
    #       "disc"
    #       "stripes"
    #       "zoom"
    #       "honeycomb"
    #     ];
    #     transition_duration = 1500.0;
    #     transition_on_startup = false;
    #
    #     automation = {
    #       enabled = false;
    #       interval_seconds = 1800;
    #       order = "random";
    #       recursive = true;
    #     };
    #   };
    #
    #   weather = {
    #     effects = true;
    #     enabled = true;
    #     refresh_minutes = 30;
    #     unit = "imperial";
    #   };
    #
    #   widget = {
    #     active_window = {
    #       icon_size = 14.0;
    #       max_length = 260.0;
    #       min_length = 80.0;
    #       title_scroll = "none";
    #       type = "active_window";
    #     };
    #     battery = {
    #       display_mode = "graphic";
    #       type = "battery";
    #     };
    #     bongocat = {
    #       script = "scripts/bongocat.lua";
    #       type = "scripted";
    #     };
    #     brightness = {
    #       show_label = false;
    #       type = "brightness";
    #     };
    #     "control-center" = {
    #       glyph = "brand-bilibili";
    #       type = "control-center";
    #     };
    #     cpu = {
    #       stat = "cpu_usage";
    #       type = "sysmon";
    #     };
    #     date = {
    #       format = "{:%a %d %b}";
    #       type = "clock";
    #     };
    #     input_volume = {
    #       device = "input";
    #       type = "volume";
    #     };
    #     keyboard_layout = {
    #       cycle_command = "";
    #       hide_when_single_layout = false;
    #       type = "keyboard_layout";
    #     };
    #     lock_keys = {
    #       display = "short";
    #       hide_when_off = false;
    #       show_caps_lock = true;
    #       show_num_lock = true;
    #       show_scroll_lock = false;
    #       type = "lock_keys";
    #     };
    #     media = {
    #       art_size = 16.0;
    #       max_length = 220.0;
    #       min_length = 80.0;
    #       title_scroll = "none";
    #       type = "media";
    #     };
    #     network = {
    #       show_label = false;
    #       type = "network";
    #     };
    #     network_rx = {
    #       stat = "net_rx";
    #       type = "sysmon";
    #     };
    #     network_tx = {
    #       stat = "net_tx";
    #       type = "sysmon";
    #     };
    #     output_volume = {
    #       device = "output";
    #       type = "volume";
    #     };
    #     ram = {
    #       stat = "ram_used";
    #       type = "sysmon";
    #     };
    #     spacer = {
    #       type = "spacer";
    #     };
    #     spacer_system = {
    #       type = "spacer";
    #     };
    #     sysmon = {
    #       display = "gauge";
    #       stat = "ram_used";
    #       type = "sysmon";
    #     };
    #     temp = {
    #       stat = "cpu_temp";
    #       type = "sysmon";
    #     };
    #     workspace_spacer = {
    #       capsule = true;
    #       type = "spacer";
    #     };
    #   };
    #
    # };
  };

}

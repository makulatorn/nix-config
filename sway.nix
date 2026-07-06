{ config, pkgs, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = {
      window = {
        titlebar = false;
        border = 2;
      };
      floating = { titlebar = false; };
      modifier = "Mod4";
      terminal = "kitty";
      menu = "fuzzel";
      bars = [ ];
      startup = [{ command = "waybar"; }];

      input = {
        "type:keyboard" = {
          xkb_layout = "us,dk,us";
          xkb_variant = "altgr-intl,,colemak_dh";
          xkb_options = "ctrl:swapcaps";
        };
      };

      keybindings = let mod = "Mod4";
      in {
        "${mod}+Return" = "exec kitty";
        "${mod}+d" = "exec fuzzel";
        "${mod}+q" = "kill";
        "${mod}+shift+q" =
          "exec swaynag -t warning -m 'Is there really a difference between exit and entering?' -b 'Yes' 'swaymsg exit'";

        # focus — arrows, matching qtile
        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+space" = "focus next"; # qtile's layout.next()

        # move windows — shift+arrows
        "${mod}+shift+Left" = "move left";
        "${mod}+shift+Right" = "move right";
        "${mod}+shift+Down" = "move down";
        "${mod}+shift+Up" = "move up";

        # resize — ctrl+arrows, matching qtile's grow_*
        "${mod}+ctrl+Left" = "resize shrink width 30px";
        "${mod}+ctrl+Right" = "resize grow width 30px";
        "${mod}+ctrl+Down" = "resize grow height 30px";
        "${mod}+ctrl+Up" = "resize shrink height 30px";

        # also keep hjkl as an alt binding since you had it before
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+shift+h" = "move left";
        "${mod}+shift+j" = "move down";
        "${mod}+shift+k" = "move up";
        "${mod}+shift+l" = "move right";

        "${mod}+shift+Return" =
          "layout toggle split"; # matches qtile's toggle_split
        "${mod}+Tab" =
          "layout toggle all"; # cycle layouts, like qtile's next_layout
        "${mod}+f" = "fullscreen toggle";
        "${mod}+t" = "floating toggle";
        "${mod}+r" = "reload"; # matches qtile's reload_config

        # workspaces 1-9, matching qtile groups
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+shift+1" = "move container to workspace 1";
        "${mod}+shift+2" = "move container to workspace 2";
        "${mod}+shift+3" = "move container to workspace 3";
        "${mod}+shift+4" = "move container to workspace 4";
        "${mod}+shift+5" = "move container to workspace 5";
        "${mod}+shift+6" = "move container to workspace 6";
        "${mod}+shift+7" = "move container to workspace 7";
        "${mod}+shift+8" = "move container to workspace 8";
        "${mod}+shift+9" = "move container to workspace 9";

        # multi-monitor — matches qtile's next_screen/prev_screen
        "${mod}+mod1+Right" = "focus output right";
        "${mod}+mod1+Left" = "focus output left";

        # keyboard layout cycling — matches your qtile KeyboardLayout widget
        "${mod}+shift+tab" = "input type:keyboard xkb_switch_layout next";
      };
    };
    extraConfig = ''
      output * bg #282828 solid_color

      gaps inner 5
      gaps outer 2

      default_dim_inactive 0.3
      blur enable
      corner_radius 6
      shadows enable

      # class            border      bg          text        indicator   child_border
      client.focused      #ffffff     #ffffff     #000000     #ffffff     #ffffff
      client.unfocused    #494949     #494949     #ffffff     #494949     #494949

      for_window [app_id="firefox"] dim_inactive 0.0
    '';
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
      spacing = 8;
      modules-left = [ "sway/workspaces" ];
      modules-center = [ "sway/window" ];
      modules-right =
        [ "sway/language" "pulseaudio" "network" "battery" "clock" ];

      "sway/language" = {
        format = "{short}";
        tooltip = false;
      };

      "sway/workspaces" = {
        format = "{icon} {name}";
        format-icons = { default = ""; };
      };

      pulseaudio = {
        format = "  {volume}%";
        format-muted = "  muted";
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "  {essid} ({signalStrength}%)";
        format-ethernet = "  {ifname}";
        format-disconnected = "⚠ disconnected";
      };

      battery = {
        format = "{icon}  {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      clock = { format = "  {:%H:%M   %a %d %b}"; };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #282828;
        color: #ffffff;
      }

      #workspaces button {
        padding: 0 8px;
        color: #ffffff;
        background: transparent;
      }

      #workspaces button.focused {
        background: #494949;
        color: #ffffff;
      }

      #pulseaudio,
      #network,
      #battery,
      #clock {
        padding: 0 10px;
      }

      #clock {
        font-weight: bold;
      }
    '';
  };
}

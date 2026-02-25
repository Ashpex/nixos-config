# Waybar configuration for ThinkPad T480 (V2.7 style with Osaka Jade)
{ config, pkgs, ... }:

{
  home-manager.users.ashpex.programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      margin-top = 6;
      margin-bottom = 0;
      margin-left = 10;
      margin-right = 10;

      modules-left = [ "clock" "tray" "idle_inhibitor" "hyprland/workspaces" "mpris" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "network" "pulseaudio" "memory" "cpu" "battery" "custom/notification" "custom/power" ];

      clock = {
        format = " {:%H:%M}";
        format-alt = " {:%a %b %d, %Y}";
        tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#71CEAD'><b>{}</b></span>";
            days = "<span color='#e6d8ba'><b>{}</b></span>";
            weeks = "<span color='#549E6A'><b>W{}</b></span>";
            weekdays = "<span color='#2DD5B7'><b>{}</b></span>";
            today = "<span color='#FF5345'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      tray = {
        icon-size = 12;
        spacing = 5;
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip-format-activated = "Idle inhibitor active";
        tooltip-format-deactivated = "Idle inhibitor inactive";
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          default = "";
          active = "";
        };
        on-click = "activate";
      };

      mpris = {
        format = "{player_icon} {dynamic}";
        format-paused = "{status_icon} <i>{dynamic}</i>";
        player-icons = {
          default = "🎵";
          spotify = "";
          firefox = "";
        };
        status-icons = {
          playing = "";
          paused = "";
        };
        dynamic-order = [ "title" "artist" ];
        dynamic-len = 40;
        ignored-players = [ ];
      };

      "hyprland/window" = {
        format = "{}";
        separate-outputs = true;
        max-length = 50;
        rewrite = {
          "(.*) — Mozilla Firefox" = "  $1";
          "(.*) - Chromium" = "  $1";
          "Spotify" = "  Spotify";
          "kitty" = "  Terminal";
        };
      };

      network = {
        format-wifi = " {signalStrength}%";
        format-ethernet = " {ipaddr}";
        format-disconnected = " Disconnected";
        tooltip-format = "{ifname} via {gwaddr}\n {bandwidthDownBytes}  {bandwidthUpBytes}";
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}\n {bandwidthDownBytes}  {bandwidthUpBytes}";
        tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}\n {bandwidthDownBytes}  {bandwidthUpBytes}";
        tooltip-format-disconnected = "Disconnected";
        on-click = "nm-connection-editor";
        interval = 2;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " {volume}%";
        format-icons = {
          default = [ "" "" "" ];
          headphone = "";
          headset = "";
        };
        on-click = "pavucontrol";
        on-click-right = "pavucontrol";
        scroll-step = 5;
        smooth-scrolling-threshold = 1;
      };

      memory = {
        format = " {}%";
        tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G ({percentage}%)\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
        on-click = "kitty -e btop";
        interval = 2;
      };

      cpu = {
        format = " {usage}%";
        tooltip = true;
        on-click = "kitty -e btop";
        interval = 2;
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        states = {
          warning = 20;
          critical = 10;
        };
        tooltip-format = "{timeTo}, {capacity}%";
      };

      "custom/notification" = {
        exec = "makoctl mode | grep -q 'do-not-disturb' && echo '' || echo ''";
        on-click = "makoctl mode -t do-not-disturb";
        interval = 1;
        tooltip = false;
      };

      "custom/power" = {
        format = "";
        on-click = "wlogout";
        tooltip = false;
      };
    }];

    style = ''
      * {
        font-family: "FiraCode Nerd Font", monospace;
        font-size: 12px;
        font-weight: bold;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: #e6d8ba;
        transition: background-color 0.5s;
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      /* General module styling - V2.7 approach */
      #clock,
      #tray,
      #idle_inhibitor,
      #workspaces,
      #mpris,
      #window,
      #network,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #custom-notification,
      #custom-power {
        background-color: rgba(17, 28, 24, 0.85);
        padding: 0px 8px;
        margin: 2px 1px;
        border-radius: 2px;
        box-shadow: rgba(0, 0, 0, 0.116) 2 2, rgba(0, 0, 0, 0.239) 1 1;
      }

      /* Hover effects */
      #clock:hover,
      #tray:hover,
      #idle_inhibitor:hover,
      #network:hover,
      #pulseaudio:hover,
      #memory:hover,
      #cpu:hover,
      #battery:hover,
      #custom-notification:hover,
      #custom-power:hover {
        background-color: #e6d8ba;
        color: #111C18;
        opacity: 0.9;
      }

      /* Workspaces */
      #workspaces {
        padding: 0px;
      }

      #workspaces button {
        padding: 0px 8px;
        background-color: transparent;
        color: #e6d8ba;
        border-radius: 2px;
      }

      #workspaces button:hover {
        background-color: #e6d8ba;
        color: #111C18;
      }

      #workspaces button.active {
        background-color: #e6d8ba;
        color: #111C18;
      }

      /* MPRIS with blink animation */
      #mpris.playing {
        animation-name: blink;
        animation-duration: 3s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #mpris.paused {
        opacity: 0.6;
      }

      /* Window title */
      #window {
        color: #C1C497;
      }

      /* Individual module colors */
      #clock {
        color: #e6d8ba;
      }

      #idle_inhibitor.activated {
        color: #71CEAD;
      }

      #network {
        color: #2DD5B7;
      }

      #network.disconnected {
        color: #FF5345;
      }

      #pulseaudio {
        color: #ACD4CF;
      }

      #pulseaudio.muted {
        opacity: 0.5;
      }

      #memory {
        color: #549E6A;
      }

      #cpu {
        color: #71CEAD;
      }

      #battery {
        color: #8CD3CB;
      }

      #battery.charging,
      #battery.plugged {
        color: #63b07a;
      }

      #battery.warning:not(.charging) {
        background-color: rgba(229, 199, 54, 0.85);
        color: #111C18;
      }

      #battery.critical:not(.charging) {
        background-color: rgba(255, 83, 69, 0.85);
        color: #111C18;
        animation: blink-critical 0.5s steps(12) infinite alternate;
      }

      #custom-notification {
        color: #D7C995;
      }

      #custom-power {
        color: #FF5345;
      }

      /* Animations */
      @keyframes blink {
        to {
          color: #71CEAD;
        }
      }

      @keyframes blink-critical {
        to {
          background-color: rgba(255, 83, 69, 0.5);
        }
      }

      /* Tooltip styling */
      tooltip {
        background: rgba(17, 28, 24, 1);
        border: 1px solid rgba(113, 206, 173, 0.3);
        border-radius: 4px;
        color: #e6d8ba;
      }

      tooltip label {
        color: #e6d8ba;
      }
    '';
  };
}

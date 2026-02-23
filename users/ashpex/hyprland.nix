# HyprPanel configuration for Hyprland
# Import this in your host's default.nix when using Hyprland
{ config, pkgs, ... }:

{
  home-manager.users.ashpex = {
    # Enable HyprPanel (temporarily disabled to test home-manager)
    # programs.hyprpanel = {
    #   enable = true;
    #
    #   # Optionally configure HyprPanel settings
    #   # See: https://hyprpanel.com/configuration/panel.html
    #   # settings = {
    #   #   bar.layouts = {
    #   #     "0" = {
    #   #       left = [ "dashboard" "workspaces" "windowtitle" ];
    #   #       middle = [ "media" ];
    #   #       right = [ "volume" "clock" "notifications" ];
    #   #     };
    #   #   };
    #   #   theme = {
    #   #     font = {
    #   #       name = "JetBrainsMono Nerd Font";
    #   #       size = "14px";
    #   #     };
    #   #   };
    #   # };
    # };

    # HyprPanel handles notifications, so other notification daemons should be disabled
    # services.dunst.enable = false;
    # services.mako.enable = false;
  };
}

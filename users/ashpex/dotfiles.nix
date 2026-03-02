# Declarative dotfiles management with Nix flakes

{ dotfiles, ... }:

{
  home-manager.users.ashpex = {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        size = 10000;
        save = 10000;
        share = true;
      };
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -lah";
        grep = "grep --color=auto";
      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "sudo" "dirhistory" ];
      };
    };

    home.file = {
      # Active configs (Niri + Noctalia Shell)
      ".config/kitty/kitty.conf" = {
        source = "${dotfiles}/.config/kitty/kitty.conf";
        force = true;
      };
      ".config/niri/config.kdl" = {
        source = "${dotfiles}/.config/niri/config.kdl";
        force = true;
      };
      ".config/nvim" = {
        source = "${dotfiles}/.config/nvim";
        force = true;
      };
      "wallpapers" = {
        source = "${dotfiles}/wallpapers";
        force = true;
      };

      # Hyprland configs 
      # ".config/hypr/hypridle.conf" = {
      #   source = "${dotfiles}/.config/hypr/hypridle.conf";
      #   force = true;
      # };
      # ".config/hypr/hyprland.conf" = {
      #   source = "${dotfiles}/.config/hypr/hyprland.conf";
      #   force = true;
      # };
      # ".config/hypr/hyprlock.conf" = {
      #   source = "${dotfiles}/.config/hypr/hyprlock.conf";
      #   force = true;
      # };
      # ".config/mako" = {
      #   source = "${dotfiles}/.config/mako";
      #   force = true;
      # };
      # ".config/rofi" = {
      #   source = "${dotfiles}/.config/rofi";
      #   force = true;
      # };
      # ".config/waybar" = {
      #   source = "${dotfiles}/.config/waybar";
      #   force = true;
      # };
      # ".config/wlogout" = {
      #   source = "${dotfiles}/.config/wlogout";
      #   force = true;
      # };

    };
  };
}

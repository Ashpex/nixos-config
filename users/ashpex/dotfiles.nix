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

    # Symlink individual files or directories from your dotfiles repo
    home.file = {
      ".config/hypr/hyprland.conf" = {
        source = "${dotfiles}/.config/hypr/hyprland.conf";
        force = true;
      };
      ".config/hypr/hyprlock.conf" = {
        source = "${dotfiles}/.config/hypr/hyprlock.conf";
        force = true;
      };
      ".config/hypr/hypridle.conf" = {
        source = "${dotfiles}/.config/hypr/hypridle.conf";
        force = true;
      };
      ".config/kitty/kitty.conf" = {
        source = "${dotfiles}/.config/kitty/kitty.conf";
        force = true;
      };
      ".config/nvim" = {
        source = "${dotfiles}/.config/nvim";
        force = true;
      };
      ".config/rofi" = {
        source = "${dotfiles}/.config/rofi";
        force = true;
      };
      ".config/wlogout" = {
        source = "${dotfiles}/.config/wlogout";
        force = true;
      };
      ".config/mako" = {
        source = "${dotfiles}/.config/mako";
        force = true;
      };
      ".config/waybar" = {
        source = "${dotfiles}/.config/waybar";
        force = true;
      };
      ".config/niri/config.kdl" = {
        source = "${dotfiles}/.config/niri/config.kdl";
        force = true;
      };
      "wallpapers" = {
        source = "${dotfiles}/wallpapers";
        force = true;
      };

    };
  };
}

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
      initExtra = ''
        export PATH="$HOME/.cargo/bin:$PATH"
        export PATH="$HOME/go/bin:$PATH"
      '';
    };

    home.file = {
      ".config/kitty/kitty.conf" = {
        source = "${dotfiles}/.config/kitty/kitty.conf";
        force = true;
      };
      ".config/niri/config.kdl" = {
        source = "${dotfiles}/.config/niri/config.kdl";
        force = true;
      };
      # nvim is now self-managed in ~/.config/nvim (not controlled by home-manager)
    };
  };
}

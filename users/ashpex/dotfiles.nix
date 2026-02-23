# Declarative dotfiles management with Nix flakes
#
# Your dotfiles repo is a flake input, version-locked in flake.lock
# To update dotfiles: `make update` then `make`

{ dotfiles, ... }:

{
  home-manager.users.ashpex = {
    # Symlink individual files or directories from your dotfiles repo
    home.file = {
      ".config/kitty/kitty.conf".source = "${dotfiles}/.config/kitty/kitty.conf";
      ".config/nvim".source = "${dotfiles}/.config/nvim";
      ".zshrc".source = "${dotfiles}/.config/zsh/.zshrc";

      # Add more dotfiles as needed:
      # ".config/hypr".source = "${dotfiles}/.config/hypr";
      # ".gitconfig".source = "${dotfiles}/.gitconfig";
    };
  };
}

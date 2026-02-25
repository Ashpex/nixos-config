# Declarative dotfiles management with Nix flakes
#
# Your dotfiles repo is a flake input, version-locked in flake.lock
# To update dotfiles: `make update` then `make`

{ dotfiles, ... }:

{
  home-manager.users.ashpex = {
    # Symlink individual files or directories from your dotfiles repo
    home.file = {
      ".zshrc" = {
        source = "${dotfiles}/.config/zsh/.zshrc";
        force = true;  # Overwrite existing files
      };
      ".config/hypr/hyprland.conf" = {
        source = "${dotfiles}/.config/hypr/hyprland.conf";
        force = true;
      };
      ".config/hypr/hyprlock.conf" = {
        source = "${dotfiles}/.config/hypr/hyprlock.conf";
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

      # Add more dotfiles as needed:
      # ".gitconfig".source = "${dotfiles}/.gitconfig";
    };
  };
}

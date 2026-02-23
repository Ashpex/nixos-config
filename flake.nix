{
  description = "NixOS configuration with flakes and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dotfiles repository
    # TODO: Change this to your GitHub dotfiles repo URL
    # For local testing: url = "path:/home/ashpex/dotfiles";
    # To test without dotfiles: Comment out this input and the import in baseModules
    # dotfiles = {
    #   url = "github:yourusername/dotfiles";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, nixos-hardware, home-manager }:
  let
    baseModules = [
      disko.nixosModules.disko
      ./configuration.nix
      home-manager.nixosModules.home-manager
      ./users/ashpex
      # (import ./users/ashpex/dotfiles.nix { inherit dotfiles; })  # Temporarily commented for testing
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (prev.stdenv.hostPlatform) system;
              config = prev.config;
            };
          })
        ];
      }
    ];
  in {
    nixosConfigurations = {
      # ThinkPad T480 with KDE Plasma
      t480 = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ./desktop/kde.nix
          ./hosts/t480
        ];
      };

      # Example: Another host with Hyprland
      # desktop = nixpkgs.lib.nixosSystem {
      #   modules = baseModules ++ [
      #     ./desktop/hyprland.nix
      #     ./users/ashpex/hyprland.nix  # HyprPanel config
      #     ./hosts/desktop
      #   ];
      # };

      # Example: Server (no desktop environment)
      # server = nixpkgs.lib.nixosSystem {
      #   modules = baseModules ++ [
      #     ./hosts/server
      #   ];
      # };
    };
  };
}

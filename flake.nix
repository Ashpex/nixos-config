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
    dotfiles = {
      url = "github:Ashpex/nixos-dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, nixos-hardware, home-manager, dotfiles }:
  let
    baseModules = [
      disko.nixosModules.disko
      ./configuration.nix
      home-manager.nixosModules.home-manager
      ./users/ashpex
      (import ./users/ashpex/dotfiles.nix { inherit dotfiles; })
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
      # ThinkPad T480 with Hyprland
      t480 = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ./de/hyprland.nix
          ./hosts/t480
        ];
      };

      # Desktop with Cinnamon (i5-13600KF + RX 6700 XT)
      desktop = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-amd
          ./de/cinnamon.nix
          ./hosts/desktop
        ];
      };

      # Server (no desktop environment)
      server = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          ./hosts/server
        ];
      };
    };
  };
}

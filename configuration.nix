# Common configuration shared across all hosts
{ config, pkgs, ... }:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
            };
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    enableAllHardware = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall.checkReversePath = "loose";
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # Set time zone
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Common system packages
  environment.systemPackages = with pkgs; [
    curl
    gh
    gnumake
    kitty
    neovim
    tree
    unzip
    wget
  ];

  # Common programs
  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;
  };

  # Common services
  services = {
    dbus.enable = true;
    printing.enable = true;
    tailscale.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Enable Docker (but don't start on boot)
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune = {
      enable = true;
      flags = [ "--all" "--volumes" ];
    };
  };

  # This value determines the NixOS release
  system.stateVersion = "25.11";

  # VM testing variant
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
      "-serial stdio"  # Show boot messages in terminal
    ];
    users.users.ashpex.password = "testvm";
    users.users.root.password = "root";
    # Show boot messages
    boot.kernelParams = [ "boot.shell_on_fail" ];
  };
}

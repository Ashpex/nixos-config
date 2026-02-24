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
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  hardware = {
    enableAllHardware = true;
  };

  networking = {
    networkmanager = {
      enable = true;
    };
    firewall = {
      checkReversePath = "loose";
    };
  };

  systemd = {
    services = {
      NetworkManager-wait-online = {
        enable = false;
      };
    };
  };

  # Set time zone
  time = {
    timeZone = "Asia/Ho_Chi_Minh";
  };

  # Internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "vi_VN";
      LC_NUMERIC = "vi_VN";
      LC_TIME = "vi_VN";
    };
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Common system packages
  environment = {
    systemPackages = with pkgs; [
      curl
      fastfetch
      file
      gh
      gnumake
      htop
      kitty
      neovim
      tree
      unzip
      wget
    ];
  };

  # Common programs
  programs = {
    firefox = {
      enable = true;
    };
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  # Common services
  services = {
    dbus = {
      enable = true;
    };
    printing = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
  };

  security = {
    polkit = {
      enable = true;
    };
    rtkit = {
      enable = true;
    };
  };

  # This value determines the NixOS release
  system = {
    stateVersion = "25.11";
  };

  # Enable Docker (but don't start on boot) and VM testing variant
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        flags = [ "--all" "--volumes" ];
      };
    };

    # VM testing variant
    vmVariant = {
      virtualisation = {
        qemu = {
          options = [
            "-device virtio-vga-gl"
            "-display gtk,gl=on"
          ];
        };
      };
    };
  };
}

# Common configuration shared across all hosts
{ config, pkgs, ... }:

{
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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
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

  environment = {
    systemPackages = with pkgs; [
      curl
      fastfetch
      file
      gh
      gnumake
      btop
      kitty
      tree
      unzip
      wget
    ];
  };

  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisablePocket = true;
      };
    };
    git = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    zsh = {
      enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
    printing = {
      enable = true;
    };
    tailscale = {
      enable = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      fira
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
    ];
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
            "-vga virtio"
            "-display gtk"
          ];
        };
      };
    };
  };
}

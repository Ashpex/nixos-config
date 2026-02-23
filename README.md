# NixOS Configuration

My NixOS configuration using flakes, home-manager, disko, and nixos-hardware.

## Structure

```
nixos-config/
├── flake.nix                    # Flake with baseModules pattern
├── flake.lock                   # Locked flake inputs
├── configuration.nix            # Base configuration for all hosts
├── Makefile                     # Convenient commands
├── desktop/                     # Desktop environment configs
│   ├── kde.nix                  # KDE Plasma
│   └── hyprland.nix             # Hyprland
├── hosts/                       # Host-specific configurations
│   └── t480/                    # ThinkPad T480
│       ├── default.nix          # Host-specific settings
│       └── hardware-configuration.nix
└── users/                       # User configurations
    └── ashpex/                  # User ashpex
        └── default.nix          # User + home-manager config
```

## Usage

### Apply Changes (with Latest Dotfiles)

After editing configuration or dotfiles:

```bash
make
# or
make apply
```

This automatically:
1. Updates dotfiles to latest commit from GitHub
2. Rebuilds your system

### Build Without Updating Dotfiles

To rebuild with the locked dotfiles version (reproducible):

```bash
make build
# or
make build-no-update
```

### Test Configuration in VM

Test changes without applying to your system:

```bash
make test
```

### Other Commands

```bash
make update-dotfiles   # Update only dotfiles (doesn't rebuild)
make update            # Update all flake inputs (nixpkgs, home-manager, dotfiles, etc.)
make diff              # Show what will change
make test              # Test in VM before applying
make clean             # Run garbage collection
```

### Initial Installation (from NixOS Live CD)

1. Boot from NixOS live CD
2. Clone this repository and install:

```bash
nix-shell -p git gnumake neovim disko
git clone <your-repo-url> nixos-config
cd nixos-config
make install host=t480 disk=/dev/nvme0n1
```

### Adding a New Machine

1. Create host directory and generate hardware config:
```bash
mkdir -p hosts/newmachine
sudo nixos-generate-config --show-hardware-config > hosts/newmachine/hardware-configuration.nix
```

2. Create `hosts/newmachine/default.nix` (use `hosts/t480/default.nix` as template):
```nix
{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "newmachine";

  # Add machine-specific configuration here
}
```

3. Add to `flake.nix` under `nixosConfigurations`:
```nix
newmachine = nixpkgs.lib.nixosSystem {
  modules = baseModules ++ [
    ./desktop/kde.nix  # if it's a desktop/laptop
    ./hosts/newmachine
  ];
};
```

4. Build:
```bash
make build host=newmachine
```

## Dotfiles Management

Dotfiles are managed declaratively via a separate repository as a flake input.

### Setup

1. Push your dotfiles to GitHub
2. Update `flake.nix` with your repo URL:
```nix
dotfiles.url = "github:yourusername/dotfiles";
```
3. Run `make` to apply

### Daily Workflow

```bash
# Edit dotfiles locally
cd ~/dotfiles
vim .zshrc
git commit -am "Update config"
git push

# Apply (auto-updates + rebuilds)
cd ~/nixos-config
make  # Automatically pulls latest dotfiles!
```

### Adding Dotfiles

Edit `users/ashpex/dotfiles.nix`:
```nix
home.file = {
  ".config/kitty/kitty.conf".source = "${dotfiles}/.config/kitty/kitty.conf";
  ".config/nvim".source = "${dotfiles}/.config/nvim";
  ".zshrc".source = "${dotfiles}/.config/zsh/.zshrc";
  # Add more here
};
```

### Testing Without Dotfiles

To test system config without dotfiles, comment out in `flake.nix`:

```nix
# Dotfiles repository (optional for testing)
# dotfiles = {
#   url = "github:yourusername/dotfiles";
#   flake = false;
# };
```

And comment out in baseModules:
```nix
baseModules = [
  # ...
  # (import ./users/ashpex/dotfiles.nix { inherit dotfiles; })  # Comment this
  # ...
];
```

### Local Dotfiles for Testing

Before pushing to GitHub:
```nix
# In flake.nix:
dotfiles.url = "path:/home/ashpex/dotfiles";
```

## Configuration Layers

This config uses a layered approach (inspired by [khuedoan/nixos-setup](https://github.com/khuedoan/nixos-setup)):

1. **Base modules** (applied to all hosts):
   - `configuration.nix` - Core system configuration
   - `users/ashpex/` - User and home-manager configuration
   - Disko module for declarative disk management
   - Unstable package overlay

2. **Optional desktop environment modules** (pick one per host):
   - `desktop/kde.nix` - KDE Plasma desktop environment
   - `desktop/hyprland.nix` - Hyprland window manager
   - (You can create more: `desktop/gnome.nix`, `desktop/sway.nix`, etc.)

3. **Host-specific**:
   - `hosts/<hostname>/` - Machine-specific settings

### Example: Different Desktop Environments

```nix
# In flake.nix:

# KDE Plasma host
t480 = nixpkgs.lib.nixosSystem {
  modules = baseModules ++ [
    ./desktop/kde.nix
    ./hosts/t480
  ];
};

# Hyprland host with HyprPanel
desktop = nixpkgs.lib.nixosSystem {
  modules = baseModules ++ [
    ./desktop/hyprland.nix
    ./users/ashpex/hyprland.nix  # HyprPanel configuration
    ./hosts/desktop
  ];
};

# Headless server
server = nixpkgs.lib.nixosSystem {
  modules = baseModules ++ [
    ./hosts/server
  ];
};
```

## Features

- **Flakes**: Reproducible builds with locked dependencies
- **Home Manager**: Declarative user configuration
- **Dotfiles**: Separate repo, auto-updates on `make`
- **Disko**: Declarative disk partitioning for automated installs
- **nixos-hardware**: Community hardware profiles (ThinkPad T480)
- **Unstable overlay**: Access unstable packages via `pkgs.unstable.*`
- **Automated maintenance**: Weekly garbage collection (7 days) and store optimization
- **VM testing**: Test configurations before applying
- **Docker**: Enabled with auto-pruning (doesn't start on boot)
- **Auto-updating Makefile**: `make` auto-updates dotfiles to latest commit

## Current Machines

- **t480**: ThinkPad T480 laptop

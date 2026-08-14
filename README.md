# NixOS Configuration

My NixOS configuration using flakes, home-manager, disko, and nixos-hardware.

## Structure

```
nixos-config/
├── flake.nix             # Flake inputs & host definitions
├── configuration.nix     # Base config applied to all hosts
├── gui.nix               # GUI config (graphical hosts only)
├── de/                   # Desktop environment modules
│   ├── cinnamon.nix
│   └── niri.nix
├── hosts/                # Host-specific configs
│   ├── t480/
│   └── desktop/
├── users/ashpex/         # User + home-manager config
└── scripts/              # Workflow scripts
```

## Commands

```bash
# System
make              # Rebuild system (default)
make update       # Update all flake inputs
make diff         # Show closure diff before applying
make test         # Build and run VM for testing
make install host=<host> disk=<disk>  # Fresh install via disko
make clean        # Garbage collect

# Dotfiles
make dotfiles-update                              # Update dotfiles flake input
make dotfiles-detach file=~/.config/niri/config.kdl   # Detach symlink for quick editing
make dotfiles-restore file=~/.config/niri/config.kdl  # Copy edited file back to dotfiles repo
```

All commands accept `host=<name>` (default: `desktop`).

## Hosts

| Host      | Hardware                     | DE        |
|-----------|------------------------------|-----------|
| t480      | ThinkPad T480                | Cinnamon  |
| desktop   | i5-13600KF + RX 6700 XT      | Niri      |

## Install

```bash
nix-shell -p git gnumake disko
git clone https://github.com/Ashpex/nixos-config
cd nixos-config
make install host=desktop disk=/dev/nvme0n1
```

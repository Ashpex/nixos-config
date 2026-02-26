# NixOS Configuration

My NixOS configuration using flakes, home-manager, disko, and nixos-hardware.

## Structure

```
nixos-config/
├── flake.nix             # Flake inputs & host definitions
├── configuration.nix     # Base config applied to all hosts
├── de/                   # Desktop environment modules
│   ├── cinnamon.nix
│   └── hyprland.nix
├── hosts/                # Host-specific configs
│   ├── t480/
│   ├── desktop/
│   └── server/
└── users/ashpex/         # User + home-manager config
```

## Commands

```bash
make              # Update dotfiles + rebuild (default)
make apply        # Same as above
make build        # Rebuild without updating dotfiles
make test         # Build and run VM for testing
make diff         # Show closure diff before applying
make update       # Update all flake inputs
make update-dotfiles  # Update only dotfiles input
make install host=<host> disk=<disk>  # Fresh install via disko
make clean        # Garbage collect
```

All commands accept `host=<name>` (default: `t480`).

## Hosts

| Host      | Hardware                     | DE        |
|-----------|------------------------------|-----------|
| t480      | ThinkPad T480                | Cinnamon  |
| desktop   | i5-13600KF + RX 6700 XT      | Hyprland  |
| server    | —                            | headless  |

## Install

```bash
nix-shell -p git gnumake disko
git clone https://github.com/Ashpex/nixos-config
cd nixos-config
make install host=t480 disk=/dev/nvme0n1
```

# AstroNvim v5 Config for NixOS

## Summary

Replace hand-rolled lazy.nvim nvim config in `nixos-dotfiles/.config/nvim/` with AstroNvim v5 template. Languages: Go, Rust, Nix. Theme: Catppuccin Mocha green accent. Mason disabled (NixOS). Format-on-save and DAP enabled via AstroCommunity packs.

## File Structure

```
.config/nvim/
├── init.lua                    # Bootstrap lazy.nvim
├── lua/
│   ├── lazy_setup.lua          # lazy.nvim setup (loads AstroNvim + plugins)
│   ├── community.lua           # AstroCommunity imports (go, rust, nix, lua, catppuccin)
│   ├── polish.lua              # Final customizations
│   └── plugins/
│       ├── astrocore.lua       # Core options, features
│       ├── astrolsp.lua        # LSP config, format-on-save
│       ├── astroui.lua         # Catppuccin Mocha, green accent, transparent bg
│       ├── mason.lua           # Disabled (NixOS uses system packages)
│       ├── none-ls.lua         # Formatters: gofumpt, rustfmt, nixpkgs-fmt
│       ├── treesitter.lua      # Parser ensure_installed
│       └── user.lua            # toggleterm, extra plugins
```

## Key Decisions

- Theme: Catppuccin Mocha, green accent, transparent background
- LSP: gopls/rust-analyzer/nil installed via Nix in users/ashpex/. Mason disabled.
- Format on save: enabled via AstroLSP
- DAP: via AstroCommunity packs (delve for Go, codelldb for Rust)
- Completion: blink.cmp (v5 default)
- Fuzzy finder: snacks.nvim picker (v5 default)
- File explorer: neo-tree (AstroNvim default)
- Keybindings: AstroNvim defaults
- Treesitter: managed by AstroNvim (compiles from source, works on NixOS)

## AstroCommunity Imports

```lua
{ import = "astrocommunity.pack.go" }
{ import = "astrocommunity.pack.rust" }
{ import = "astrocommunity.pack.nix" }
{ import = "astrocommunity.pack.lua" }
{ import = "astrocommunity.colorscheme.catppuccin" }
```

.POSIX:
.PHONY: default apply build build-no-update test diff update update-dotfiles install clean dotfiles-dev dotfiles-prod dotfiles-push dotfiles-sync dotfiles-test

# Default host is t480
host ?= t480

# Default: auto-update dotfiles then rebuild (best of both worlds!)
default: apply

# Apply: Update dotfiles to latest commit, then rebuild
# This is the main command you'll use daily
apply:
	@echo "Updating dotfiles to latest commit..."
	nix --extra-experimental-features 'nix-command flakes' flake lock --update-input dotfiles
	@echo "Rebuilding with latest dotfiles..."
	sudo nixos-rebuild \
		--flake '.#${host}' \
		switch

# Build: Rebuild without updating dotfiles (uses locked version)
# Use this when you want reproducibility or don't want to pull latest
build:
	sudo nixos-rebuild \
		--flake '.#${host}' \
		switch

# Alias for clarity
build-no-update: build

# Update dotfiles only (doesn't rebuild)
update-dotfiles:
	@echo "Updating dotfiles input to latest commit..."
	nix --extra-experimental-features 'nix-command flakes' flake lock --update-input dotfiles
	@echo "Updated! Run 'make build' to apply changes."

# Dotfiles development workflow
# Managed by scripts/dotfiles.sh

dotfiles-dev:
	@./scripts/dotfiles.sh dev

dotfiles-prod:
	@./scripts/dotfiles.sh prod

dotfiles-push:
	@./scripts/dotfiles.sh push

dotfiles-sync:
	@./scripts/dotfiles.sh sync

dotfiles-test:
	@./scripts/dotfiles.sh test

test:
	nixos-rebuild \
		--flake '.#${host}' \
		build-vm
	./result/bin/run-nixos-vm

diff:
	nixos-rebuild \
		--flake '.#${host}' \
		build
	nix --extra-experimental-features 'nix-command' store diff-closures \
		--allow-symlinked-store \
		/nix/var/nix/profiles/system ./result

# Update all flake inputs (nixpkgs, home-manager, dotfiles, etc.)
update:
	nix --extra-experimental-features 'nix-command flakes' flake update

install:
	# This consumes significant memory on the live USB because dependencies are
	# downloaded to tmpfs. The configuration must be small, or the machine must
	# have a lot of RAM.
	sudo disko-install \
		--write-efi-boot-entries \
		--flake '.#${host}' \
		--disk main '${disk}'

clean:
	rm -f result result-*
	nix-collect-garbage --delete-old --log-format bar

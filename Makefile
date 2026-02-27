.POSIX:
.PHONY: default build update dotfiles-update diff test install clean dotfiles-detach dotfiles-restore

# Default host is t480
host ?= t480

default: build

# System
build:
	sudo nixos-rebuild \
		--flake '.#$(host)' \
		switch

update:
	nix --extra-experimental-features 'nix-command flakes' flake update

diff:
	nixos-rebuild \
		--flake '.#$(host)' \
		build
	nix --extra-experimental-features 'nix-command' store diff-closures \
		--allow-symlinked-store \
		/nix/var/nix/profiles/system ./result

test: dotfiles-update
	nixos-rebuild \
		--flake '.#$(host)' \
		build-vm
	./result/bin/run-*-vm

install:
	sudo disko-install \
		--write-efi-boot-entries \
		--flake '.#$(host)' \
		--disk main '${disk}'

clean:
	rm -f result result-*
	nix-collect-garbage --delete-old --log-format bar

# Dotfiles
dotfiles-update:
	@echo "Updating dotfiles input to latest commit..."
	nix --extra-experimental-features 'nix-command flakes' flake lock --update-input dotfiles
	@echo "Updated!"

dotfiles-detach:
	@./scripts/dotfiles.sh detach $(file)

dotfiles-restore:
	@./scripts/dotfiles.sh restore $(file)

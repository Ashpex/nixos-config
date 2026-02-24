#!/usr/bin/env bash
set -e

# Dotfiles workflow automation script
# Usage: ./scripts/dotfiles.sh [dev|prod|push|sync]

DOTFILES_REPO="https://github.com/Ashpex/nixos-dotfiles"
LOCAL_DOTFILES="$HOME/nixos-dotfiles"
FLAKE_FILE="flake.nix"
GITHUB_URL='url = "github:Ashpex/nixos-dotfiles"'
LOCAL_URL='url = "path:/home/ashpex/nixos-dotfiles"'

case "$1" in
  dev)
    echo "Switching to local dotfiles for development..."

    # Clone repo if it doesn't exist
    if [ ! -d "$LOCAL_DOTFILES" ]; then
      echo "Cloning dotfiles repo to $LOCAL_DOTFILES..."
      git clone "$DOTFILES_REPO" "$LOCAL_DOTFILES"
    fi

    # Switch to local path in flake.nix
    sed -i "s|$GITHUB_URL|$LOCAL_URL|" "$FLAKE_FILE"

    echo "✓ Local dotfiles enabled"
    echo "  Edit files in: $LOCAL_DOTFILES"
    echo "  Test changes with: make build"
    ;;

  prod)
    echo "Switching back to GitHub dotfiles..."

    # Switch to GitHub URL in flake.nix
    sed -i "s|$LOCAL_URL|$GITHUB_URL|" "$FLAKE_FILE"

    echo "✓ GitHub dotfiles enabled"
    echo "  Running make apply..."
    make apply
    ;;

  push)
    echo "Pushing dotfiles to GitHub..."

    # Check if local dotfiles exists and is a git repo
    if [ ! -d "$LOCAL_DOTFILES/.git" ]; then
      echo "Error: $LOCAL_DOTFILES is not a git repository"
      echo "Run 'make dotfiles-dev' first"
      exit 1
    fi

    # Commit and push
    cd "$LOCAL_DOTFILES"
    git add .

    # Allow empty commits in case nothing changed
    if git diff --staged --quiet; then
      echo "No changes to commit"
    else
      git commit -m "Update dotfiles"
      git push
      echo "✓ Dotfiles pushed to GitHub"
    fi

    cd - > /dev/null

    # Switch to production mode
    echo "Switching to production mode..."
    "$0" prod
    ;;

  sync)
    echo "Syncing local dotfiles with GitHub..."

    if [ ! -d "$LOCAL_DOTFILES" ]; then
      echo "Error: $LOCAL_DOTFILES doesn't exist"
      echo "Run 'make dotfiles-dev' first"
      exit 1
    fi

    cd "$LOCAL_DOTFILES"
    git pull
    echo "✓ Local dotfiles synced with GitHub"
    ;;

  test)
    echo "Quick test: copying dotfiles to ~/.config (no rebuild)..."

    if [ ! -d "$LOCAL_DOTFILES" ]; then
      echo "Error: $LOCAL_DOTFILES doesn't exist"
      echo "Run 'make dotfiles-dev' first"
      exit 1
    fi

    # Copy files directly for instant testing
    rsync -av --delete "$LOCAL_DOTFILES/.config/" "$HOME/.config/"
    echo "✓ Dotfiles copied to ~/.config"
    echo "  Changes are live! Run 'make build' when done to make permanent."
    ;;

  *)
    echo "Usage: $0 {dev|prod|push|sync|test}"
    echo ""
    echo "Commands:"
    echo "  dev   - Switch to local dotfiles for development"
    echo "  prod  - Switch back to GitHub dotfiles (production)"
    echo "  push  - Commit, push to GitHub, and switch to production"
    echo "  sync  - Pull latest from GitHub to local folder"
    echo "  test  - Quick copy to ~/.config for instant testing (no rebuild)"
    exit 1
    ;;
esac

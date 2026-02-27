#!/usr/bin/env bash
set -e

# Dotfiles workflow automation script
# Usage: ./scripts/dotfiles.sh {detach|restore} <path>

LOCAL_DOTFILES="$HOME/nixos-dotfiles"

case "$1" in
  detach)
    FILE="$2"
    if [ -z "$FILE" ]; then
      echo "Usage: $0 detach <path>"
      echo "Example: $0 detach ~/.config/hypr/hyprland.conf"
      exit 1
    fi

    # Expand ~ if used
    FILE="${FILE/#\~/$HOME}"

    if [ ! -L "$FILE" ]; then
      echo "Error: $FILE is not a symlink (already detached?)"
      exit 1
    fi

    REAL_PATH="$(readlink -f "$FILE")"
    cp --remove-destination "$REAL_PATH" "$FILE"
    echo "✓ Detached: $FILE"
    echo "  Edit freely. When done: $0 restore $2"
    ;;

  restore)
    FILE="$2"
    if [ -z "$FILE" ]; then
      echo "Usage: $0 restore <path>"
      echo "Example: $0 restore ~/.config/hypr/hyprland.conf"
      exit 1
    fi

    # Expand ~ if used
    FILE="${FILE/#\~/$HOME}"

    if [ -L "$FILE" ]; then
      echo "Error: $FILE is a symlink (not detached)"
      exit 1
    fi

    if [ ! -f "$FILE" ]; then
      echo "Error: $FILE does not exist"
      exit 1
    fi

    # Derive relative path under ~/.config or ~/
    REL_PATH="${FILE#$HOME/}"
    DEST="$LOCAL_DOTFILES/$REL_PATH"

    if [ ! -d "$LOCAL_DOTFILES" ]; then
      echo "Error: $LOCAL_DOTFILES doesn't exist"
      echo "Clone the dotfiles repo to $LOCAL_DOTFILES first"
      exit 1
    fi

    mkdir -p "$(dirname "$DEST")"
    cp "$FILE" "$DEST"
    echo "✓ Copied to: $DEST"
    echo "  Commit in $LOCAL_DOTFILES, then 'make apply' to restore symlink."
    ;;

  *)
    echo "Usage: $0 {detach|restore}"
    echo ""
    echo "Commands:"
    echo "  detach <path>  - Replace symlink with editable copy for quick tweaking"
    echo "  restore <path> - Copy edited file back to dotfiles repo"
    exit 1
    ;;
esac

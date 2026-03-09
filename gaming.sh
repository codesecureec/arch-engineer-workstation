#!/usr/bin/env bash
set -euo pipefail

GAMING_PACKAGES=(
  steam
  gamemode
  mangohud
)

printf '[+] Installing gaming packages...\n'
sudo pacman -S --needed --noconfirm "${GAMING_PACKAGES[@]}"

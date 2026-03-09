#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  hyprland
  waybar
  rofi
  kitty
  dunst
  grim
  slurp
  swappy
  git
  neovim
  tmux
  zsh
  starship
  btop
  fastfetch
  fzf
  ripgrep
  fd
  bat
  thunar
  networkmanager
  blueman
  ttf-jetbrains-mono
  noto-fonts
  noto-fonts-emoji
  pipewire
  pipewire-alsa
  pipewire-pulse
  wireplumber
  mesa
  vulkan-radeon
  lib32-mesa
  lib32-vulkan-radeon
)

printf '[+] Installing base workstation packages...\n'
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

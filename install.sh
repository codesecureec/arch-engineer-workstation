#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

log() {
  printf '\n[+] %s\n' "$1"
}

warn() {
  printf '[!] %s\n' "$1"
}

fail() {
  printf '[x] %s\n' "$1" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local backup_path="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup_path"
    warn "Backed up $target -> $backup_path"
  fi
}

install_config_file() {
  local source="$1"
  local destination="$2"

  mkdir -p "$(dirname "$destination")"
  backup_if_exists "$destination"
  install -m 644 "$source" "$destination"
}

main() {
  [[ "${EUID}" -eq 0 ]] && fail "Run this installer as a regular user, not root."

  require_command pacman
  require_command sudo
  require_command systemctl
  require_command bash

  log "Validating sudo access"
  sudo -v

  log "Updating system"
  sudo pacman -Syu --noconfirm

  log "Installing required packages"
  bash "$REPO_ROOT/packages.sh"

  log "Installing gaming components"
  bash "$REPO_ROOT/gaming.sh"

  log "Enabling required services"
  bash "$REPO_ROOT/scripts/enable-services.sh"

  log "Preparing config directories"
  mkdir -p "$HOME/.config/hypr"
  mkdir -p "$HOME/.config/waybar"
  mkdir -p "$HOME/.config/kitty"
  mkdir -p "$HOME/.config/rofi"

  log "Deploying dotfiles with backup"
  install_config_file "$REPO_ROOT/configs/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
  install_config_file "$REPO_ROOT/configs/waybar/config" "$HOME/.config/waybar/config"
  install_config_file "$REPO_ROOT/configs/waybar/style.css" "$HOME/.config/waybar/style.css"
  install_config_file "$REPO_ROOT/configs/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  install_config_file "$REPO_ROOT/configs/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
  install_config_file "$REPO_ROOT/configs/starship/starship.toml" "$HOME/.config/starship.toml"
  install_config_file "$REPO_ROOT/configs/zsh/.zshrc" "$HOME/.zshrc"

  log "Running post-install tasks"
  bash "$REPO_ROOT/scripts/post-install.sh"

  log "Workstation setup completed successfully"
  printf '\nNext step: reboot and log in to a Hyprland session.\n'
}

main "$@"

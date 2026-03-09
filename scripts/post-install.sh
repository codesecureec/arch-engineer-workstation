#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[+] %s\n' "$1"
}

current_shell="$(getent passwd "$USER" | cut -d: -f7)"
zsh_path="$(command -v zsh)"

if [[ -z "$zsh_path" ]]; then
  printf '[x] zsh is not installed.\n' >&2
  exit 1
fi

if [[ "$current_shell" != "$zsh_path" ]]; then
  log "Setting zsh as default shell for $USER"
  chsh -s "$zsh_path" "$USER"
else
  log "Default shell is already zsh"
fi

log "Post-install tasks finished"

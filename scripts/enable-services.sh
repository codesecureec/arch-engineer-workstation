#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[+] %s\n' "$1"
}

warn() {
  printf '[!] %s\n' "$1"
}

log "Enabling NetworkManager service"
sudo systemctl enable --now NetworkManager.service

log "Enabling PipeWire user services for future sessions"
sudo systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service

if [[ -n "${XDG_RUNTIME_DIR:-}" && -S "${XDG_RUNTIME_DIR}/bus" ]]; then
  log "Starting PipeWire user services for current session"
  systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service
else
  warn "No user systemd bus detected; PipeWire services will start at next login."
fi

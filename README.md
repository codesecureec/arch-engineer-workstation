# Arch Hyprland Workstation

Minimal, reproducible, post-install automation for an Arch Linux workstation using Hyprland on AMD Ryzen APU hardware.

## Hardware Target

- CPU: AMD Ryzen 5 3400G
- GPU: Radeon Vega (integrated)
- RAM: 8GB
- Base OS: Arch Linux minimal install (already completed)

## Installation

```bash
git clone https://github.com/codesecureec/arch-hyprland-workstation
cd arch-hyprland-workstation
chmod +x install.sh
./install.sh
```

## Screenshots

Screenshot placeholder:

- `docs/screenshots/hyprland-desktop.png`

## Architecture

The repository is split into focused scripts:

- `install.sh`: main entrypoint, orchestration, config backup/copy, post-install tasks.
- `packages.sh`: installs core workstation packages (Hyprland, developer tools, networking, fonts, audio, AMD drivers).
- `gaming.sh`: installs Steam and lightweight gaming utilities.
- `scripts/enable-services.sh`: enables NetworkManager and PipeWire-related services.
- `scripts/post-install.sh`: applies shell defaults and final sanity checks.
- `configs/`: clean dotfiles copied into `~/.config` (and `~/.zshrc`).

## Installed Components

### Hyprland ecosystem

- hyprland
- waybar
- rofi
- kitty
- dunst
- grim
- slurp
- swappy

### Developer tools

- git
- neovim
- tmux
- zsh
- starship
- btop
- fastfetch
- fzf
- ripgrep
- fd
- bat

### File manager

- thunar

### Networking

- networkmanager
- blueman

### Fonts

- ttf-jetbrains-mono
- noto-fonts
- noto-fonts-emoji

### Audio

- pipewire
- pipewire-alsa
- pipewire-pulse
- wireplumber

### AMD graphics stack

- mesa
- vulkan-radeon
- lib32-mesa
- lib32-vulkan-radeon

### Gaming

- steam
- gamemode
- mangohud

## Repository Layout

```text
arch-hyprland-workstation/
├── README.md
├── install.sh
├── packages.sh
├── gaming.sh
├── configs/
│   ├── hypr/
│   │   └── hyprland.conf
│   ├── waybar/
│   │   ├── config
│   │   └── style.css
│   ├── kitty/
│   │   └── kitty.conf
│   ├── rofi/
│   │   └── config.rasi
│   ├── zsh/
│   │   └── .zshrc
│   └── starship/
│       └── starship.toml
└── scripts/
    ├── enable-services.sh
    └── post-install.sh
```

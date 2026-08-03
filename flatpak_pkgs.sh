#!/bin/bash

set -euo pipefail

echo "正在安裝 Flatpak 軟體包..."

FLATPAK_PKGS=(
    com.discordapp.Discord
)

if ! command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak 未安裝，先透過 pacman 安裝..."
    pacman -S --needed --noconfirm flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub "${FLATPAK_PKGS[@]}"
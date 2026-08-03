#!/bin/bash

set -euo pipefail

echo "正在安裝 AUR 軟體包..."

if ! command -v yay >/dev/null 2>&1; then
    echo "yay 未安裝，請先在目標系統中安裝 yay 後再執行。"
    exit 1
fi

AUR_PKGS=(
    google-chrome visual-studio-code-bin uxplay rustdesk-bin zen-browser-bin fcitx5-mcbopomofo-git vmware-workstation
)

yay -Syu --noconfirm --needed "${AUR_PKGS[@]}"
echo "AUR 軟體包安裝完成。"
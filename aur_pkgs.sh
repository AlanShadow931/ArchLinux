#!/bin/bash
echo "正在安裝 AUR 軟體包..."
AUR_PKGS=(
    google-chrome visual-studio-code-bin uxplay rustdesk-bin zen-browser-bin pycharm fcitx5-mcbopomofo-git
)
yay -S --noconfirm --needed "${AUR_PKGS[@]}"
echo "AUR 軟體包安裝完成。"
#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="${SCRIPT_DIR}/pkgs"

echo "Installing packages..."

PKGS=(
    # 基本系統 (Base System & Tools)
    base-devel efibootmgr fakeroot git grub networkmanager neovim
    openssh os-prober power-profiles-daemon sudo ufw

    # 顯示、音訊與藍牙 (Display, Audio & Bluetooth)
    bluez{,-utils} intel-media-driver pipewire pipewire-pulse wireplumber
    sddm vulkan-intel xorg{,-server}

    # 顯示卡驅動 (NVIDIA Drivers)
    linux-headers nvidia-open-dkms nvidia-utils

    # KDE Plasma 核心與元件 (KDE Core & Components)
    aurorae breeze{,-gtk} discover drkonqi flatpak-kcm kactivitymanagerd
    kdecoration kde-cli-tools kde-gtk-config kdeplasma-addons kglobalacceld
    kinfocenter kmenuedit knighttime kpipewire krdp kscreen{,locker}
    ksshaskpass ksystemstats kwayland kwrited layer-shell-qt libkscreen
    libksysguard libplasma milou ocean-sound-theme partitionmanager
    plasma-activities{,-stats} plasma-desktop plasma-workspace{,-wallpapers}
    polkit-kde-agent powerdevil sddm-kcm systemsettings xdg-desktop-portal-kde

    # KDE Plasma 整合模組 (KDE Integrations)
    bluedevil kwallet-pam plasma-{nm,pa,disks,firewall,thunderbolt}
    plasma-{systemmonitor,vault,welcome,browser-integration,integration}

    # KDE 應用程式 (KDE Applications)
    ark dolphin{,-plugins} gwenview kate spectacle

    # 常用軟體與工具 (Common Utilities & Software)
    fish kitty libreoffice-fresh-zh-tw mpv thunderbird unrar zip

    # 開發與容器 (Dev & Containers)
    docker{,-compose} jre-openjdk tailscale

    # 字型 (Fonts)
    noto-fonts-{cjk,emoji} ttf-{font-awesome,jetbrains-mono,nerd-fonts-symbols-mono}

    # 輸入法 (Input Method: Fcitx5)
    fcitx5-{chinese-addons,gtk,im,qt}
)

if [ ! -d "$PKG_DIR" ]; then
    echo "找不到套件目錄：$PKG_DIR"
    exit 1
fi

shopt -s nullglob
PKG_FILES=("$PKG_DIR"/*.pkg.tar.zst)
if [ ${#PKG_FILES[@]} -eq 0 ]; then
    echo "在 $PKG_DIR 中找不到任何 .pkg.tar.zst 套件檔。"
    exit 1
fi

pacman -U --noconfirm "${PKG_FILES[@]}"
pacman -Syu --needed --noconfirm "${PKGS[@]}"
systemctl enable sddm NetworkManager ufw sshd bluetooth tailscaled docker
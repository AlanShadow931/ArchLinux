#!/bin/bash

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
    breeze-grub

    # KDE Plasma 整合模組 (KDE Integrations)
    bluedevil kwallet-pam plasma-{nm,pa,disks,firewall,thunderbolt}
    plasma-{systemmonitor,vault,welcome,browser-integration,integration}

    # KDE 應用程式 (KDE Applications)
    ark dolphin{,-plugins} gwenview kate spectacle

    # 常用軟體與工具 (Common Utilities & Software)
    discord firefox fish kitty libreoffice-fresh-zh-tw mpv thunderbird unrar zip

    # 開發與容器 (Dev & Containers)
    docker{,-compose} jre-openjdk tailscale

    # VPN 整合 (VPN Integration)
    networkmanager-openconnect openconnect

    # 字型 (Fonts)
    noto-fonts-{cjk,emoji} ttf-{font-awesome,jetbrains-mono,nerd-fonts-symbols-mono}

    # 輸入法 (Input Method: Fcitx5)
    fcitx5-{chinese-addons,gtk,im,qt}
)
pacman -U --noconfirm pkgs/*.pkg.tar.zst
pacman -Syu --needed --noconfirm "${PKGS[@]}"
systemctl enable sddm NetworkManager ufw sshd bluetooth tailscaled docker 
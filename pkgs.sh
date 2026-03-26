#!/bin/bash
PKGS=(
    # 基本系統
    sudo grub efibootmgr networkmanager git base-devel fakeroot intel-ucode ufw neovim openssh
    # KDE Plasma
    plasma-desktop plasma-workspace{,-wallpapers} kwin kscreen{,locker} libkscreen
    kactivitymanagerd plasma-activities{,-stats} libplasma libksysguard kglobalacceld
    breeze{,-gtk} ocean-sound-theme aurorae kdecoration kdeplasma-addons systemsettings
    kinfocenter kde-gtk-config sddm-kcm flatpak-kcm kmenuedit kde-cli-tools drkonqi ksystemstats
    powerdevil bluedevil plasma-{nm,pa,disks,firewall,thunderbolt} print-manager
    discover plasma-{systemmonitor,vault,welcome,browser-integration,integration}
    milou polkit-kde-agent kwallet-pam ksshaskpass kwayland kwrited
    kpipewire krdp knighttime layer-shell-qt xdg-desktop-portal-kde
    # 顯示與音訊
    xorg{,-server} sddm intel-media-driver vulkan-intel pipewire wireplumber pipewire-pulse bluez{,-utils}
    # KDE 應用
    dolphin{,-plugins} ark gwenview spectacle kate
    # 常用軟體
    firefox discord thunderbird kitty fish mpv obs-studio libreoffice-fresh-zh-tw
    # 開發與容器
    tailscale docker{,-compose}
    # QEMU/KVM 虛擬化
    qemu-full libvirt virt-manager dnsmasq edk2-ovmf iptables-nft
    # 字型與輸入法
    noto-fonts-{cjk,emoji} ttf-{jetbrains-mono,font-awesome,nerd-fonts-symbols-mono}
    fcitx5-{im,chewing,qt,gtk,chinese-addons}
    # 開發工具
    jre-openjdk
    # NVIDIA 驅動
    nvidia-open-dkms nvidia-utils
)
pacman -Syu --needed --noconfirm "${PKGS[@]}"
#!/bin/bash

USERNAME="Asomya"
echo "Setting up system configurations..."

# 時區與時間 (Timezone & Time)
ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
hwclock --systohc

# 語言與區域 (Locale & Language)
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=zh_TW.UTF-8" > /etc/locale.conf

# 主機名稱與 hosts 設定 (Hostname & Hosts)
echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux" >> /etc/hosts

# 使用者與權限 (User & Permissions)
echo "Changing root password..."
passwd
useradd -m -G wheel,docker -s /bin/bash $USERNAME
echo "Changing password for $USERNAME..."
passwd $USERNAME

# 設定 sudo 權限
echo "$USERNAME ALL=(ALL:ALL) ALL" >> /etc/sudoers

git clone https://github.com/ZWolken/PingFang.git /tmp/PingFang
mkdir -p /usr/share/fonts/PingFang
cp /tmp/PingFang/*.ttf /usr/share/fonts/PingFang/

# GRUB 引導程式安裝與設定 (GRUB Bootloader)
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
ls /boot
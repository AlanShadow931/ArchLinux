#!/bin/bash

set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    echo "此腳本應在 arch-chroot 之後以 root 執行。"
    exit 1
fi

CONF_FILE="/etc/mkinitcpio.conf"
BACKUP_FILE="${CONF_FILE}.bak.$(date +%F-%H%M%S)"

if [ ! -f "$CONF_FILE" ]; then
    echo "找不到 $CONF_FILE"
    exit 1
fi

cp "$CONF_FILE" "$BACKUP_FILE"
echo "已備份原始設定到 $BACKUP_FILE"

python3 - <<'PY'
from pathlib import Path
import re

conf_path = Path('/etc/mkinitcpio.conf')
text = conf_path.read_text()

modules_to_add = ['nvidia', 'nvidia_modeset', 'nvidia_uvm', 'nvidia_drm']
pattern = re.compile(r'^MODULES=\((.*?)\)', re.MULTILINE | re.DOTALL)

match = pattern.search(text)
if match:
    current = re.findall(r'[A-Za-z0-9_+.-]+', match.group(1))
    for mod in modules_to_add:
        if mod not in current:
            current.append(mod)
    new_line = 'MODULES=(' + ' '.join(current) + ')'
    text = text[:match.start()] + new_line + text[match.end():]
else:
    text += '\nMODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)\n'

conf_path.write_text(text)
PY

echo "已更新 $CONF_FILE，加入 NVIDIA 模組"

mkinitcpio -P

echo "initramfs 已重新生成"


#/usr/bin/bash
# https://x410.dev/cookbook/wsl/sharing-windows-fonts-with-wsl/
set -o errexit
set -o nounset
set -o xtrace

if [ -z "$(which fc-cache)" ]; then
  sudo apt install fontconfig
fi

if [ -z "$(which mkfontscale)"]; then
  sudo apt install xfonts-utils
fi

# 将windows的字体放入ubuntu里
sudo mkdir --parents '/usr/share/fonts/windows'
sudo cp --recursive /mnt/c/Windows/Fonts/*.ttf '/usr/share/fonts/windows/'
sudo cp --recursive /mnt/c/Windows/Fonts/*.ttc '/usr/share/fonts/windows/'
fc-cache

cd '/usr/share/fonts/windows/'
sudo mkfontscale
sudo mkfontdir
fc-cache

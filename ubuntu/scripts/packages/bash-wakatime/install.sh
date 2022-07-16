#!/usr/bin/bash
# https://wakatime.com/terminal
set -o errexit
set -o nounset
set -o xtrace

python3 -c "$(wget -q -O - https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py)"

rm --force --recursive "${PROGRAMS}/bash-wakatime/"
git clone 'https://github.com/gjsheep/bash-wakatime.git' "${PROGRAMS}/bash-wakatime/"

if [ ! -f "${HOME}/.wakatime.cfg" ]; then
  read -p "Enter your WakaTime Api Key from <https://wakatime.com/settings> : " api_key
  tee "${HOME}/.wakatime.cfg" <<-EOF
[settings]
api_key = ${api_key}
EOF
fi

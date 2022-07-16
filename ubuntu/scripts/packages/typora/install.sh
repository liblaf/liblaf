#!/usr/bin/bash
# https://support.typora.io/Typora-on-Linux/
set -o errexit
set -o nounset
set -o xtrace

# or use
# wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
wget -qO - https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc

# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update

# install typora
sudo apt-get install typora

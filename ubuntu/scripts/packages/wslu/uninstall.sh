#!/usr/bin/bash
set -o errexit
set -o nounset
set -o xtrace

sudo apt purge --auto-remove wslu
sudo add-apt-repository --remove ppa:wslutilities/wslu
sudo apt update
sudo apt upgrade

#!/usr/bin/bash
# https://github.com/wslutilities/wslu
set -o errexit
set -o nounset
set -o xtrace

sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt upgrade

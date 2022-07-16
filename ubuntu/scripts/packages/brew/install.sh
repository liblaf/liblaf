#!/usr/bin/bash
# https://brew.sh/
set -o errexit
set -o nounset
set -o xtrace

sudo apt-get install build-essential procps curl file git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

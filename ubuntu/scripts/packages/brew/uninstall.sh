#!/usr/bin/bash
set -o errexit
set -o nounset
set -o xtrace

sudo rm --force --recursive "$(brew --prefix)"

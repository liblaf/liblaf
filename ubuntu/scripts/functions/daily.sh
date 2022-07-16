#!/usr/bin/bash

function u_update() {
  (
    set -o xtrace
    sudo apt update
    sudo apt upgrade --yes
    if [ -n "$(which brew)" ]; then
      brew update
      brew upgrade
    fi
    if [ -n "$(which snap)" ]; then
      snap refresh
    fi
  )
}

function clean_history() {
  (
    set -o xtrace
    rm "${HOME}/.bash_history"
    rm "${HOME}/.lesshst"
    rm "${HOME}/.python_history"
    rm "${HOME}/.wget-hsts"
  )
}

function u_clean() {
  (
    set -o xtrace
    rm --force --recursive /tmp/*
    rm --force --recursive "${HOME}/.cache/"
    sudo apt clean
    sudo apt autoclean --yes
    sudo apt autoremove --yes
    if [ -n "$(which brew)" ]; then
      brew autoremove
      brew cleanup
    fi
  )
}

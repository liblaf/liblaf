#!/usr/bin/bash

function time_sync_ntp() {
  # https://tuna.moe/help/ntp/
  sudo ntpdate ${1:-'ntp.tuna.tsinghua.edu.cn'}
}

function time_sync_win() {
  # https://wslutiliti.es/wslu/man/wslact.html
  sudo wslact time-sync
}

#!/usr/bin/bash
# https://github.com/bytemain/dotfiles/blob/main/ubuntu_wsl/zshrc

function get_host_ip() {
  export host_ip="127.0.0.1"
  export proxy_socks="socks5://${host_ip}:${1:-20170}"
  export proxy_http="http://${host_ip}:${2:-20172}"
}

function print_ip() {
  echo "Host IP      : ${host_ip}"
  echo "PROXY SOCKS5 : ${proxy_socks}"
  echo "PROXY HTTP   : ${proxy_http}"
}

function proxy_apt() {
  get_host_ip ${@}
  echo "Acquire::http::Proxy \"${proxy_http}\";" | sudo tee '/etc/apt/apt.conf.d/proxy.conf' >'/dev/null'
  echo "Acquire::https::Proxy \"${proxy_http}\";" | sudo tee --append '/etc/apt/apt.conf.d/proxy.conf' >'/dev/null'
}

function unproxy_apt() {
  sudo rm '/etc/apt/apt.conf.d/proxy.conf'
}

function proxy_git() {
  get_host_ip ${@}
  git config --global 'http.https://github.com.proxy' "${proxy_http}"
}

function unproxy_git() {
  git config --global --unset 'http.https://github.com.proxy'
}

function proxy_npm() {
  get_host_ip ${@}
  if [ -n "$(which npm)" ]; then
    npm config set proxy "${proxy_http}"
    npm config set https-proxy "${proxy_http}"
  fi
  if [ -n "$(which yarn)" ]; then
    yarn config set proxy "${proxy_http}"
    yarn config set https-proxy "${proxy_http}"
  fi
}

function unproxy_npm() {
  if [ -n "$(which npm)" ]; then
    npm config delete proxy
    npm config delete https-proxy
  fi
  if [ -n "$(which yarn)" ]; then
    yarn config delete proxy
    yarn config delete https-proxy
  fi
}

function proxy() {
  get_host_ip ${@}
  print_ip
  # pip can read http_proxy & https_proxy
  export HTTP_PROXY="${proxy_http}"
  export http_proxy="${proxy_http}"
  export HTTPS_PROXY="${proxy_http}"
  export https_proxy="${proxy_http}"
  export FTP_PROXY="${proxy_http}"
  export ftp_proxy="${proxy_http}"
  export RSYNC_PROXY="${proxy_http}"
  export rsync_proxy="${proxy_http}"
  export ALL_PROXY="${proxy_socks}"
  export all_proxy="${proxy_socks}"
  proxy_git
  # proxy_apt
}

function unproxy() {
  unset proxy_socks
  unset proxy_http
  unset HTTP_PROXY
  unset http_proxy
  unset HTTPS_PROXY
  unset https_proxy
  unset FTP_PROXY
  unset ftp_proxy
  unset RSYNC_PROXY
  unset rsync_proxy
  unset ALL_PROXY
  unset all_proxy
  unproxy_git
  # unproxy_apt
}

#!/usr/bin/bash

function package() {
  local action="${1}"
  local name="${2}"
  local cmd=""
  shift 2
  case "${action}" in
  install | uninstall | docter)
    cmd='bash'
    ;;
  load | unload)
    cmd='source'
    ;;
  list)
    ll "${PROGRAMS}/"
    return
    ;;
  *)
    echo "invalid action \"${action}\""
    return
    ;;
  esac
  ${cmd} "${SCRIPTS}/packages/${name}/${action}.sh" ${@}
}

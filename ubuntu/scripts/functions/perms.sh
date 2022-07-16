#!/usr/bin/bash

function fix_perms() {
  local dirs=$(find "${1:-.}" -type d)
  chmod u=rwx,go=rx ${dirs}
  local files=$(find "${1:-.}" -type f)
  chmod u=rw,go=r ${files}
}

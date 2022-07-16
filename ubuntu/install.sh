#!/usr/bin/bash
set -o errexit
set -o nounset
set -o xtrace

if [ ! -v prefix ]; then
  prefix="$(pwd)"
fi

rm --recursive "${HOME}/scripts/"

cp "${prefix}/.bashrc" "${HOME}/"
cp "${prefix}/.profile" "${HOME}/"
cp --recursive "${prefix}/scripts/" "${HOME}/"

if [ -x "${PROGRAMS}/miniconda/bin/conda" ]; then
  "${PROGRAMS}/miniconda/bin/conda" init
fi

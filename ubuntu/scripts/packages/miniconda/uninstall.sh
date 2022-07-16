#!/usr/bin/bash
set -o errexit
set -o nounset
set -o xtrace

rm --force --recursive "${CONDA_PREFIX}"
rm --force --recursive "${HOME}/.condarc"
rm --force --recursive "${HOME}/.conda"
rm --force --recursive "${HOME}/.continuum"

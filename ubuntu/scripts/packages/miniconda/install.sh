#!/usr/bin/bash
set -o errexit
set -o nounset
set -o xtrace

os="${os:-Linux}"
arch="${arch:-x86_64}"
filename="Miniconda3-latest-${os}-${arch}.sh"
wget --output-document='-' "https://repo.anaconda.com/miniconda/${filename}" | tee "${DOWNLOADS}/${filename}" >'/dev/null'
prefix="${PROGRAMS}/miniconda"
bash "${DOWNLOADS}/${filename}" -b -p "${prefix}" -f

"${PROGRAMS}/miniconda/bin/conda" init

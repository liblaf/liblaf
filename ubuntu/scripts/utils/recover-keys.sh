#!/usr/bin/bash
set -o errexit
set -o nounset

if [ ! -v prefix ]; then
  prefix="$(pwd)"
fi

# ssh
mkdir --parents "${HOME}/.ssh/"
if [ -r "${prefix}/ssh/config" ]; then
  (
    set -o xtrace
    cp "${prefix}/ssh/config" "${HOME}/.ssh/"
    chmod ug=rw,o=r "${HOME}/.ssh/config"
  )
fi
for type in rsa dsa ecdsa ed25519; do
  if [ -r "${prefix}/ssh/id_${type}" ]; then
    (
      set -o xtrace
      cp "${prefix}/ssh/id_${type}" "${HOME}/.ssh/"
      chmod u=rw,go= "${HOME}/.ssh/id_${type}"
      cp "${prefix}/ssh/id_${type}.pub" "${HOME}/.ssh/"
      chmod u=rw,go=r "${HOME}/.ssh/id_${type}.pub"
    )
  fi
done

# gpg
(
  set -o xtrace
  gpg --import "${prefix}/gpg/secret.key"
)

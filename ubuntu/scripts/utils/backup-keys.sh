#!/usr/bin/bash
set -o errexit
set -o nounset

if [ ! -v prefix ]; then
  prefix="$(pwd)"
fi
echo "Backing up keys to \"${prefix}/\" ..."

# ssh
echo "Backing up ssh keys ..."
mkdir --parents "${prefix}/ssh/"
if [ -r "${HOME}/.ssh/config" ]; then
  echo "Backing up ssh config ..."
  cp "${HOME}/.ssh/config" "${prefix}/ssh/"
else
  echo "ssh config file not found"
fi
for type in dsa ecdsa ed25519 ed25519-sk rsa; do
  if [ -r "${HOME}/.ssh/id_${type}" ]; then
    echo "Backing up ${type} private key ..."
    cp "${HOME}/.ssh/id_${type}" "${prefix}/ssh/"
    echo "Backing up ${type} public key ..."
    cp "${HOME}/.ssh/id_${type}.pub" "${prefix}/ssh/"
  fi
done

# gpg
echo "Backing up gpg keys ..."
mkdir --parents "${prefix}/gpg/"
gpg --export-secret-keys --armor | tee "${prefix}/gpg/secret.key" >'/dev/null'

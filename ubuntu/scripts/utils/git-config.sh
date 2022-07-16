#!/usr/bin/bash
set -o nounset

old_user_name="$(git config --global user.name)"
read -p "Enter your Git username [${old_user_name}]:" new_user_name
if [ -n "${new_user_name}" ]; then
  git config --global user.name "${new_user_name}"
fi
old_user_email="$(git config --global user.email)"
read -p "Enter your email address [${old_user_email}]: " new_user_email
if [ -n "${new_user_email}" ]; then
  git config --global user.email "${new_user_email}"
fi

# https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
(
  set -o xtrace
  gpg --list-secret-keys --keyid-format=long
)
old_user_signingkey="$(git config --global user.signingkey)"
read -p "Enter your GPG key ID [${old_user_signingkey}]: " new_user_signingkey
if [ -n "${new_user_signingkey}" ]; then
  git config --global commit.gpgsign true
  git config --global user.signingkey "${new_user_signingkey}"
fi
(
  set -o xtrace
  git config --global --list
)

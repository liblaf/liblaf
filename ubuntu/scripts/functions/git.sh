#!/usr/bin/bash

function git_delte_tags() {
  local prefix="$(pwd)"
  if [ -d "${prefix}/.git" ]; then
    git pull --tags
    git tag --list | xargs --max-args=1 git push origin --delete
    git tag --list | xargs --max-args=1 git tag --delete
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

function git_reset() {
  local prefix="$(pwd)"
  if [ -r "${prefix}/.git/config" ]; then
    git_delte_tags
    cp "${prefix}/.git/config" '/tmp/tmp-git-config'
    rm --force --recursive '.git/'
    git init --initial-branch='main'
    git add '.'
    git commit --gpg-sign --message='Initial commit'
    cp '/tmp/tmp-git-config' "${prefix}/.git/config"
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

function git_verify() {
  local prefix="$(pwd)"
  if [ -d "${prefix}/.git/" ]; then
    git filter-branch --commit-filter 'git commit-tree --gpg-sign "$@";' -- --all
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

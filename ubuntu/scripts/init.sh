#!/usr/bin/bash

DOWNLOADS="${HOME}/Downloads"
if [ ! -d "${DOWNLOADS}/" ]; then
  mkdir --parents "${DOWNLOADS}/"
fi
export DOWNLOADS

PROGRAMS="${HOME}/programs"
if [ ! -d "${PROGRAMS}/" ]; then
  mkdir --parents "${PROGRAMS}/"
fi
export PROGRAMS

SCRIPTS="${HOME}/scripts"
if [ ! -d "${SCRIPTS}/" ]; then
  mkdir --parents "${SCRIPTS}"
fi
export SCRIPTS

if [ -d "${SCRIPTS}/" ]; then
  if [ -d "${SCRIPTS}/functions/" ]; then
    for file in ${SCRIPTS}/functions/*.sh; do
      source "${file}"
    done
    unset file
  fi
fi

package load bash-wakatime

# load rbenv
if [ -n "$(which rbenv)" ]; then
  eval "$(rbenv init - bash)"
fi

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

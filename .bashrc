#!/bin/bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# linux64
export PATH="$PATH:/usr/bin/nvim-linux64/bin"
eval "$(~/.rbenv/bin/rbenv init - bash)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
eval "$(direnv hook bash)"

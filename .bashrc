#!/bin/bash

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

## for file in ~/.{bash_profile,bash_prompt,aliases,functions,path,exports}; do
for file in ~/.{bash_prompt,aliases,functions,path,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
unset file

# linux64
export PATH="$PATH:/usr/bin/nvim-linux64/bin"
eval "$(~/.rbenv/bin/rbenv init - bash)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
. "$HOME/.cargo/env"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

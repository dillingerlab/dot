#!/bin/bash

# Load .bashrc and other files...
for file in ~/.{zshrc,functions,path,exports,aliases}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
unset file

setopt HIST_IGNORE_DUPS
fpath+=~/.zfunc
autoload -Uz compinit && compinit

HISTTIMEFORMAT="%F %T "
export HIST_IGNORE_DUPS

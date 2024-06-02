#!/bin/bash

for file in ~/.{bashrc,bash_prompt,aliases,functions,path,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
unset file
#
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

HISTTIMEFORMAT="%F %T "
export HIST_IGNORE_DUPS

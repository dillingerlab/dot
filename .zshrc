#!/bin/zsh

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# Load .bashrc and other files...
for file in ~/.{functions,exports,aliases}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done
unset file

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
fpath+=~/.zfunc
autoload -Uz compinit && compinit

HISTTIMEFORMAT="%F %T "



. "$HOME/.cargo/env"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source "$HOME/.rye/env"

export PATH="$PATH:/usr/bin/nvim-linux64/bin"
eval "$(~/.rbenv/bin/rbenv init - zsh)"
eval "$(~/.rye/shims/rye self completion -s zsh)"
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=true
export EDITOR='nvim'

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export SDKMAN_DIR="$HOME/.sdkman"
eval "$(direnv hook zsh)"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt ALWAYS_TO_END
setopt EXTENDED_HISTORY
setopt AUTO_CD
setopt PROMPT_SUBST
setopt HIST_IGNORE_DUPS
setopt DVORAK

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

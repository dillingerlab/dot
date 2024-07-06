# Machine Setup

Started from: <https://github.com/jessfraz/dotfiles>

## Getting Started

## Prereqs

1. `zsh` - `sudo apt install zsh` and `chsh -s $(which zsh)`

Check the recipes available via `make help`

## Windows

### Docker

- Docker for Desktop

### Keyboard Improvements

- [Map Caps Lock to Right Control Key](https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10)

## Mac

use zsh
install homebrew
install iterm2

```
# Node/NPM
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# mac
# export HOMEBREW_PREFIX="/opt/homebrew"
# export HOMEBREW_CELLAR="/opt/homebrew/cellar"
# export HOMEBREW_REPOSITORY="/opt/homebrew"
# export PATH="/opt/homebrew/bin:opt/homebrew/sbin${PATH+:$PATH}"
# export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
# export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
```

Remove from `.zshrc`

```
rbenv
direnv
```

- [Map Caps Lock to Control Key](https://stackoverflow.com/questions/20146972/is-there-a-way-to-make-alt-f-and-alt-b-jump-word-forward-and-backward-instead-of)

## Git Cred Manager

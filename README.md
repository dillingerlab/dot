# Machine Setup

Started from: <https://github.com/jessfraz/dotfiles>

## Windows

### Docker

- Docker for Desktop

### Keyboard Improvements

- [Map Caps Lock to Right Control Key](https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10)

## Mac

use zsh
install homebrew
install iterm2

- [Map Caps Lock to Control Key](https://stackoverflow.com/questions/20146972/is-there-a-way-to-make-alt-f-and-alt-b-jump-word-forward-and-backward-instead-of)

## `nvim`

### lua/config/options.lua

```lua
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"
```

### lua/config/keymaps.lua

```lua
vim.keymap.set("n", "h", ";")
vim.keymap.set("n", "j", "h")
vim.keymap.set("n", "k", "j")
vim.keymap.set("n", "l", "k")
vim.keymap.set("n", ";", "l")
```

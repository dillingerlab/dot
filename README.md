Mostly assembled from https://github.com/jessfraz/dotfiles
install homebrew
install iterm2

TODO:
Find way to append following to `.gitconfig`:
```
[alias]
last = log -1 HEAD
re2 = rebase -i HEAD~2
```

# Ruby - PITA
```
ruby:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	git clone https://github.com/rbenv/ruby-build.git $(HOME)/plugins/ruby-build
    # restart shell
    rbenv install 3.3.1
    rbenv global 3.3.1
```

# Windows Improvements
- [Map Caps Lock to Right Control Key](https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10)

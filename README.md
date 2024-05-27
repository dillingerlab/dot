# Machine Setup

Mostly assembled from <https://github.com/jessfraz/dotfiles>

## Ruby - PITA

```yaml
sudo apt update
sudo apt install libyaml-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
~/.rbenv/bin/rbenv init
rbenv install 3.3.1
rbenv global 3.3.1
```

## Python

```yaml
pyenv install 3.12.3
pyenv global 3.12.3
```

## Docker

- Docker for Desktop

## Windows Improvements

- [Map Caps Lock to Right Control Key](https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10)

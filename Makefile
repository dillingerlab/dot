SHELL := /bin/bash

.DEFAULT_GOAL := help

VIMBUNDLE=$(HOME)/.vim/bundle


$(VIMBUNDLE): ## Setup Vim Theme
	sudo touch ~/.viminfo
	sudo chown $$USER ~/.viminfo
	sudo chgrp $$USER ~/.viminfo
	( \
        mkdir -p $(HOME)/.vim/autoload; \
        mkdir -p $(HOME)/.vim/bundle; \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim; \
		git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale; \
	)
	cp -r $(CURDIR)/templates $(HOME)/.vim/


dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" ); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile


git: ## Setup git
	mkdir -p $(HOME)/.config/git
	ln -sfn $(CURDIR)/ignore $(HOME)/.config/git/ignore
	git config remote.origin.prune true


tools:
	sudo apt install dos2unix
	sudo apt install tree
	sudo apt install shellcheck
	sudo apt install httpie
	sudo apt install tmux
	sudo apt install shellcheck
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	nvm install node

misc:
	sudo sed -i 's/# set bell-style none/set bell-style none/' /etc/inputrc


all:
	$(MAKE) dotfiles
	$(MAKE) $(VIMBUNDLE)


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

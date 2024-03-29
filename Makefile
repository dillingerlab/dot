SHELL := /bin/bash
.DEFAULT_GOAL := help

VIMBUNDLE=$(HOME)/.vim/bundle


$(VIMBUNDLE): ## Setup Vim Theme
	touch $(HOME)/.viminfo
	mkdir -p $(HOME)/.vim/undodir
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/bundle
	curl -LSso $(HOME)/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
	git clone https://github.com/dense-analysis/ale.git $(HOME)/.vim/bundle/ale;
	git clone https://github.com/preservim/nerdtree.git $(HOME)/.vim/bundle/nerdtree;
	cp -r $(CURDIR)/templates $(HOME)/.vim/;
	ln -sfn $(CURDIR)/.vimrc $(HOME)/.vimrc;


vim:
	$(MAKE) $(VIMBUNDLE)


dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" ); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile


git: ## Setup git
	git config --global remote.origin.prune true
	git config --global log.abbrevCommit true
	git config --global core.abbrev 8
	git config --global alias.lease 'push --force-with-lease'
	git config --global init.defaultBranch main
	git config --global push.autoSetupRemote true
	git config --global advice.skippedCherryPicks false


node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	$(HOME)/.nvm/nvm install node


direnv:
	curl -sfL https://direnv.net/install.sh | bash

aws:
	npm install -g aws-cdk
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
	sudo installer -pkg AWSCLIV2.pkg -target /


make java:
	curl -s "https://get.sdkman.io" | bash
	( \
		source "$(HOME)/.sdkman/bin/sdkman-init.sh"; \
		sdk install java 21.0.2-zulu; \
		sdk use java 21.0.2-zulu; \
	)


tools:
	sudo apt install dos2unix tree shellcheck httpie tmux shellcheck zip


misc:
	sudo sed -i 's/# set bell-style none/set bell-style none/' /etc/inputrc

python:
	sudo apt install python3.10
	sudo apt install python3.10-venv


all:
	$(MAKE) dotfiles
	$(MAKE) $(VIMBUNDLE)


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

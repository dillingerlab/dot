SHELL := /bin/bash
.DEFAULT_GOAL := help

VIMBUNDLE=$(HOME)/.vim/bundle


$(VIMBUNDLE): ## Vim
	touch $(HOME)/.viminfo
	mkdir -p $(HOME)/.vim/undodir
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/bundle
	curl -LSso $(HOME)/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
	git clone https://github.com/dense-analysis/ale.git $(HOME)/.vim/bundle/ale;
	git clone https://github.com/preservim/nerdtree.git $(HOME)/.vim/bundle/nerdtree;
	cp -r $(CURDIR)/templates $(HOME)/.vim/;
	ln -sfn $(CURDIR)/.vimrc $(HOME)/.vimrc;


vim:  # vim
	$(MAKE) $(VIMBUNDLE)

nvim:  # Almost complete neovim + lazyvim
	sudo apt install gcc
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /usr/bin/nvim
	sudo tar -C /usr/bin -xzf nvim-linux64.tar.gz
	rm -rf $(CURDIR)/nvim-linux64.tar.gz
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
	( \
		LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*'); \
		curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"; \
		tar xf lazygit.tar.gz lazygit; \
	)
	sudo install lazygit /usr/local/bin
	sudo apt-get install ripgrep
	git config --global core.editor nvim
	cargo install fd-find

dotfiles: ## dotfiles.
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
	git config --global help.autocorrect prompt 1
	git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"	


node:  ## node version manager and latest nod
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	$(HOME)/.nvm/nvm install node


direnv: ## direnv
	curl -sfL https://direnv.net/install.sh | bash


aws:  ## AWS CLI
	npm install -g aws-cdk
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
	sudo installer -pkg AWSCLIV2.pkg -target /


java:  # sdkman to manage java
	sudo apt install unzip
	curl -s "https://get.sdkman.io" | bash
	( \
		source "$(HOME)/.sdkman/bin/sdkman-init.sh"; \
		sdk install java 21.0.2-zulu; \
		sdk use java 21.0.2-zulu; \
	)


ruby:  ## Ruby
	sudo apt update
	sudo apt install libyaml-dev
	( \
		git clone https://github.com/rbenv/rbenv.git $(HOME)/.rbenv; \
		git clone https://github.com/rbenv/ruby-build.git $(HOME)/.rbenv/plugins/ruby-build; \
		$(HOME)/.rbenv/bin/rbenv init; \
		$(HOME)/.rbenv/bin/rbenv install 3.3.1; \
		$(HOME)/.rbenv/bin/rbenv global 3.3.1; \
	)


tools:  ## old school sysadmin
	sudo apt install dos2unix tree shellcheck httpie tmux shellcheck zip
	$(MAKE) direnv


wsl:  ## we need less cow bell
	sudo sed -i 's/# set bell-style none/set bell-style none/' /etc/inputrc


python:  ## pyenv; you will need to complete outside make
	sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev curl git \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	curl https://pyenv.run | bash
	echo "restart shell..."


rust:  # rustup; rust/cargo
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

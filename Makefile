SHELL := /bin/bash
.DEFAULT_GOAL := help

VIMBUNDLE=$(HOME)/.vim/bundle
LAZYVIM_CONFIG=$(HOME)/.config/nvim/lua/config


$(VIMBUNDLE):
	touch $(HOME)/.viminfo
	mkdir -p $(HOME)/.vim/undodir
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/bundle
	cp -r $(CURDIR)/templates $(HOME)/.vim/;
	ln -sfn $(CURDIR)/.vimrc $(HOME)/.vimrc;


vim:  ## vim
	$(MAKE) $(VIMBUNDLE)


lazy_nvim:
	for file in $(shell find $(CURDIR)/nvim -name "*.lua"); do \
		cp $$file $(LAZYVIM_CONFIG)/; \
	done; \


nvim-linux64:  ## nvim-linux64
	sudo apt install gcc
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /usr/bin/nvim
	sudo tar -C /usr/bin -xzf nvim-linux64.tar.gz
	rm -rf $(CURDIR)/nvim-linux64.tar.gz
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
	sudo install lazygit /usr/local/bin
	( \
		curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_0.42.0_Linux_x86_64.tar.gz"; \
		tar xf lazygit.tar.gz lazygit; \
	)
	rm $(CURDIR)/lazygit
	rm $(CURDIR)/lazygit.tar.gz
	sudo apt-get install ripgrep
	git config --global core.editor nvim
	$(MAKE) rust
	cargo install fd-find


nvim-mac:  ## nvim-mac
	brew install neovim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
	brew install jesseduffield/lazygit/lazygit
	brew install ripgrep
	git config --global core.editor nvim
	cargo install fd-find


dotfiles: ## dotfiles mac.
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" ); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \

tmux:
	gem install tmuxinator
	mkdir -p $(HOME)/.zfunc/
	wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ~/.zfunc/_tmuxinator


git-personal:
	git config --global user.name "Austin"
	git config --global user.email "shuffletick@gmail.com"


git: ## git
	curl -Lo gcm.tar.gz "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.5.0/gcm-linux_amd64.2.5.0.tar.gz"
	tar xf gcm.tar.gz git-credential-manager
	sudo install git-credential-manager /usr/local/bin
	rm $(CURDIR)/gcm.tar.gz
	rm -rf $(CURDIR)/git-credential-manager
	git-credential-manager configure
	sudo apt-get install pass
	gpg --full-generate-key
	pass init `gpg --list-secret-keys --keyid-format=long | grep sec | awk '{print $2}' | sed  's/rsa3072\///g'`
	git config --global remote.origin.prune true
	git config --global log.abbrevCommit true
	git config --global core.abbrev 8
	git config --global alias.lease 'push --force-with-lease'
	git config --global init.defaultBranch main
	git config --global push.autoSetupRemote true
	git config --global advice.skippedCherryPicks false
	git config --global help.autocorrect immediate
	git config --global rerere.enabled true
	git config --global credential.credentialStore gpg


node:  ## node
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	#$(HOME)/.nvm/nvm install node


aws:  ## aws cdk
	npm install -g aws-cdk
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
	sudo installer -pkg AWSCLIV2.pkg -target /


java-linux64:  ## sdkman for java-linux64
	sudo apt install unzip
	curl -s "https://get.sdkman.io" | bash
	( \
		source "$(HOME)/.sdkman/bin/sdkman-init.sh"; \
		sdk install java 21.0.2-zulu; \
		sdk use java 21.0.2-zulu; \
	)


java-mac:  ## sdkman for java - mac
	curl -s "https://get.sdkman.io" | bash
	( \
		$(HOME)/.sdkman/bin/sdkman-init.sh; \
		sdk install java 21.0.2-zulu; \
		sdk use java 21.0.2; \
	)


ruby-linux:  ## ruby-linux
	sudo apt update
	sudo apt install libyaml-dev libz-dev libssl-dev build-essential
	( \
		git clone https://github.com/rbenv/rbenv.git $(HOME)/.rbenv; \
		git clone https://github.com/rbenv/ruby-build.git $(HOME)/.rbenv/plugins/ruby-build; \
		$(HOME)/.rbenv/bin/rbenv init; \
		$(HOME)/.rbenv/bin/rbenv install 3.3.1; \
		$(HOME)/.rbenv/bin/rbenv global 3.3.1; \
	)


ruby-mac:  ## ruby - mac
	brew install rbenv ruby-build
	rbenv install 3.3.1
	rbenv global 3.3.1


tools-linux64:  ## tools-linux64
	sudo apt install dos2unix shellcheck httpie tmux shellcheck zip direnv
	sudo apt install xclip xsel		
	$(MAKE) ruby-linux
	sudo sed -i 's/# set bell-style none/set bell-style none/' /etc/inputrc

popos-core:
	sudo apt install \
	build-essential \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common \
	apache2-utils \
	make \
	chromium-browser \
	gnome-tweaks \
	gnome-shell-extensions \
	dconf-editor;
	sudo apt autoremove -y;
	sudo apt autoclean -y;
	sudo reboot now;
	sudo apt install gnome-tweaks;

tools-mac:  # tools-mac
	brew install direnv jq yq direnv
	brew install tmux


python:
	curl -sSf https://rye.astral.sh/get | bash
	$(HOME)/.rye/shims/rye config --set-bool behavior.global-python=true


python-linux64:  ## rye-linux64
	$(MAKE) python
	mkdir -p ~/.local/share/bash-completion/completions
	$(HOME)/.rye/shims/rye self completion > ~/.local/share/bash-completion/completions/rye.bash

rust:  ## rustup; rust/cargo
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	mkdir -p $(HOME)/.zfunc/
	rustup completions zsh cargo > ~/.zfunc/_cargo

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

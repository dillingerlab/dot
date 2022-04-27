.DEFAULT_GOAL := help

VIMBUNDLE=$(HOME)/.vim/bundle


$(VIMBUNDLE): ## Setup Vim Theme
	touch $(HOME)/.viminfo
	mkdir -p $(HOME)/.vim/undodir
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/bundle
	curl -LSso $(HOME)/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;
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


shell:
	ln -sfn $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -sfn $(CURDIR)/.functions $(HOME)/.functions;
	ln -sfn $(CURDIR)/.aliases $(HOME)/.aliases;
	ln -sfn $(CURDIR)/mac_vimrc $(HOME)/.vimrc;


git: ## Setup git
	git config --global remote.origin.prune true
	git config --global log.abbrevCommit true
	git config --global core.abbrev 8
	git config --global alias.lease 'push --force-with-lease'


node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	nvm install node


ruby:
	brew install chruby


tools:
	sudo apt install dos2unix tree shellcheck httpie tmux shellcheck


misc:
	sudo sed -i 's/# set bell-style none/set bell-style none/' /etc/inputrc


all:
	$(MAKE) dotfiles
	$(MAKE) $(VIMBUNDLE)


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

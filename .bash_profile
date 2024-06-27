#!/bin/bash

# update the values of LINES and COLUMNS.
shopt -s checkwinsize

HISTTIMEFORMAT="%F %T "
export HIST_IGNORE_DUPS
. "$HOME/.cargo/env"

# load dotfiles for tmux
# if [ ! -z $TMUX ]; then
# 	source ~/.bashrc
# fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

#!/bin/bash

sudo apt-get update; 
sudo apt-get -y install \
	build-essential
	cmake
	git
	python-dev
	python3-dev	

# dotfile symlinks
if [ ! -d dotfiles/ ]; then
	echo "Unable to locate dotfiles/ Exiting..."
	exit 1
fi
ln -s $(pwd)/dotfiles/.* ~/

# vim setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

pushd .
cd ~/.vim/bundle/YouCompleteMe
./install.py 

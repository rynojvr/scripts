#!/bin/bash

# Install neovim dependencies
sudo apt-get update;
sudo apt-get -y install \
	libtool \
	libtool-bin \
	autoconf \
	automake \
	cmake \
	g++ \
	pkg-config \
	unzip

# Install other dependencies
sudo apt-get -y install \
	xbacklight 		# For controlling laptop backlight with i3wm


# Save current directory and head home
pushd .
cd

# Grab source for neovim
mkdir -p dev/github/
cd dev/github

if [ hash nvim 2>/dev/null ]; then
	read -p "Neovim not detected. Install? [Y/n]:" choice
	case "$choice" in
		y|Y ) install_neovim;;
		n|n ) return;;
		*) install_neovim;;
	esac
fi

function install_neovim() {
	git clone https://github.com/neovim/neovim
	cd neovim

	# Aaaand, build neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install

	# Pop back to where we were. Be kind, rewind. ;)
	popd 

	# Grab Plug for neovim, and run it
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	nvim +PlugUpdate! +qall
	nvim +GoInstallBinaries +qall
}


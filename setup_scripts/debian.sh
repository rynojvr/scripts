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

# read -p "After first install..."

# Install other dependencies
sudo apt-get -y install \
	xbacklight \
	i3blocks \
	fonts-font-awesome

# read -p "After second install..."

# Install stuff for me
sudo apt-get -y install \
	ranger

# TODO: 
# - i3
# - i3blocks config (copying, symlinking...)
# - clone https://github.com/vivien/i3blocks-contrib


# Save current directory and head home
pushd .
cd

function install_nodejs {
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

	# Automatically done normally, but need to use nvm immediately
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

	nvm install 8.0.0
	nvm install use 8.0.0
	nvm alias default 8.0.0

	npm install -g npm
}

if ! [ -x "$(command -v node)" ]; then
	read -p "Nodejs not detected. Install? [Y/n]:" choice
	case "$choice" in
		y|Y) install_nodejs;;
		#n|N ) return;;
		"") install_nodejs;;
	esac
else
	read -p "Node already installed. Press enter to continue..."
fi

# Grab source for neovim
mkdir -p dev/github/
cd dev/github

if ! [ -x "$(command -v nvim)" ]; then
	read -p "Neovim not detected. Install? [Y/n]:" choice
	case "$choice" in
		y|Y) install_neovim;;
		n|N) return;;
		"") install_neovim;;
	esac
else
	read -p "Neovim already installed. Press enter to continue..."
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

function install_neofetch {
	# Paranoia never hurt anyone...
	sudo apt-get -y install git
	
	# Ensure directories exist
	mkdir -p $HOME/dev/github/

	cd $HOME/dev/github/
	git clone https://github.com/dylanaraps/neofetch
	cd neofetch
	sudo make install
}


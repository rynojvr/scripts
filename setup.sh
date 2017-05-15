#!/bin/bash

function install_darwin_deps {
    which -s brew
    if [[ $? != 0 ]]; then
        echo "Brew not found installing..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    echo "Brew already installed"

    brew update
    brew install vim
    brew install macvim
    brew install cmake
    brew link macvim
    ln -s /usr/local/bin/mvim vim
#	exit 0
}

function install_debian_deps {
    echo "Installing Debian deps..."
    sudo apt-get update;
    sudo apt-get -y install build-essential cmake git python-dev python3-dev python-pip python3-pip xutils-dev bison;
}

function general_setup {
	lndir $(pwd)/dotfiles/ ~/

	install_golang
}

function install_golang {
#	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
#	source "$HOME/.gvm/scripts/gvm"

#	gvm install go1.8 
	sudo apt-get install -y golang

	mkdir -p $HOME/dev/go/{bin,src,pkg}
}

function install_neovim {
	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get install -y neovim
}

function configure_neovim {
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	nvim +PlugUpdate! +qall
	nvim +GoInstallBinaries +qall
}

function install_centos_deps {
    echo "Installing CentOS deps..."

    #if [ ! -d configs/ ]; then
    #    echo "Unable to find 'configs/' directory"
    #    exit 1
    #fi
    #sudo cp configs/repos/DevToolset.repo /etc/yum.repos.d/

    sudo yum install -y \
        automake \
        clang \
        cmake \
        devtoolset-2-gcc-4.8.1 \
        devtoolset-2-gcc-c++-4.8.1 \
        gcc \
        gcc-c++ \
        kernel-devel \
	vim     # Apparently I can't take this existing for granted
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	echo "Found a Darwin system..."
	install_darwin_deps
elif [[ -f /etc/centos-release ]]; then
    echo "Found a Centos system..."
    install_centos_deps    
else
	echo "Found a Debian system..."
	install_debian_deps
	install_neovim
	general_setup
	configure_neovim
	source $HOME/.bashrc
fi

# dotfile symlinks
if [ ! -d dotfiles/ ]; then
	echo "Unable to locate dotfiles/ Exiting..."
	exit 1
fi
#ln -s $(pwd)/dotfiles/.* ~/

# vim setup
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall

#pushd .
#cd ~/.vim/bundle/YouCompleteMe
#./install.py 

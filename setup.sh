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
    sudo apt-get -y install \
        build-essential
        cmake
        git
        python-dev
        python3-dev	
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
fi

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

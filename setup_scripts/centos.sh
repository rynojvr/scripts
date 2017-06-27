sudo yum update

# Ensure git
sudo yum install git

# NeoVim - deps/preamble
sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip

# Install and config neovim
if [ ! hash nvim 2>/dev/null ]; then
	pushd .
	cd;
	mkdir -p dev/github && cd dev/github
	git clone https://github.com/neovim/neovim
	cd neovim
	make
	sudo make install
	popd
fi

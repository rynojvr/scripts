set nocompatible
set backspace=2

filetype off                  " required

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')
" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" Plugin 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree'

" Plugin 'Valloric/YouCompleteMe'

" Plugin 'ctrlpvim/ctrlp.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Plugin 'tpope/vim-fugitive'
Plug 'tpope/vim-fugitive'

" Plugin 'bling/vim-airline'
Plug 'bling/vim-airline'

" Plugin 'tyrannicaltoucan/vim-quantum'
Plug 'tyrannicaltoucan/vim-quantum'

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Initialize plugin system
call plug#end()

" Show the hidden files
let g:ctrlp_show_hidden=1
let NERDTreeShowHidden=1

" Automatically update CtrlP's indexing
let g:NERDTreeChDirMode = 2
let g:ctrlp_working_path_mode = 'rw'

" Ctrl-P enable line search
let g:ctrlp_extensions = ['line']

" Gotta have some syntax
syntax on

set background=dark
" set termguicolors
colorscheme quantum


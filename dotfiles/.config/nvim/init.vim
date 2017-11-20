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

Plug 'SirVer/ultisnips'

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}



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
set termguicolors
colorscheme quantum

set tabstop=4
set shiftwidth=4
set softtabstop=4


" Love line numbers
set number

" Automatically writes files on :GoBuild, etc...
set autowrite

" Testing configs from https://github.com/fatih/vim-go-tutorial
"
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b  :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)

let g:go_highlight_types = 1
let g:go_hightlight_fields = 1

" Autocomplete stuff?
let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_skip_check = 1
set runtimepath+=/home/rynojvr/.local/share/nvim/plugged/deoplete.nvim/
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#use_cache = 1 
let g:deoplete#sources#go#cgo = 1 

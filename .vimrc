"
" My VIM config
"
" Author: Alex Kalinkin 
" Email: alex@kalinkin.info
" Source: https://github.com/akalinkin/vimconf
"

set nocompatible              " be iMproved, required
filetype off                  " required
set number                    " show line numbers
set relativenumber            " Show relative line numbers
set laststatus=2              " allways show status line
set ruler                     " show line and col position

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Use Git allways use Git (highlights source changes)
Plugin 'airblade/vim-gitgutter'
" File tree
Plugin 'scrooloose/nerdtree'
" Git marks in NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Markdown syntax highlighting
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Solidity language (Ethereum smart contracts)
Plugin 'tomlion/vim-solidity'
Plugin 'editorconfig/editorconfig-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Set the project directory to the Directory where Vim was started
set path=$PWD/**

" Open NERDTree every time VIM invoked
"au VimEnter * NERDTree
" Show hidden files in tree
let NERDTreeShowHidden=1
" Close NerdTree when open file
let NERDTreeQuitOnOpen = 1
" Auto close tab if the only remaining window is NerdTree (Not works)
""" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

" Csortcut for NERDTree = 'e
let mapleader = ","
map <leader>e :NERDTreeToggle<CR>

" Set non-printable chars visible
"scriptencoding utf-8
"set encoding=utf-8

"set listchars+=space:·
"set listchars=eol:¶,tab:⇥·,trail:~,extends:>,precedes:<,space:·
" augroup setList
" 	au!
"	au BufWinEnter *  set list
" augroup END

" For *.sol (Solidity SmartContracts) Set tabstop=4, shiftwidth=4, expandtab
au BufEnter *.sol set sw=4 ts=4 et
" Requires Quramy/tsuquyomi bundle
" autocmd FileType typescript setl omnifunc=tsuquyomi#complete

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
   syntax on
endif


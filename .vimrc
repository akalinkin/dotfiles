"
" My VIM config
"
" Author: Alex Kalinkin 
" Email: alex@kalinkin.info
" Source: https://github.com/akalinkin/dotfiles
"

set nocompatible               " be iMproved, required
filetype off                   " required
set number relativenumber      " show line numbers and relative numbers (offsets)
set laststatus=2               " allways show status line
set ruler                      " show line and col position
"set foldmethod=manual	       " allow manual folding
set nofoldenable               " disable folding
set wildmode=longest,list,full " autocomplete stuff

set termguicolors              " enable true color
" some vim in tmux fixes
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
set t_Co=256


" Persistant undo (saves buffer edit history between sessions)
" Make sure the directory exists
set undodir=~/.vim/undodir
set undofile

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dense-analysis/ale'
Bundle 'OmniSharp/omnisharp-vim'
Plugin 'fatih/vim-go'
" Solidity language (Ethereum smart contracts)
"Plugin 'tomlion/vim-solidity'
"Plugin 'editorconfig/editorconfig-vim'

" Presentaion mode
Plugin 'sotte/presenting.vim'

" Powerline
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" OmniSharp won't work without this setting
filetype plugin on
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
set tabstop=4
set colorcolumn=121
set wildmenu

:imap jj <Esc>
nnoremap ; :
"nnoremap : ;

" Make j & k linewise {{{2
"
" turn off linewise keys -- normally, the `j' and `k' keys move the cursor down
" one entire line. with line wrapping on, this can cause the cursor to actually
" skip a few lines on the screen because it's moving from line N to line N+1 in
" the file. I want this to act more visually -- I want `down' to mean the next
" line on the screen
map j gj
map k gk

" Show hidden files in tree
let NERDTreeShowHidden=1

" Csortcut for NERDTree = 'e
let mapleader = ","
map <leader>e :NERDTreeToggle<CR>

" VimWiki markdown
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" http://stackoverflow.com/questions/1005/getting-root-permissions-on-a-file-inside-of-vi
cmap w!! w !sudo tee >/dev/null %

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

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set russian input in Vim using `Ctrl+^`
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" Set russian spell check with `ё`
:setlocal spell spelllang=ru_yo,en_us
set nospell

" Change cursor to: block (NORMAL), beam(INSERT), block underscore(REPLACE)
let &t_SI = "\e[6 q" 	"SI = INSERT mode
let &t_SR = "\e[4 q" 	"SR = REPLACE mode
let &t_EI = "\e[2 q"	"EI = NORMAL mode (ELSE)

" Reset cursor on start (required if your term has changed cursor)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Set the type lookup function to use the preview window instead of echoing it
let g:OmniSharp_typeLookupInPreview = 1
let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_loglevel = 'debug'

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5
" Highlight types
let g:OmniSharp_highlight_types = 2

" Don't autoselect first omnicomplete option, show options even if there is
" only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
"set completeopt=longest,menuone,preview
set completeopt=menuone,noinsert,noselect,preview
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_force_refresh_on_context_changed = 1

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsExpandTrigger = "<C-l>"
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Enable snippet completion
let g:OmniSharp_want_snippet = 1

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono).
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the
    " cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs	nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>


    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>



python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Snippets
nnoremap ,html :-1read $HOME/.vim/snippets/.blank.html<CR>5jf>a

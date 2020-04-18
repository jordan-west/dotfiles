" Start vim in home directory
cd ~

" Essential options
syntax on
filetype plugin indent on
set nocompatible
set backspace=indent,eol,start

" Integrate with OS clipboard
set clipboard=unnamed

" History/backup files
set history=200
set backup
set undodir=~/.vim/.undo
set directory=~/.vim/.swp
set backupdir=~/.vim/.backup
set viminfo+=n~/.vim/.viminfo
set runtimepath+=~/.vim/

" Spacing options
set tabstop=4
set shiftwidth=4
set expandtab

" Search options
set showmatch
set incsearch
set hlsearch

" Interface options
set number
set relativenumber
set ruler
set cursorline
set showmode
set wildmenu

" gVim options
set guifont=Consolas:h10
set guioptions=

" Theme options
color dracula

" Build
nnoremap <C-B> :make<CR>

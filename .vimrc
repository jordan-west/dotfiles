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
set sessionoptions+=resize,winpos,winsize

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

let g:netrw_bufsettings = 'noma nomod renu nowrap ro nobl'

" gVim options
set guifont=Consolas:h11
set guioptions=

" Theme options
color dracula

" Build
nnoremap <C-B> :make<CR>
" Run
nnoremap <F5> :!start remedybg.exe start-debugging<CR>
" Explorer
nnoremap <C-E> :Explore<CR>

" Header
autocmd BufNewFile *.[ch] call InsertCHeader()
" Maximize window on session load
autocmd SessionLoadPost * simalt ~x

function! InsertCHeader()
    exe "normal!0i/*"
    exe "normal!o Copyright (C) " . strftime("%Y") . " Jordan West - all rights reserved."
    exe "normal!o/"
endfunction

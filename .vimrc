" Custom settings
syntax on " Use syntax highlighting
color dracula " Set vim colors
set clipboard=unnamed " Using os clipboard
set backspace=indent,eol,start " Backspace works intuitively
set number " Show line numbers
set cursorline " Highlight the current line
set showmatch " Highlight matching brackets
set incsearch " Search as characters are entered
set hlsearch " Highlight matches
set noswapfile " Get rid of that pesky swap file
filetype plugin indent on " Indent based on filetype - see indent folder
set tabstop=4
set shiftwidth=4
set expandtab

" Additional settings
let g:bufferline_echo=0

" Mappings
map <C-b> :NERDTreeToggle<CR>

" Set up pathogen
execute pathogen#infect()

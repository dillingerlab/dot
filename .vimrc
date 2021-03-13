"Author: Austin Dillinger
""Description: A personal .vimrc for programming


"Essentials Starters
""---------------------------------------------------------------------------
" Use Pathogen - https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Use ALE - https://github.com/dense-analysis/ale


"Advanced Must Haves
""---------------------------------------------------------------------------
set incsearch                           " Jump to word whilst searching
set hlsearch                            " Highlight found searchesset
set showcmd                             " Show me what I'm typing
set showmode                            " Show current mode.
set viminfo='20,<1000                   " Give vim a bigger buffer


"Preferences
""---------------------------------------------------------------------------
set noerrorbells                        " No beeps
set vb t_vb=                            " Stop visualbell flashing

set paste

set et
set tabstop=4
set shiftwidth=4
set expandtab

set laststatus=2                        " Always display status line

set noswapfile                          " Don't use swapfile
set nobackup                            " Don't create annoying backup files
set nowritebackup
source $VIMRUNTIME/vimrc_example.vim    " Keep track of where a user leaves a file

set spell
set spell spelllang=en_us

"Mapping/Keycodes
""---------------------------------------------------------------------------


"Visuals
""---------------------------------------------------------------------------
colo elflord
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/
set ruler                               "display cursor position
set cmdheight=2                         "increases command window height


"AUTO COMMANDS
""---------------------------------------------------------------------------
autocmd Filetype make setlocal noexpandtab


" Macros
""---------------------------------------------------------------------------
let @s='2Gdwis '
let @q='6G4dd'


"VIM TEMPLATES
""---------------------------------------------------------------------------
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.py 0r ~/.vim/templates/python.sh
    autocmd BufNewFile *.sh 0r ~/.vim/templates/bash.sh
  augroup END
endif


" Notes
""---------------------------------------------------------------------------
"   >       indent
"   <       indent
" vim -p    tabbed vim
" gt        next tab
" gT        previous tab
" dw        delete word
" yw        yank word
" :tabedit
" :tabclose
" :!        run command in bash ie :w, :! pytest

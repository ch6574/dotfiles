" CGH 2024-12-19
set nocompatible

" Plugins
filetype off                                        " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim                   " Vundle prelude
call vundle#begin()                                 " ^
Plugin 'VundleVim/Vundle.vim'                       " ^
Plugin 'altercation/vim-colors-solarized'           " Colors
Plugin 'dense-analysis/ale'                         " Syntax checker
Plugin 'tpope/vim-fugitive'                         " Git
Plugin 'vim-airline/vim-airline'                    " Status bar
Plugin 'vim-airline/vim-airline-themes'             " Status bar
call vundle#end()                                   " Req'd for vundle
filetype plugin indent on                           " ^

" Bring in defaults
source $VIMRUNTIME/defaults.vim

" Basic settings
set autoindent                                      " Align the next line automatically
set hlsearch                                        " Highligh search results
set relativenumber                                  " Enable relative line numbers
set tabstop=4 shiftwidth=4 expandtab                " Tabs to 4 spaces
" Colors (bad spelling is bold white on red)
set background=dark
colorscheme solarized
hi SpellBad cterm=bold ctermfg=015 ctermbg=009
" Whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨

" vim-airline
let g:airline#extensions#branch#enabled = 1         " Show git branch
let g:airline#extensions#tabline#enabled = 1        " Enable tabline of all buffers
let g:airline#extensions#tabline#fnamemod = ':t'    " Disable file paths in the tabline
let g:airline_powerline_fonts = 1                   " Need patched fonts (apt install powerline)

" F2 pastemode, F3 spellcheck, F4 show hidden, F5 trim whitespace, F6 re-indent
set pastetoggle=<F2>
nnoremap <silent> <F3> :setlocal spell!<CR>
nnoremap <silent> <F4> :set list!<CR>
nnoremap <silent> <F5> :call TrimWhitespace()<CR>
nnoremap <silent> <F6> gg=G<CR>

" Buffer navigation
nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bprevious<CR>

" Tab navigation
nnoremap <silent> <C-t><up>    :tabr<cr>
nnoremap <silent> <C-t><down>  :tabl<cr>
nnoremap <silent> <C-t><left>  :tabp<cr>
nnoremap <silent> <C-t><right> :tabn<cr>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
"   vim +BundleInstall +qall

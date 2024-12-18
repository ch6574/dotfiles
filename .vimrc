" CGH 2024-12-17

" Plugins
set nocompatible
filetype off                      " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim " Vundle prelude
call vundle#begin()               " ^
Plugin 'VundleVim/Vundle.vim'     " ^

Plugin 'altercation/vim-colors-solarized'
Plugin 'dense-analysis/ale'       " Syntax checker
Plugin 'tpope/vim-fugitive'       " Git
Plugin 'vim-airline/vim-airline'  " Status bar
Plugin 'vim-airline/vim-airline-themes'

" Post-vundle
call vundle#end()                 " Req'd for vundle
filetype plugin indent on         " ^

" Basic settings
set autoindent                    " Align the next line automatically
set backspace=2
set hlsearch                      " Highligh search results
set incsearch                     " Search like modern browsers
set magic                         " Grep style regex on (not egrep)
set nocompatible                  " Eliminate backwards-compatability
set noeol bin                     " No newline on file end for binaries
set relativenumber                " Enable relative line numbers
set ruler                         " Turn on the ruler
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab " Tabs to spaces
syntax on                         " Syntax highlighting

" Key bindings
" Pastemode with F2
set pastetoggle=<F2>
" Strip trainling whitespace with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Re-indent with F7
nnoremap <silent> <F7> mzgg=G`z<CR>

" Colors
set background=dark
colorscheme solarized

" vim-airline
set laststatus=2
set noshowmode
set ttimeoutlen=50
let g:airline_powerline_fonts = 1                   " need terminal to use patched fonts (apt install powerline)
let g:airline#extensions#branch#enabled = 1         " show git branch
let g:airline#extensions#tabline#enabled = 1        " enable airline tabline
let g:airline#extensions#tabline#fnamemod = ':t'    " disable file paths in the tab
let g:airline_solarized_bg='dark'                   " matching theme

" buffer navigation
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" tab navigation
nnoremap <silent> <C-t><up>    :tabr<cr>
nnoremap <silent> <C-t><down>  :tabl<cr>
nnoremap <silent> <C-t><left>  :tabp<cr>
nnoremap <silent> <C-t><right> :tabn<cr>

" whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨

"
" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
"   vim +BundleInstall +qall
"

" CGH 2018-12-16
"

" Plugins
set nocompatible
filetype off                      " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim " Vundle prelude
call vundle#begin()               " ^
Plugin 'VundleVim/Vundle.vim'     " ^

Plugin 'vim-colors-solarized'
Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'valloric/YouCompleteMe'
Plugin 'vim-scripts/peaksea'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

" Post-vundle
call vundle#end()                 " Req'd for vundle
filetype plugin indent on         " ^

" Basic settings
set autoindent                  " Align the next line automatically
set backspace=2
set hlsearch                    " Highligh search results
set incsearch                   " Search like modern browsers
set magic                       " Grep style regex on (not egrep)
set nocompatible                " Eliminate backwards-compatability
set noeol bin                   " No newline on file end for binaries
"set number                      " Enable line numbers
set relativenumber              " Enable relative line numbers
set ruler                       " Turn on the ruler
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab " Tabs to spaces
syntax on                       " Syntax highlighting

" Key bindings
set pastetoggle=<F2>          " Pastemode with F2
" Strip trainling whitespace with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Re-indent with F7
nnoremap <silent> <F7> mzgg=G`z<CR>

" Colours
set background=dark
"colorscheme  peaksea
colorscheme solarized

" vim-airline
set laststatus=2
set noshowmode
set ttimeoutlen=50

"
" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"   vim +BundleInstall +qall
"

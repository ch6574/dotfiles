" CGH 2015-02-21
"

" Plugins
filetype off                  " Req'd for vundle
set rtp+=~/.vim/bundle/vundle " Vundle prelude
call vundle#rc()              " ^

Bundle 'gmarik/vundle'

Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
"Bundle 'valloric/YouCompleteMe'
Bundle 'vim-scripts/peaksea'
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'

" Post-vundle
filetype plugin indent on     " Req'd for vundle

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
colorscheme  peaksea
set background=dark

" vim-airline
set laststatus=2
set noshowmode
set ttimeoutlen=50

"
" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"   vim +BundleInstall +qall
"

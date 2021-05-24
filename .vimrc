" CGH 2021-05-01

" Plugins
set nocompatible
filetype off                      " Req'd for vundle
set rtp+=~/.vim/bundle/Vundle.vim " Vundle prelude
call vundle#begin()               " ^
Plugin 'VundleVim/Vundle.vim'     " ^

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'       " git
Plugin 'vim-airline/vim-airline'  " Status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'     " Syntax checker
Plugin 'vivien/vim-linux-coding-style'

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
"set number                        " Enable line numbers
set relativenumber                " Enable relative line numbers
set ruler                         " Turn on the ruler
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab " Tabs to spaces
syntax on                         " Syntax highlighting

" Key bindings
set pastetoggle=<F2>              " Pastemode with F2
" Strip trainling whitespace with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Re-indent with F7
nnoremap <silent> <F7> mzgg=G`z<CR>

" Colours
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" vim-airline
set laststatus=2
set noshowmode
set ttimeoutlen=50
"let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1 " need terminal to use patched fonts
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
" tabline
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
"let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
"let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
"let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab 
"let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
"let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers on the tabline
"let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
"let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
"let g:airline#extensions#tabline#show_tab_nr = 0       " disables tab numbers
"let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird orange arrow on the tabline

" tab navigation
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨

"
" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
"   vim +BundleInstall +qall
"

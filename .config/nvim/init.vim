" CGH 2024-08-02

" Plugins
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin("~/.vim/plugged")
Plug 'Mofiqul/dracula.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Basics
set autoindent                    " Align the next line automatically
set hlsearch                      " Highligh search results
set nocompatible                  " Eliminate backwards-compatability
set relativenumber                " Enable relative line numbers
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab " Tabs to spaces
syntax on                         " Syntax highlighting

colorscheme dracula

" Airline
let g:airline_powerline_fonts = 1 " need terminal to use patched fonts
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab

" whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨


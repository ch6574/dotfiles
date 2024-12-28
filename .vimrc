" CGH 2024-12-22
set nocompatible

" Plugins
filetype off                                        " Required for vundle
set rtp+=~/.vim/bundle/Vundle.vim                   " Vundle prelude
call vundle#begin()                                 " ^
Plugin 'VundleVim/Vundle.vim'                       " ^
Plugin 'altercation/vim-colors-solarized'           " Colors
Plugin 'dense-analysis/ale'                         " Linters / Formatters (apt install black flake8 mypy shfmt)
Plugin 'tpope/vim-fugitive'                         " Git
Plugin 'vim-airline/vim-airline'                    " Status bar
Plugin 'vim-airline/vim-airline-themes'             " Status bar
call vundle#end()                                   " Required for vundle
filetype plugin indent on                           " ^

" Bring in defaults, undo any I don't like
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set noshowcmd

" Basic settings
set autoindent                                      " Align the next line automatically
set hlsearch                                        " Highlight search results
set mouse=a                                         " Mouse integration
set number                                          " Line numbering
set relativenumber                                  " Relative line numbers
set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab " Tabs to 4 spaces
set wildmode=longest,list,full                      " Command tab completion
" Colors
set background=dark
colorscheme solarized
" Whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨

" Spellcheck underline bad words
hi SpellBad cterm=underline

" vim-airline
let g:airline#extensions#branch#enabled = 1         " Show git branch
let g:airline#extensions#tabline#enabled = 1        " Enable tabline of all buffers
let g:airline#extensions#tabline#fnamemod = ':t'    " Disable file paths in the tabline
let g:airline_powerline_fonts = 1                   " Need patched fonts (apt install powerline)

" ALE (linters are always on, fixers need explicitly activating)
let g:ale_echo_msg_format = '%linter%: %code: %%s'
let g:ale_fixers = {
\   "kotlin":   ['ktlint'],
\   "python":   ["black"],
\   "sh":       ["shfmt"],
\   '*':        ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_python_flake8_options = '--max-line-length=88'    " Same as Black
let g:ale_sign_info = "ℹ️"
let g:ale_sign_error = "🛑"
let g:ale_sign_warning = "⚠️"
let g:ale_sign_style_error = "🛑"
let g:ale_sign_style_warning = "⚠️"

" F2 pastemode, F3 spellcheck, F4 show hidden, F5 format/fix
set pastetoggle=<F2>
nnoremap <silent> <F3> :set spell!<CR>
nnoremap <silent> <F4> :set list!<CR>
nnoremap <silent> <F5> :ALEFix<CR>

" Buffer navigation
nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bprevious<CR>

" Tab navigation
nnoremap <silent> <C-t><up>    :tabr<cr>
nnoremap <silent> <C-t><down>  :tabl<cr>
nnoremap <silent> <C-t><left>  :tabp<cr>
nnoremap <silent> <C-t><right> :tabn<cr>

" To bootstrap all this, first install vundle, then boot vim
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
"   vim +BundleInstall +qall

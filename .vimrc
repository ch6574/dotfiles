" CGH 2025-01-29

"
" Plugins
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
call plug#begin()
Plug 'lifepillar/vim-solarized8'                    " Solarized 24bit
Plug 'lifepillar/vim-gruvbox8'                      " Gruvbox 24bit
Plug 'dense-analysis/ale'                           " Linters / Formatters (apt install black flake8 mypy shfmt)
Plug 'tpope/vim-fugitive'                           " Git
Plug 'vim-airline/vim-airline'                      " Status bar
Plug 'vim-airline/vim-airline-themes'               " Status bar
Plug 'vimpostor/vim-lumen'                          " Follow light/dark mode
" Local only plugins
if filereadable(glob('~/.vimrc.localplug'))
    source ~/.vimrc.localplug
endif
call plug#end()

"
" Bring in defaults, then undo any I don't like
"
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set noshowcmd

"
" Basic settings
"
set autoindent                                      " Align the next line automatically
set cursorline cursorlineopt=number                 " Highlight current line (only gutter)
set foldmethod=syntax                               " Folding style
set hlsearch                                        " Highlight search results
set ignorecase smartcase                            " Searching case insensitive, unless caps involved
set nofoldenable                                    " Folding off by default
set mouse=a                                         " Mouse integration
set path+=**                                        " Subdirectories in ':find'
set number relativenumber                           " Relative line numbering
set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab " Tabs to 4 spaces
set wildmode=longest,list,full                      " Command tab completion

" Whitespace
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨

" Colors
set background=dark
if (&term =~ '256color' || &term =~ 'ghostty')
    set termguicolors
    " silent! colorscheme solarized8                  " Ignore if not installed
    silent! colorscheme gruvbox8                     " Ignore if not installed
else
    colorscheme sorbet
endif

" Spellcheck underline bad words
hi SpellBad cterm=underline
augroup localspell
    autocmd!
    " Always spellcheck these filetypes
    autocmd Filetype gitcommit,markdown setlocal spell
augroup END

"
" Plugins
"
" vim-airline
let g:airline#extensions#ale#enabled = 1            " Linting
let g:airline#extensions#branch#enabled = 1         " Git
let g:airline#extensions#tabline#enabled = 1        " Tabline for all buffers
let g:airline#extensions#tabline#fnamemod = ':t'    " Disable file paths in tabline
let g:airline_powerline_fonts = 1                   " Need patched fonts (apt install powerline)

" ALE (add to default linters, plus explicitly turn on any fixers)
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_linters = {
\   'json':     ['jq'],
\}
let g:ale_fixers = {
\   'java':     ['google_java_format'],
\   'json':     ['jq'],
\   'kotlin':   ['ktlint'],
\   'python':   ['black'],
\   'sh':       ['shfmt'],
\   '*':        ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_kotlin_ktlint_options = '--log-level error'       " Eliminate ktlint noise
let g:ale_python_flake8_options = '--max-line-length=88'    " Same as Black

"
" Key mapping
"
" F2 pastemode, F3 spellcheck, F4 show hidden, F5 format/fix
set pastetoggle=<F2>
nnoremap <silent> <F3> :setlocal spell!<CR>
nnoremap <silent> <F4> :setlocal list!<CR>
nnoremap <silent> <F5> :ALEFix<CR>

" Folding
nnoremap <space> za

" Buffer navigation
nnoremap <silent>   <tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bnext<CR>
nnoremap <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR>:write<CR>:endif<CR>:bprevious<CR>

" Tab navigation
nnoremap <silent> <C-t><up>    :tabr<cr>
nnoremap <silent> <C-t><down>  :tabl<cr>
nnoremap <silent> <C-t><left>  :tabp<cr>
nnoremap <silent> <C-t><right> :tabn<cr>

"
" Local only settings
"
if filereadable(glob('~/.vimrc.local'))
    source ~/.vimrc.local
endif

if has("gui_gtk3")
    set guifont=Hack\ 12
    set printfont=Hack\ 10
elseif has("gui_macvim")
    set guifont=Hack:h12,Source\ Code\ Pro:h12
    set printfont=Hack:h10,Source\ Code\ Pro:h10
endif
set lines=60 columns=180
silent! colorscheme gruvbox8

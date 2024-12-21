alias bat='batcat'
alias binds='bind -P | grep "can be found on"'
alias psu='ps -fu ${USER}'

# some more ls aliases
alias l='ls -CF'    # List by columns, append indicator
alias ll='ls -lF'   # long format, append indicator
alias la='ls -A'    # all but '.' and '..'
alias lla='ls -AlF' # all, long format, append indicator

alias path='echo -e ${PATH//:/\\n}'

alias yeardone='d=$(date +%j) && y=$(date +%j -d "Dec 31") && printf "Today is day ${d}/${y}, which is $(bc <<< "scale=1; ${d}*100/${y}")%% of $(date +%Y)!\n"'


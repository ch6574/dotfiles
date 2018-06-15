alias binds='bind -P | grep "can be found on"'
alias psu='ps -fu ${USER}'

# some more ls aliases
alias l='ls --color=auto -CF'    # List by columns, append indicator
alias ll='ls --color=auto -lF'   # long format, append indicator
alias la='ls --color=auto -A'    # all but '.' and '..'
alias lla='ls --color=auto -AlF' # all, long format, append indicator

# Always enable colored `grep` output`
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias path='echo -e ${PATH//:/\\n}'

alias dirsize='du -s .[!.]* * | sort -h'

alias yeardone='d=$(date +%j) && y=$(date +%j -d "Dec 31") && printf "Today is day ${d}/${y}, which is $(bc <<< "scale=1; ${d}*100/${y}")%% of $(date +%Y)!\n"'


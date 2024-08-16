# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case "${-}" in
    *i*) ;;
      *) return;;
esac

#-------------------------------------------------------------------------------
# Tmux, do this at the start as we 'exec'
#-------------------------------------------------------------------------------

tmux_check ()
{
    local session
    local sessions
    if [[ -z "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
        # tmux exists, and we're not inside of it...
        sessions=$(tmux list-sessions 2>/dev/null)
        if [[ -n "$sessions" ]]; then
            printf "Tmux active:\\n%s\\n" "$sessions"
        fi
        # Use a default session named after the hostname
        session=${HOSTNAME%%.*}
        if tmux has-session -t "$session" 2>/dev/null; then
            # Session already running, prompt to re-attach if no client
            if [[ $(tmux list-clients -t "$session" | wc -l) -eq 0 ]]; then
                read -n1 -rp "Attach tmux session '$session'? " yn
                printf "\\n"
                yn=${yn:-y}
                case "$yn" in
                    [Yy]*) exec tmux attach-session -t "$session" ;;
                esac
            fi
        else
            # Prompt to start the default session
            read -n1 -rp "Start tmux session '$session'? " yn
            printf "\\n"
            yn=${yn:-y}
            case "$yn" in
                [Yy]*) exec tmux new-session -s "$session" ;;
            esac
        fi
    fi
}

if [[ ${TERM_PROGRAM} != "vscode" ]]; then
    tmux_check
fi

#-------------------------------------------------------------------------------
# Shell usability settings
#-------------------------------------------------------------------------------

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# condense multi-line commands to one line in history
shopt -s cmdhist

# flush to history file on each prompt
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# ignore certain commands for history
HISTIGNORE='&:ls:l:ll:fg:bg:history:exit'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Dont match hidden files unless you specify the "." explicitly
bind 'set match-hidden-files off'

# Put a "/" after dir names and "*" after executables
bind 'set visible-stats on'

# prevent directing output onto an existing file
set -o noclobber

# 3x CTRL+D to exit
IGNOREEOF=2

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot="$(cat /etc/debian_chroot)"
fi

# Core dumps
ulimit -c unlimited

#-------------------------------------------------------------------------------
# Colors!
#-------------------------------------------------------------------------------

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [[ -n "${force_color_prompt}" ]]; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt='yes'
    else
        color_prompt=
    fi
fi

if [[ "${color_prompt}" = yes ]]; then
    # Colours
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    standout=$(tput smso)
    no_standout=$(tput rmso)
    reset_video=$(tput sgr0)

    # Prompt
    PS1="\\[$green\\]╭─► \\[$yellow\\] \\w \$(__git_ps1 '(%s)')\\n\\[${green}\\]╰\\[${standout}\\]\\D{%R %Z}\\[${no_standout}\\] ${debian_chroot:+($debian_chroot)}\\u@\\h \\[${standout}\\]\${?##0}\\[${no_standout}\\] $ \\[${reset_video}\\]"
    unset green yellow standout no_standout reset_video
else
    # Monochrome prompt
    case "${TERM}" in
        xterm*|rxvt*) PS1="╭─►  \\w \$(__git_ps1 '(%s)')\\n╰\\D{%R %Z} ${debian_chroot:+($debian_chroot)}\\u@\\h \${##0} $ " ;;
                   *) PS1="${debian_chroot:+($debian_chroot)}\\u@\\h \\w $ " ;;
   esac
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# perhaps use tput tsl / tput fsl?
case "${TERM}" in
    xterm*|rxvt*) PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]${PS1}" ;;
esac

# ls in color
if [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Man pages in color
case "${TERM}" in
    *color)
        # Man pages in colour
        export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)                   # red
        export LESS_TERMCAP_md=$(tput bold; tput setaf 1)                   # red
        export LESS_TERMCAP_me=$(tput sgr0)
        export LESS_TERMCAP_se=$(tput sgr0)
        export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)     # yellow on blue
        export LESS_TERMCAP_ue=$(tput sgr0)
        export LESS_TERMCAP_us=$(tput bold; tput setaf 2)                   # green
        ;;
esac
#-------------------------------------------------------------------------------
# Aliases and functions
#-------------------------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -r /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions
if [[ -r ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

clock() {
    local places=('New York'         'UTC' 'London'        'Bangalore'     'Hong Kong'      'Tokyo'      'Melbourne')
    local zones=( 'America/New_York' 'UTC' 'Europe/London' 'Asia/Calcutta' 'Asia/Hong_Kong' 'Asia/Tokyo' 'Australia/Melbourne')
    local count=0
    zdump "${zones[@]}" | while read -r times; do
        printf "%10s | %s\\n" "${places[${count}]}" "${times}"
        ((count++))
    done
}

refresh-env() {
    if [ -n "${TMUX}" ]; then
        echo "Reloading environment from TMUX"
        eval "$(tmux showenv -s)"
    fi
}

macgrep() {
    egrep -i "##.*##|${1}" ~/syncthing-enc/"MAC Addresses.txt"
}

# dotfiles in git
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles="git --git-dir='${HOME}/.dotfiles' --work-tree='${HOME}'"
dotfiles-install() {
  (
    set -ex
    dotfiles init
    dotfiles config --local status.showUntrackedFiles no
    dotfiles remote add origin "git@github.com:ch6574/dotfiles.git"
    dotfiles fetch
    dotfiles checkout origin/master --force --track
    dotfiles update-index --assume-unchanged LICENSE README.md
    rm ~/LICENSE ~/README.md
  )
}
_completion_loader git
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main dotfiles

# fzf
if [[ -r /usr/share/bash-completion/completions/fzf ]]; then
    . /usr/share/bash-completion/completions/fzf
fi
if [[ -r /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

#-------------------------------------------------------------------------------
# environment variables etc
#-------------------------------------------------------------------------------

export BLOCK_SIZE='si'                 # Display block sizes of 1000 (not 1024)
                                       # i.e. 'ls -l' will report 1,000,000 = 1M
export GCC_COLORS='true'               # Will have color highlights on gcc errors

#-------------------------------------------------------------------------------
# Done!
#-------------------------------------------------------------------------------

# Show stats on screen
uptime


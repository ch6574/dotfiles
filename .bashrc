# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case "${-}" in
    *i*) ;;
      *) return;;
esac

#-------------------------------------------------------------------------------
# Shell usability settings
#-------------------------------------------------------------------------------

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedup

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


#-------------------------------------------------------------------------------
# Colours!
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
        TERM='xterm-256color'
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

    # Colour grep if supported
    ( echo chk | grep --color=auto chk &> /dev/null ) && export GREP_OPTIONS='--color=auto'

    # Prompt
    PS1="\[$green\]╭─► \[$yellow\] \w\n\[${green}\]╰\[${standout}\]\D{%R %Z}\[${no_standout}\] ${debian_chroot:+($debian_chroot)}\u@\h \[${standout}\]\${?##0}\[${no_standout}\] $ \[${reset_video}\]"
else
    # Monochrome prompt
    case "${TERM}" in
        xterm*|rxvt*) PS1="╭─►  \w\n╰\D{%R %Z} ${debian_chroot:+($debian_chroot)}\u@\h \${##0} $ " ;;
                   *) PS1="${debian_chroot:+($debian_chroot)}\u@\h \w $ " ;;
   esac
fi
unset color_prompt force_color_prompt green yellow standout no_standout reset_video

# If this is an xterm set the title to user@host:dir
# perhaps use tput tsl / tput fsl?
case "${TERM}" in
    xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]${PS1}" ;;
esac

# Man pages in color
case "${TERM}" in
    xterm-*color)
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [[ -r ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

clock() {
    local places=('Salt Lake City' 'New York'   'UTC' 'London'        'Bangalore'     'Hong Kong'      'Tokyo'      'Melbourne')
    local zones=( 'US/Mountain'    'US/Eastern' 'UTC' 'Europe/London' 'Asia/Calcutta' 'Asia/Hong_Kong' 'Asia/Tokyo' 'Australia/Melbourne')
    local count=0
    zdump ${zones[*]} | while read times; do
        printf "%14s | %s\n" "${places[${count}]}" "${times}"
        ((count++))
    done
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi


#-------------------------------------------------------------------------------
# PATH's, environment variables etc
#-------------------------------------------------------------------------------

# Augment a PATH type variable. Ignore if arg is not a directory or is already included.
#
# arg 1 - a variable name (not variable)
# arg 2 - a directory to prefix it with
#
# _pathadd() {
#     if [[ ! -d "${2}" ]] || [[ "${!1}" =~ (^|:)"${2}"(:|$) ]]; then
#         return
#     fi
#     eval ${1}="${2}${!1:+:${!1}}"
# }

# export PERL_LOCAL_LIB_ROOT="${HOME}/perl5"
# export PERL_MB_OPT="--install_base ${HOME}/perl5"
# export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"

# _pathadd 'PERL5LIB' "${HOME}/perl5/lib/perl5"
# _pathadd 'PERL5LIB' "${HOME}/perl5/lib/perl5/x86_64-linux-gnu-thread-multi"
# _pathadd 'PATH' "${HOME}/perl5/bin"

# unset _pathadd

export BLOCK_SIZE='si'                 # Display block sizes of 1000 (not 1024)
                                       # i.e. 'ls -l' will report 1,000,000 = 1M
export GCC_COLORS='true'               # Will have color highlights on gcc errors

#-------------------------------------------------------------------------------
# Done!
#-------------------------------------------------------------------------------

# Show stats on screen
uptime


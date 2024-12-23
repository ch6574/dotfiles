# If not running interactively, don't do anything
case "${-}" in
*i*) ;;
*) return ;;
esac

#
# Includes
#
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
	. /etc/bash_completion
fi

# fzf
if [[ -r /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
	. /usr/share/doc/fzf/examples/key-bindings.bash
fi

#
# Functions
#
macgrep() {
	grep -Ei "##.*##|${1}" "${HOME}/syncthing-enc/MAC Addresses.txt"
}

# dotfiles in git
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}"'
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

#
# Shell usability
#
HISTCONTROL="ignoreboth:erasedups"               # Ignore leading space entries, also duplicates
HISTSIZE="10000"                                 # In memory
HISTFILESIZE="20000"                             # On disk
HISTIGNORE="&:l:la:ll:lla:ls:fg:bg:history:exit" #
bind "set match-hidden-files off"                # Don't match hidden files unless you specify the "." explicitly
bind "set visible-stats on"                      # Put a "/" after dir names and "*" after executables
set -o noclobber                                 # Don't overwrite existing files
shopt -s histappend                              # Append history, don't overwrite

# Prompt
case "${TERM}" in
*color)
	COLOR_DEF=$(tput sgr0)    # reset
	COLOR_ERR=$(tput setaf 1) # red
	COLOR_DIR=$(tput setaf 2) # green
	COLOR_TIM=$(tput setaf 6) # cyan
	COLOR_GIT=$(tput setaf 4) # blue

	# Color prompt "$" in red if non-zero exit code
	__exitstatus() { [[ $? == 0 ]] && echo "\$" || echo "${COLOR_ERR}\$${COLOR_DEF}"; }

	PS1='${COLOR_DIR}╭─► \w\n╰ ${COLOR_TIM}\D{%R %Z} ${COLOR_DEF}\u${COLOR_GIT}$(__git_ps1 " (%s)")${COLOR_DEF} $(__exitstatus) '
	;;
*)
	PS1='╭─► \w\n╰ \D{%R %Z} \u$(__git_ps1 " (%s)") $ '
	;;
esac

# Environment
export BAT_THEME="Solarized (dark)"               #
export BLOCK_SIZE="si"                            # GNU utilities use 1000, not 1024
export EDITOR="${VISUAL}"                         #
export GCC_COLORS="true"                          # GCC errors in color
export MANPAGER="less -R --use-color -Dd+r -Du+b" # Man pages in color
export VISUAL="vim"                               #

# Aliases
alias bat='batcat'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -AlF'
alias ls='ls --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias psu='ps -fu ${USER}'

#
# Done!
#
uptime

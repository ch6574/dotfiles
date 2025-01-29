# If not running interactively, don't do anything
case "${-}" in
*i*) ;;
*) return ;;
esac

#
# Includes
#
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
	source /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
	source /etc/bash_completion
fi

# fzf (apt install fzf)
if [[ -r /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
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
bind "set completion-ignore-case on"
bind "set match-hidden-files off"                # Don't match hidden files unless you specify the "." explicitly
bind "set show-all-if-ambiguous on"              # Show multiple matches, don't just ring the bell
bind "set visible-stats on"                      # Put a "/" after dir names and "*" after executables
bind "TAB:menu-complete"                         # Cycle through multiple matches
set -o noclobber                                 # Don't overwrite existing files
shopt -s histappend                              # Append history, don't overwrite

# Colors (if available) enclosed in \[ and \]
printf -v COLOR_DEF '\x01%s\x02' "$(tput sgr0)"    # reset
printf -v COLOR_ERR '\x01%s\x02' "$(tput setaf 1)" # red
printf -v COLOR_DIR '\x01%s\x02' "$(tput setaf 2)" # green
printf -v COLOR_TIM '\x01%s\x02' "$(tput setaf 6)" # cyan
printf -v COLOR_GIT '\x01%s\x02' "$(tput setaf 4)" # blue

# Prompt "$" in red if non-zero exit code
__exitstatus() { [[ $? == 0 ]] && printf '$' || printf '%s$%s' "${COLOR_ERR}" "${COLOR_DEF}"; }
PS1="${COLOR_DIR}╭─► \\w\\n╰ ${COLOR_TIM}\\D{%R %Z} ${COLOR_DEF}\\u${COLOR_GIT}\$(__git_ps1 ' (%s)')${COLOR_DEF} \$(__exitstatus) "

# Environment
export BAT_THEME="gruvbox-dark"            # Until ubuntu gets newer batcat
export BAT_THEME_DARK="gruvbox-dark"       #
export BAT_THEME_LIGHT="gruvbox-light"     #
export BLOCK_SIZE="si"                     # GNU utilities use 1000, not 1024
export EDITOR="vim"                        #
export GCC_COLORS="true"                   # GCC errors in color
export LESS="-R --use-color -Dd+r\$Du+b\$" # Less color support (red bold, blue underlined)
export MANROFFOPT="-P -c"                  # Man pages in color
export VISUAL="${EDITOR}"                  #

# Aliases
alias bat='batcat'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias l='ls -CF'
alias la='ls -ACF'
alias ll='ls -lF'
alias lla='ls -AlF'
alias ls='ls --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias psu='ps -fu ${USER}'

#
# Local only settings
#
if [[ -r "${HOME}/bin" ]]; then
	export PATH="${HOME}/bin:${PATH}"
fi

if [[ -r "${HOME}/.bashrc.local" ]]; then
	source "${HOME}/.bashrc.local"
fi

#
# Done!
#
uptime

# If not running interactively, don't do anything
case "${-}" in
*i*) ;;
*) return ;;
esac

#
# Functions
#

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

print_banner() {
	print -- ${(l:COLUMNS::-:)}
	print $1
}

#
# Shell usability
#
HISTCONTROL="ignoreboth:erasedups"               # Ignore leading space entries, also duplicates
HISTSIZE="10000"                                 # In memory
HISTFILESIZE="20000"                             # On disk
HISTIGNORE="&:l:la:ll:lla:ls:fg:bg:history:exit" #
setopt appendhistory                             # Append history, don't overwrite
setopt incappendhistory                          # Flush history to file immediately
set -o noclobber                                 # Don't overwrite existing files

# Keys
bindkey '\e[H' beginning-of-line               # Home
bindkey '\e[F' end-of-line                     # End
bindkey '\e[5~' beginning-of-buffer-or-history # Page Up
bindkey '\e[6~' end-of-buffer-or-history       # Page Down

# Prompt
setopt promptsubst
autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:git:*' formats ' %F{blue}(%b)%f' # The git branch in blue
NL=$'\n'
PROMPT="%F{green}╭─► %~${NL}╰ %F{cyan}%D{%R %Z}%f %n\${vcs_info_msg_0_} %(?..%F{red})%# %f"

# Environment
export BAT_THEME_DARK="gruvbox-dark"       #
export BAT_THEME_LIGHT="gruvbox-light"     #
export BLOCK_SIZE="si"                     # GNU utilities use 1000, not 1024
export EDITOR="vim"                        #
export GCC_COLORS="true"                   # GCC errors in color
export LESS="-R --use-color -Dd+r\$Du+b\$" # Less color support (red bold, blue underlined)
export MANROFFOPT="-P -c"                  # Man pages in color
export VISUAL="${EDITOR}"                  #

# Aliases
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
# Optional local installs
#
__LATEST_TOOLS="true"
__LATEST_TOOLS="${__LATEST_TOOLS} && print_banner '...updating Applications' && open -a Latest"

# Usually brew is on the path via /etc/paths.d/homebrew
type brew &> /dev/null && {
	eval "$(/opt/homebrew/bin/brew shellenv)"
	export HOMEBREW_NO_ENV_HINTS=1
	__LATEST_TOOLS="${__LATEST_TOOLS} && print_banner '...updating Brew' && brew update && brew upgrade && brew cleanup"
} || echo "Missing brew on this host!"

type mise &> /dev/null && {
	eval "$(mise activate zsh)"
	__LATEST_TOOLS="${__LATEST_TOOLS} && print_banner '...updating Mise' && mise upgrade && mise prune"
} || echo "Missing mise on this host!"

alias latest-tools="${__LATEST_TOOLS}"

#
# Optional integrations
#
type fzf &> /dev/null && {
	eval "$(fzf --zsh)"
	export FZF_DEFAULT_OPTS="--style full"
	type rg  &> /dev/null && export FZF_DEFAULT_COMMAND="rg --files"     || echo "Missing rg on this host!"
	type bat &> /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat {}'" || echo "Missing bat on this host!"
} || echo "Missing fzf on this host!"

#
# Local only settings
#
if [[ -r "${HOME}/bin" ]]; then
	export PATH="${HOME}/bin:${PATH}"
fi

if [[ -r "${HOME}/.zshrc.local" ]]; then
	source "${HOME}/.zshrc.local"
fi

#
# Done!
#
autoload -Uz compinit && compinit
uptime

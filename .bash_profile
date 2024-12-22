# ~/.bash_profile: executed by bash(1) for login shells.

if [[ -r ~/.profile ]]; then . ~/.profile; fi

# If running interactively then read ~/.bashrc
case "${-}" in
*i*)
	if [[ -r ~/.bashrc ]]; then . ~/.bashrc; fi
	;;
esac

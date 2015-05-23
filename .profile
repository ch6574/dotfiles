# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 007

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# environment variables availble after login
export EDITOR='vim'

export WFICA_OPTS='-span a'            # GS Citrix session to span all screens

export LC_TIME='en_DK.UTF-8'           # ISO 8601 dates
export LC_MONETARY='en_US.UTF-8'       # USD
export LC_PAPER='en_US.UTF-8'          # 'Letter' paper
export LC_ADDRESS='en_US.UTF-8'        # US style
export LC_TELEPHONE='en_US.UTF-8'      # US style


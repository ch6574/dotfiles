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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# environment variables availble after login
export EDITOR='vim'
export GPGKEY='165FDE7C'               # My current GPG key

#export LC_TIME='en_DK.UTF-8'           # ISO 8601 dates
#export LC_MONETARY='en_US.UTF-8'       # USD
#export LC_PAPER='en_US.UTF-8'          # 'Letter' paper
#export LC_ADDRESS='en_US.UTF-8'        # US style
#export LC_TELEPHONE='en_US.UTF-8'      # US style

case "$(hostname)" in
    lord-gnome|gnome-jr)
        # Default PulseAudio devices
        pactl set-default-source alsa_input.usb-FIFINE_Microphones_FIFINE_K670_Microphone_REV1.0-00.analog-stereo
        pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
        ;;
esac


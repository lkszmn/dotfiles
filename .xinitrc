#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

# Load Xresources from system
if [ -f $sysresources ]; then

    xrdb -merge $sysresources
fi

# Load XModmap from System
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# Load User specific resources
if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

# Load XModMap of user
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Load Xinit startup programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set keybard map
setxkbmap -layout us -variant altgr-intl -option nodeadkeys


# Start window manager
exec awesome 

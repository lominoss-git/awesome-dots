#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

DEFAULT_SESSION="awesome"

case "$1" in
	"qtile") qtile start ;;
	"bspwm") exec bspwm ;;
	*) exec "$DEFAULT_SESSION" ;;
esac

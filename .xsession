#!/bin/sh

setxkbmap -option caps:swapescape

# Set up an icon tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &

# Set default X cursor to pointer
xsetroot -cursor_name left_ptr

# Set background
feh --bg-fill --no-fehbh ~/.wallpapers/pexels-paul-ijsendoorn-33041.jpg

# Fire up screensaver
xscreensaver -no-splash &

# Power Management
xfce4-power-manager &

exec xmonad

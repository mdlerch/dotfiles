#!/bin/bash

sh .fehbg
xmodmap .Xmodmap &
urxvtd -q -o -f &
synclient MaxSpeed=1.25
synclient VertEdgeScroll=1
 
xsetroot -cursor_name left_ptr

if [ -f ~/.Xdefaults ]; then
  xrdb -merge ~/.Xdefaults
fi

if [ -f ~/.Xmodmap ]; then
  xmodmap  ~/.Xmodmap
fi

conky -c ~/.conky/conkyrc &
conky -c ~/.conky/conky-sched &
conky -c ~/.conky/conky-event &

xmonad

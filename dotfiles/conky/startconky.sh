#!/bin/bash

sleep 10 #time (in s) for the DE to start; use ~20 for Gnome or KDE, less for Xfce/LXDE etc
exec conky -c ~/.conky/rings & # the main conky with rings
sleep 8 #time for the main conky to start; needed so that the smaller ones draw above not below (probably can be lower, but we still have to wait 5s for the rings to avoid segfaults)
exec conky -c ~/.conky/cpu &
sleep 1
exec conky -c ~/.conky/mem &
conky -c ~/.conky/notes &

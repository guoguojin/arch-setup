#!/usr/bin/env bash

if pgrep -x "xautolock" > /dev/null
then
    killall xautolock
    notify-send 'xautolock off'
else
    xautolock -time 10 -locker 'betterlockscreen -l --off 300'&
    notify-send 'xautolock on'
fi

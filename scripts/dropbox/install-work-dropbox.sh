#!/usr/bin/env bash

mkdir -p $HOME/.dropbox-bl
cd $HOME/.dropbox-bl

if [[ ! -d .dropbox-dist ]]; then
    wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
fi

HOME=$PWD ./.dropbox-dist/dropboxd &



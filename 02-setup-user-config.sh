#!/usr/bin/env bash

cwd=$(dirname "$0")
source $cwd/funcs.sh

echo "Checking out personal files for setting up computer"
mkdir -p $HOME/code/personal/github.com/guoguojin

if [ -d $HOME/code/personal/dircolors-solarized ]; then
	rm -rf $HOME/code/personal/dircolors-solarized
fi

git clone https://github.com/seebi/dircolors-solarized.git $HOME/code/personal/dircolors-solarized

if [ -d $HOME/.fonts ]; then 
	rm -rf $HOME/.fonts
fi

git clone git@github.com:guoguojin/fonts.git $HOME/.fonts/
sudo fc-cache -f

if [ -d $HOME/.tmux/plugins/tpm ]; then
	rm -rf $HOME/.tmux/plugins/tpm
fi

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

TIMESTAMP=$(date +%Y%m%dT%H%M%S)

if [ ! -d $HOME/.config/terminator ]; then
	mkdir -p $HOME/.config/terminator
fi

backup_and_create $PWD/dotfiles/terminator/config $HOME/.config/terminator/config
backup_and_create $PWD/dotfiles/tmux/tmux.conf $HOME/.tmux.conf

backup_and_create $PWD/bin/dropbox-multi-account $HOME/bin/dropbox-multi-account
backup_and_create $PWD/bin/gitlab-release $HOME/bin/gitlab-release
backup_and_create $PWD/bin/pandoc-word-pagebreak $HOME/bin/pandoc-word-pagebreak
backup_and_create $PWD/bin/psgrep $HOME/bin/psgrep
backup_and_create $PWD/bin/start-consul $HOME/bin/start-consul
backup_and_create $PWD/bin/start-plantuml-server $HOME/bin/start-plantuml-server
backup_and_create $PWD/bin/start-redis $HOME/bin/start-redis
backup_and_create $PWD/bin/start-sqlserver $HOME/bin/start-sqlserver
backup_and_create $PWD/bin/terminator-quake $HOME/bin/terminator-quake
backup_and_create $PWD/bin/tm $HOME/bin/tm
backup_and_create $PWD/bin/unlock-bl-docs $HOME/bin/unlock-bl-docs
backup_and_create $PWD/bin/unlock-c064 $HOME/bin/unlock-c064
backup_and_create $PWD/bin/unlock-tomb $HOME/bin/unlock-tomb
backup_and_create $PWD/bin/kill-gpu-process $HOME/bin/kill-gpu-process
backup_and_create $PWD/bin/delete-untagged-docker-images $HOME/bin/delete-untagged-docker-images
backup_and_create $PWD/bin/set-polybar-network-device $HOME/bin/set-polybar-network-device
backup_and_create $PWD/bin/setup-go-project $HOME/bin/setup-go-project
backup_and_create $PWD/bin/whatsapp $HOME/bin/whatsapp

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# set up vim
echo "Setting up Vim"

backup_and_create $PWD/dotfiles/vim/vim-plug/.vimrc $HOME/.vimrc
backup_and_create $PWD/dotfiles/vim/vim-plug/.vimrc.local $HOME/.vimrc.local
backup_and_create $PWD/dotfiles/vim/vim-plug/.vimrc.local.bundles $HOME/.vimrc.local.bundles

vim +PlugInstall +qall

# Setup task warrior
echo "Setting up task warrior"
mkdir -p $HOME/.task
backup_and_create $PWD/dotfiles/taskwarrior/taskrc $HOME/.taskrc

# Setup zsh 
echo "Setting up Zsh"
yay -S --noconfirm --needed zsh 
yay -S --noconfirm --needed zplug 
yay -S --noconfirm --needed zsh-syntax-highlighting 
yay -S --noconfirm --needed zsh-theme-powerlevel10k 
yay -S --noconfirm --needed zsh-completions
yay -S --noconfirm --needed oh-my-zsh-git 

backup_and_create $PWD/dotfiles/zsh/zshrc $HOME/.zshrc
backup_and_create $PWD/dotfiles/zsh/zsh_custom $HOME/.zsh_custom

echo "Configuring Powerlevel10k Zsh theme"
mkdir -p $HOME/.config/p10k

backup_and_create $PWD/dotfiles/powerlevel10k/p10k.zsh $HOME/.p10k.zsh
backup_and_create $PWD/dotfiles/powerlevel10k/task.zsh $HOME/.config/p10k/task.zsh
backup_and_create $PWD/dotfiles/powerlevel10k/java_version.zsh $HOME/.config/p10k/java_version.zsh

echo "Changing shell to Zsh"
chsh -s /bin/zsh

#!/usr/bin/env bash

cwd=$(dirname "$0")
source $cwd/funcs.sh

echo "Checking out personal files for setting up computer"
mkdir -p $HOME/code/personal/github.com/guoguojin

git clone https://github.com/seebi/dircolors-solarized.git $HOME/code/personal/dircolors-solarized
git clone git@github.com:guoguojin/fonts.git $HOME/.fonts/
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

TIMESTAMP=$(date +%Y%m%dT%H%M%S)

backup_and_create $cwd/dotfiles/terminator/config $HOME/.config/terminator/config
backup_and_create $cwd/dotfiles/tmux/tmux.conf $HOME/.tmux.conf

# Set up restic for backups
echo "Setting up restic backups"

backup_and_create $cwd/restic/restic-backup $HOME/bin/restic-backup
backup_and_create $cwd/restic/restic-backup-remote $HOME/bin/restic-backup-remote
backup_and_create $cwd/restic/restic-snapshots $HOME/bin/restic-snapshots
backup_and_create $cwd/restic/restic-snapshots-remote $HOME/bin/restic-snapshots-remote
backup_and_create $cwd/restic/restic-unlock $HOME/bin/restic-unlock
backup_and_create $cwd/restic/restic-unlock-remote $HOME/bin/restic-unlock-remote
backup_and_create $cwd/restic/restic-cleanup $HOME/bin/restic-cleanup
backup_and_create $cwd/restic/restic-backup-files $HOME/bin/restic-backup-files
backup_and_create $cwd/restic/restic-excludes $HOME/restic-excludes

## If we have access to the restic backups, then we should restore them
if [[ -f $HOME/.restic.env ]] && [[ -z ${RESTIC_BACKUP_REPO} ]]; then
  source $HOME/.restic.env

  sudo mkdir -p /restore
  sudo chown -R tanq:tanq /restore

  restic -r ${RESTIC_BACKUP_REPO} restore latest --target /restore
fi

backup_and_create $cwd/bin/dropbox-multi-account $HOME/bin/dropbox-multi-account
backup_and_create $cwd/bin/gitlab-release $HOME/bin/gitlab-release
backup_and_create $cwd/bin/pandoc-word-pagebreak $HOME/bin/pandoc-word-pagebreak
backup_and_create $cwd/bin/psgrep $HOME/bin/psgrep
backup_and_create $cwd/bin/start-consul $HOME/bin/start-consul
backup_and_create $cwd/bin/start-plantuml-server $HOME/bin/start-plantuml-server
backup_and_create $cwd/bin/start-redis $HOME/bin/start-redis
backup_and_create $cwd/bin/start-sqlserver $HOME/bin/start-sqlserver
backup_and_create $cwd/bin/terminator-quake $HOME/bin/terminator-quake
backup_and_create $cwd/bin/tm $HOME/bin/tm
backup_and_create $cwd/bin/unlock-bl-docs $HOME/bin/unlock-bl-docs
backup_and_create $cwd/bin/unlock-c064 $HOME/bin/unlock-c064
backup_and_create $cwd/bin/unlock-tomb $HOME/bin/unlock-tomb
backup_and_create $cwd/bin/kill-gpu-process $HOME/bin/kill-gpu-process
backup_and_create $cwd/bin/delete-untagged-docker-images $HOME/bin/delete-untagged-docker-images
backup_and_create $cwd/bin/set-polybar-network-device $HOME/bin/set-polybar-network-device
backup_and_create $cwd/bin/setup-go-project $HOME/bin/setup-go-project

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# set up vim
echo "Setting up Vim"

backup_and_create $cwd/dotfiles/vim/vim-plug/.vimrc $HOME/.vimrc
backup_and_create $cwd/dotfiles/vim/vim-plug/.vimrc.local $HOME/.vimrc.local
backup_and_create $cwd/dotfiles/vim/vim-plug/.vimrc.local.bundles $HOME/.vimrc.local.bundles

vim +PlugInstall +qall

# Setup task warrior
echo "Setting up task warrior"
mkdir -p $HOME/.task
backup_and_create $cwd/dotfiles/taskwarrior/taskrc $HOME/.taskrc

# Setup zsh 
echo "Configuring Zsh"
backup_and_create $cwd/dotfiles/zsh/zshrc $HOME/.zshrc
backup_and_create $cwd/dotfiles/zsh/zsh_custom $HOME/.zsh_custom

echo "Configuring Powerlevel10k Zsh theme"
mkdir -p $HOME/.config/p10k

backup_and_create $cwd/dotfiles/powerlevel10k/p10k.zsh $HOME/.p10k.zsh
backup_and_create $cwd/dotfiles/powerlevel10k/task.zsh $HOME/.config/p10k/task.zsh
backup_and_create $cwd/dotfiles/powerlevel10k/java_version.zsh $HOME/.config/p10k/java_version.zsh

echo "Changing shell to Zsh"
chsh -s /bin/zsh

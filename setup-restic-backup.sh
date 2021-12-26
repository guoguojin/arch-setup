#!/usr/bin/env bash

cwd=$(dirname "$0")
source $cwd/funcs.sh
yay -S --noconfirm --needed restic 
# Set up restic for backups
echo "Setting up restic backups"

backup_and_create $PWD/restic/restic-backup $HOME/bin/restic-backup
backup_and_create $PWD/restic/restic-backup-remote $HOME/bin/restic-backup-remote
backup_and_create $PWD/restic/restic-snapshots $HOME/bin/restic-snapshots
backup_and_create $PWD/restic/restic-snapshots-remote $HOME/bin/restic-snapshots-remote
backup_and_create $PWD/restic/restic-unlock $HOME/bin/restic-unlock
backup_and_create $PWD/restic/restic-unlock-remote $HOME/bin/restic-unlock-remote
backup_and_create $PWD/restic/restic-cleanup $HOME/bin/restic-cleanup
backup_and_create $PWD/restic/restic-backup-files $HOME/bin/restic-backup-files
backup_and_create $PWD/restic/restic-excludes $HOME/restic-excludes

## If we have access to the restic backups, then we should restore them
if [[ -f $HOME/.restic.env ]] && [[ -z ${RESTIC_BACKUP_REPO} ]]; then
  source $HOME/.restic.env

  sudo mkdir -p /restore
  sudo chown -R tanq:tanq /restore

  restic -r ${RESTIC_BACKUP_REPO} restore latest --target /restore
fi

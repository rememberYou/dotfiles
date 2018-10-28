#!/bin/bash
#
# I'm using Borg which is a deduplicating backup program with optional
# compression and authenticated encryption for my daily backups.
#
# SEE: https://borgbackup.readthedocs.io/en/stable/
#
# This script provides myself to backup my home directory to my HDD with
# my USB Flash Drive that contains the key to permit it.
#
# With that configuration, you need both devices to create, read, update, delete
# the data.
#
# SEE: https://luka.strizic.info/post/Local-BorgBackup-automation-with-udev/
#
# To use this script, don't forget to install `borg` and `udev` packages, and
# modify the directories, passwords with your own.
# Also, this script using symlink devices to allow the execution of the script
# only if both devices are connected.
#
# For that, write rules in your /etc/udev/rules.d/ and check that the
# backup-disk and backup-key symlinks appears in your /dev/ when you connect
# your HDD and USB Flash Drive.

BACKUP_DISK="/dev/backup-disk"
BACKUP_KEY="/dev/backup-key"

REPOSITORY="/run/media/someone/Data/borg"
KEYDIR="/run/media/someone/2EEE-4A55/.config/borg/keys/"
PASSCOMMAND='pass show backup/borg'
COMPRESSION="lz4"
ARCHIVE="{hostname}-{now:%Y-%m-%d}"
TARGETS+="/home/someone"
EXCLUDE+="--exclude '/home/*/.cache/*' "
EXCLUDE+="--exclude '/home/*/.mozilla/*' "
EXCLUDE+="--exclude '/home/*/.thumbnails' "
EXCLUDE+="--exclude '/home/*/qemu/*' "
EXCLUDE+="--exclude '/home/*/Dropbox/*' "
EXCLUDE+="--exclude '/home/*/Maildir/*' "
EXCLUDE+="--exclude '*.pyc' "
EXCLUDE+="--exclude '*~'"

if [ ! -b $BACKUP_DISK ] || [ ! -b $BACKUP_DISK ]; then
    echo "Connect the HDD with the USB Flash drive to make your backups."
    exit 1
fi

# Make the variables accessible to the borg executable.
export BORG_KEYS_DIR=$KEYDIR
export BORG_PASSCOMMAND=$PASSCOMMAND

# Some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup."
notify-send "Starting backup."

# Create an archive and log: files list, return code:
borg create --verbose --list --show-rc --stats --progress \
     --compression $COMPRESSION                           \
     --exclude-caches                                     \
     $EXCLUDE                                             \
     $REPOSITORY::$ARCHIVE                                \
     $TARGETS

# Verifies the consistency of a repository and the corresponding archives:
info "Checking backup."
notify-send "Checking backup."

borg check --verbose --last=1 $REPOSITORY

info "Backup finished."
notify-send "Backup finished."

exit 0

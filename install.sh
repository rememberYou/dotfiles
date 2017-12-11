#!/bin/bash
#
# Simple script that creates symbolic links with the `stow` command for all the
# folders on the repository for your system.

if ! which stow &> /dev/null; then
    echo "You need to first install: stow" > /dev/stderr
    exit 1
fi

echo -e "Stowing directories...\n"

DIRS=`ls -l --time-style="long-iso" . | egrep '^d' | awk '{print $8}'`

for DIR in $DIRS
do
    if [[ "$DIR" != "assets" ]]; then
	echo "stowing $DIR"
	stow ${DIR}
    fi
done

echo -e "\nDone."

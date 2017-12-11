#!/bin/bash
#
# Simple script that creates symbolic links with the `stow` command for all the
# configuration files on the repository for your system.

DIRS=`ls -l --time-style="long-iso" . | egrep '^d' | awk '{print $8}'`

# Creates symbolinc links to configuration files.
function create_symlinks() {
    for DIR in $DIRS
    do
	if [[ "$DIR" != "assets" ]]; then
	    echo "stowing $DIR"
	    stow ${DIR}
	fi
    done
}

# Deletes symbolinc links to configuration files.
function delete_symlinks() {
    for DIR in $DIRS
    do
	if [[ "$DIR" != "assets" ]]; then
	    echo "delete stowing $DIR"
	    stow -D ${DIR}
	fi
    done
}

# Checks if `stow` is installed.
function is_stow_installed() {
    if ! which stow &> /dev/null; then
	echo "You need to first install: stow" > /dev/stderr
	exit 1
    fi
}

# Documentation of the program.
function menu() {
    echo "Written by: Terencio Agozzino (rememberYou)"
    echo -e "      Mail: terencio.agozzino@gmail.com\n"

    echo "stowsym: stowsym [iu]"
    echo -e "    Creates and deletes symbolic links with stow.\n"

    echo "    Options:"
    echo "      -i  Installation of configuration files by creating symbolic links."
    echo "      -d  Deletion of configuration files by removing symbolic links."
    echo -e "      -h  Help to use the script.\n"

    echo -e "    By default, -h were specified.\n"

    echo "    Exit Status:"
    echo "    Returns 0 unless an invalid option is given or the current directory"
    echo "    cannot be read."
}

while [ "$1" != "" ]; do
    case $1 in
	-d | --delete )
	    is_stow_installed
	    echo -e "Deletion of symbolinc links to configuration files...\n"
	    delete_symlinks
	    echo -e "\nDone."
	    exit
	    ;;
        -i | --install )
	    is_stow_installed
	    echo -e "Creation of symbolic links to configuration files...\n"
	    create_symlinks
	    echo -e "\nDone."
	    exit
	    ;;
        -h | --help )
	    menu
	    exit
    esac
    shift
done

menu

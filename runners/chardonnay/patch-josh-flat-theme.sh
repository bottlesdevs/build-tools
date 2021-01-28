#!/bin/bash

# ---------------------------------------
# patch-josh-flat-theme.sh
# This script fetch and apply the josh flat theme patch
# ---------------------------------------

# Utilities
# ---------------------------------------
expand_bg="\e[K"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
black="\e[30m"
bold="\e[1m"
reset="\e[0m"

while getopts r: option
do
	case "${option}" in
		r) release=${OPTARG};;
	esac
done

function title {
	PREFIX="\n$bold-----"
	SUFFIX="--$reset"
	echo -e "$PREFIX $1 $SUFFIX"
}

function print_execution {
	if $1; then
		echo -e "$green_bg$bold$black-- $1$reset"
	else
		echo -e "$red_bg$bold$black-- Operation failed for: $1$reset"
	fi
}

# Fetching josh flat theme patch
# ---------------------------------------
title "Fetching josh flat theme patch"
print_execution "cd $HOME/work/wine/extra"
print_execution "wget https://raw.githubusercontent.com/Frogging-Family/wine-tkg-git/235e94b9c182b16d16322e83632d53c052aaf143/wine-tkg-git/wine-tkg-patches/misc/josh-flat-theme.patch"

# Applying josh flat theme patch
# ---------------------------------------
title "Applying josh flat theme patch"
print_execution "cd $HOME/work/wine/wine"
patch -p1 < ../extra/josh-flat-theme.patch

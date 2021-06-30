#!/bin/bash

# -------------------------------------------------------
# package.sh
# This script package the dist file in a tarball
# -------------------------------------------------------

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

# Package gamemode build
# ---------------------------------------
title "Package gamemode build"
print_execution "mv $HOME/work/gamemode/gamemode-build/dist $HOME/work/gamemode/gamemode-${release}"
archive_name="gamemode-${release}.tar.gz"
print_execution "tar zcvf ${archive_name} gamemode-${release}"
print_execution "ls gamemode*.tar.gz"

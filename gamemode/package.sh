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

# Preparing tarball
# ---------------------------------------
title "Preparing tarball"
print_execution "cd $HOME/work/gamemode/dist"
print_execution "rsync -avh winebuild_64/* winebuild"

# Determining gamemode version
# ---------------------------------------
title "Determining gamemode version"
print_execution "cd $HOME/work/gamemode/dist"
gm_version=$(cat VERSION)
print_execution "echo Gamemode version is: $gm_version"

# Package gamemode build
# ---------------------------------------
title "Package gamemode build"
print_execution "mv $HOME/work/gamemode/dist $HOME/work/gamemode/gamemode-${gm_version}"
archive_name="gamemode-${gm_version}.tar.gz"
print_execution "tar zcvf ${archive_name} gamemode-${gm_version}"
print_execution "ls gamemode*.tar.gz"

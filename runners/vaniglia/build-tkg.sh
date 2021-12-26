#!/bin/bash

# ---------------------------------------
# build-tkg.sh
# This script build wine using wine-tkg
# Author: mirkobrombin
# License: MIT
# ---------------------------------------

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

# Preparing build directory
# ---------------------------------------
title "Preparing build directory"
print_execution "cp wine-tkg.cfg $HOME/.config/frogminer/wine-tkg.cfg"

# Fetching the latest version of wine-tkg
# ---------------------------------------
title "Fetching the latest version of wine-tkg"
print_execution "cd $HOME/work/wine/wine/winebuild"
print_execution "git clone https://github.com/Frogging-Family/wine-tkg-git.git"

# Starting the build
# ---------------------------------------
title "Starting the build"
print_execution "cd $HOME/work/wine/wine/winebuild/wine-tkg-git/wine-tkg-git"
print_execution "./non-makepkg-build.sh"

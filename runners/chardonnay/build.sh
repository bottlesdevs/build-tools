#!/bin/bash

# --------------------------------------------------
# build.sh
# This script build wine for 64bit with 32bit support
# --------------------------------------------------

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

# Configuring Wine
# ---------------------------------------
title "Configuring Wine"
print_execution "cd ~/runner/work/wine/wine"
print_execution "./configure \
  --with-wine64=~/runner/work/wine/winesource_64 \
  --prefix=~/runner/work/wine/winebuild_combo"
# --with-wine-tools=~/runner/work/wine/winesource_32

# Building Wine
# ---------------------------------------
title "Building Wine"
print_execution "cd ~/runner/work/wine/wine"
print_execution "make -j$(nproc)"
print_execution "make install"

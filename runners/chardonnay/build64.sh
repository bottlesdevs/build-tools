#!/bin/bash

# ---------------------------------------
# build64.sh
# This script build wine for 64bit
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

# Configuring Wine 64
# ---------------------------------------
title "Configuring Wine 64"
print_execution "cd ~/runner/work/wine/wine/wine_64_source"
print_execution "../configure CFLAGS='-march=native -O3 -pipe -fstack-protector-strong' \
--enable-win64  \
--prefix=~/runner/work/wine/wine/winebuild_64"

# Building Wine 64
# ---------------------------------------
title "Building Wine 64"
print_execution "cd ~/runner/work/wine/wine/wine_64_source"
print_execution "make -j$(nproc)"
print_execution "make install"

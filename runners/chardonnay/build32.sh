#!/bin/bash

# ---------------------------------------
# build32.sh
# This script build wine for 32bit
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

# Configuring Wine 32
# ---------------------------------------
title "Configuring Wine 32"
print_execution "cd $HOME/runner/work/wine/wine/wine_32_source"
print_execution "../configure $(CFLAGS="-march=native -O3 -pipe -fstack-protector-strong") \
--with-wine64=$HOME/runner/work/wine/wine/wine_64_source \
--with-wine-tools=$HOME/runner/work/wine/wine/wine_tools \
--prefix=$HOME/runner/work/wine/wine/winebuild"

# Building Wine 32
# ---------------------------------------
title "Building Wine 32"
print_execution "cd $HOME/runner/work/wine/wine/wine_32_source"
print_execution "make -j$(nproc)"
print_execution "make install"

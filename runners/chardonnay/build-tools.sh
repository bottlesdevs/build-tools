#!/bin/bash

# ---------------------------------------
# build-tools.sh
# This script build the wine tools
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

# Configuring Wine Tools
# ---------------------------------------
title "Configuring Wine Tools"
print_execution "cd $HOME/runner/work/wine/wine/wine_tools"
print_execution "../configure"

# Building Wine Tools
# ---------------------------------------
title "Building Wine Tools"
print_execution "make __tooldeps__ "

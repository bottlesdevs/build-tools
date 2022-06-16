#!/bin/bash

# -------------------------------------------------
# build.sh
# This script build the runtime using runtimezilla
# Author: mirkobrombin
# License: MIT
# -------------------------------------------------

# Utilities
# -------------------------------------------------
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

# Build runtime
# -------------------------------------------------
title "Building runtime"
print_execution "cd runtimezilla"
print_execution "python3 runtimezilla --recipe ../recipe.yml --output $HOME/runtime"


# EAC runtime
# -------------------------------------------------
# Note: support for manual files addition planned for runtimezilla
title "Adding EAC runtime"
print_execution "rm $HOME/runtime/runtime.tar.gz"
print_execution "cd $HOME/runtime"
print_execution "cp -a $HOME/work/runtime/runtime/EasyAntiCheatRuntime EasyAntiCheatRuntime"
print_execution "tar -czvf runtime.tar.gz runtime"

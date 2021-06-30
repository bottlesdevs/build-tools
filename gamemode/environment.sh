#!/bin/bash

# ---------------------------------------
# environment.sh
# This script configure the build environment
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

# Preparing directories
# ---------------------------------------
title "Preparing directories"
print_execution "mkdir -p $HOME/work"

# Enabling i386 architecture
# ---------------------------------------
title "Enabling i386 architecture"
print_execution "sudo dpkg --add-architecture i386"

# Installing dependencies
# ---------------------------------------
title "Installing dependencies"
print_execution "sudo apt update && sudo apt install -y meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev build-essential"

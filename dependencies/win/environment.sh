#!/bin/bash

# ---------------------------------------
# environment.sh
# This script configure the build environment
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

# Installing aptitude
# ---------------------------------------
title "Installing aptitude"
print_execution "apt install -y aptitude"

# Installing packages
# ---------------------------------------
title "Installing packages"
print_execution "aptitude install -y \
python3 \
python3-pip \
cabextract \
p7zip-full"

# Installing requirements
# ---------------------------------------
title "Installing requirements"
print_execution "python3 -m pip install -r requirements.txt --user"

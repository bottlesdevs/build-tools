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

# Enabling i386 architecture
# ---------------------------------------
title "Enabling i386 architecture"
print_execution "sudo dpkg --add-architecture i386"

# Adding repositories
# ---------------------------------------
title "Adding repositories"
print_execution "sudo apt -y install software-properties-common"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/vkd3d -y"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport -y"
print_execution "sudo apt-get -qq update"

# Installing aptitude
# ---------------------------------------
title "Installing aptitude"
print_execution "sudo apt install -y aptitude"

# Installing runtimezilla
# ---------------------------------------
title "Installing runtimezilla"
version="$(curl -s https://api.github.com/repos/mirkobrombin/runtimezilla/releases/latest | grep tag_name | cut -d '"' -f 4)"
print_execution "curl -L https://github.com/mirkobrombin/runtimezilla/archive/refs/tags/$version.tar.gz -o runtimezilla.tar.gz"
print_execution "tar -xzf runtimezilla.tar.gz"
print_execution "rm -f runtimezilla.tar.gz"
print_execution "mv runtimezilla-$version runtimezilla"

# Installing requirements
# ---------------------------------------
title "Installing requirements"
print_execution "python3 -m pip install -r runtimezilla/requirements.txt"

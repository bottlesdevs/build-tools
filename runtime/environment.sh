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
  		exit 1
	fi
}

if [ "$#" -ne 3 ]; then
	title "Wrong number of arguments: ./environment.sh [runtime_version] [runtime_OS] [runtime_OS_version]"
	exit 1
fi

# Enabling i386 architecture
# ---------------------------------------
title "Enabling i386 architecture"
print_execution "sudo dpkg --add-architecture i386"

# Installing dependencies
# ---------------------------------------
title "Installing dependencies"
print_execution "sudo apt-get -qq update"
print_execution "sudo apt install -y git aptitude python3 python3-pip python3-venv jq"

# Installing runtimezilla
# ---------------------------------------
title "Installing runtimezilla"
version="$(curl -s https://api.github.com/repos/mirkobrombin/runtimezilla/releases/latest | grep tag_name | cut -d '"' -f 4)"
print_execution "curl -L https://github.com/mirkobrombin/runtimezilla/archive/refs/tags/$version.tar.gz -o runtimezilla.tar.gz"
print_execution "tar -xzf runtimezilla.tar.gz"
print_execution "rm -f runtimezilla.tar.gz"
print_execution "mv runtimezilla-$version runtimezilla"

# Setting up venv
# ---------------------------------------
title "Setting up venv"
print_execution "python3 -m venv .venv"
print_execution "source .venv/bin/activate"

# Installing Python dependencies
# ---------------------------------------
title "Installing Python dependencies"
print_execution "python3 -m pip install yq"
print_execution "python3 -m pip install -r runtimezilla/requirements.txt"

# Updating recipe.yml
# ---------------------------------------
title "Updating recipe.yml"
print_execution "yq -i -y .properties.version=\"$1\" recipe.yml"
print_execution "yq -i -y .system.name=\"$2\" recipe.yml"
print_execution "yq -i -y .system.min_version=\"$3\" recipe.yml"
print_execution "yq -i -y .system.max_version=\"$3\" recipe.yml"

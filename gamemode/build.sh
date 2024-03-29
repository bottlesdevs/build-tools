#!/bin/bash

# ---------------------------------------
# build.sh
# This script build gamemode
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

while getopts r: option
do
	case "${option}" in
		r) release=${OPTARG};;
	esac
done

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

# Cloning source code
# ---------------------------------------
title "Cloning source code"
print_execution "cd $HOME/work/gamemode"

if [[ -z ${release+x} ]]
then
	print_execution "echo No release declared, fallback to git"
	print_execution "git clone https://github.com/FeralInteractive/gamemode.git"
	print_execution "mv gamemode gamemode-build"
else
	print_execution "echo Requested the $release release"
	print_execution "wget -O gamemode.tar.gz  https://github.com/FeralInteractive/gamemode/archive/$release.tar.gz"
	print_execution "tar zxvf gamemode.tar.gz"
	print_execution "rm gamemode.tar.gz"
	print_execution "mv gamemode-$release gamemode-build"
fi

# Building gamemode
# ---------------------------------------
title "Building gamemode"
print_execution "cd $HOME/work/gamemode/gamemode-build"
print_execution "mkdir -p $HOME/work/gamemode/gamemode-build/dist"
print_execution "export TRAVIS=true"
print_execution "./bootstrap.sh --prefix $HOME/work/gamemode/gamemode-build/dist"

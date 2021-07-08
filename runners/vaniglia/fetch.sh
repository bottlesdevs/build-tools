#!/bin/bash

# -------------------------------------------------------
# fetch.sh
# This script fetch the wine source code from git or 
# releases
# -------------------------------------------------------

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

# Fetch Wine source code
# ---------------------------------------
title "Fetch Wine source code"
print_execution "cd $HOME/work/wine"

if [[ -z ${release+x} ]]
then
	print_execution "echo No release declared, fallback on git"
	if test -d "$HOME/work/wine/.git"; then
		print_execution "cd $HOME/work/wine/wine"
		print_execution "git pull"
	else
		print_execution "git clone https://github.com/bottlesdevs/wine.git"
	fi
else
	print_execution "echo Requested the $release release"
	print_execution "wget -O wine_source.tar.gz https://github.com/wine-mirror/wine/archive/refs/tags/wine-${release}.tar.gz"
	print_execution "tar -zxvf wine_source.tar.gz"
	print_execution "mv $HOME/work/wine/wine-wine-${release}/* wine"
fi

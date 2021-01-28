#!/bin/bash

# -------------------------------------------------------
# package.sh
# This script combine winebuild_32 and winebuild_64 files
# and create a new redistributable package
# -------------------------------------------------------

# Utilities
# ---------------------------------------
expand_bg="\e[K"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
black="\e[30m"
bold="\e[1m"
reset="\e[0m"

while getopts s: option
do
	case "${option}" in
		s) suffix=${OPTARG};;
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

# Merge Wine builds
# ---------------------------------------
title "Merging wine builds"
print_execution "cd $HOME/work/wine/wine"
print_execution "rsync -avh winebuild_64/* winebuild"

# Determining the Wine version
# ---------------------------------------
title "Determining the Wine version"
print_execution "cd $HOME/work/wine/wine"
wine_version=$(cat VERSION)
wine_version=${wine_version:13}
print_execution "echo Wine version is: $wine_version"

# Package Wine build
# ---------------------------------------
title "Package Wine build"
print_execution "mv $HOME/work/wine/wine/winebuild $HOME/work/wine/wine/chardonnay-${wine_version}-x86_64"
archive_name="chardonnay-${wine_version}-x86_64.tar.gz"
print_execution "tar zcvf ${archive_name} chardonnay-${wine_version}-x86_64"
if [[ -z ${suffix+x} ]]
then
	print_execution "echo No suffix defined."
else
	print_execution "mv chardonnay-${wine_version}-x86_64.tar.gz chardonnay-${wine_version}-${suffix}-x86_64.tar.gz"
fi
print_execution "ls chardonnay*.tar.gz"

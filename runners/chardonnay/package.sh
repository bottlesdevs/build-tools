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
print_execution "cd $HOME/runner/work/wine/wine"
print_execution "rsync -avh winebuild_64/* winebuild"

# Determining the Wine version
# ---------------------------------------
title "Determining the Wine version"
print_execution "cd $HOME/runner/work/wine/wine"
wine_version=$(cat VERSION)
wine_version=${wine_version:13}
print_execution "echo Wine version is: $wine_version}"

# Package Wine build
# ---------------------------------------
title "Package Wine build"
print_execution "cd $HOME/runner/work/wine/wine/winebuild"
archive_name="chardonnay-${wine_version}-x86_64.zip"
print_execution "zip -r ${archive_name} *"
print_execution "mv chardonnay*.zip ../ & cd .."
print_execution "ls chardonnay*.zip"

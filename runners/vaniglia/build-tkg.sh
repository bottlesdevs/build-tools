#!/bin/bash

# ---------------------------------------
# build-tkg.sh
# This script build wine using wine-tkg
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

# Preparing build directory
# ---------------------------------------
title "Preparing build directory"
print_execution "cp wine-tkg.cfg $HOME/.config/frogminer/wine-tkg.cfg"

# Set version in wine-tkg.cfg
# ---------------------------------------
title "Setting version in wine-tkg.cfg"
print_execution "cd $HOME/.config/frogminer"
if [[ -z ${release+x} ]]
then
	print_execution "echo No release declared, fallback on git"
else
	sed -i "s/_staging_version=\"\"/_staging_version=\"v$release\"/g" wine-tkg.cfg
	sed -i "s/_plain_version=\"\"/_plain_version=\"wine-$release\"/g" wine-tkg.cfg
fi

# Fetching the latest version of wine-tkg
# ---------------------------------------
title "Fetching the latest version of wine-tkg"
print_execution "cd $HOME/work/wine/wine/winebuild"
print_execution "git clone https://github.com/Frogging-Family/wine-tkg-git.git"

# Substituting apt with aptitude
# ---------------------------------------
# Note: This fix a lot of problems with GitHub Actions, as Ubuntu will
# keep failing to install dependencies.
# ---------------------------------------
title "Substituting apt with aptitude"
print_execution "cd $HOME/work/wine/wine/winebuild/wine-tkg-git/wine-tkg-git/wine-tkg-scripts"
sed -i 's/apt/aptitude/g' deps

# Starting the build
# ---------------------------------------
title "Starting the build"
print_execution "cd $HOME/work/wine/wine/winebuild/wine-tkg-git/wine-tkg-git"
sed -i 's/distro=""/distro="debuntu"/' customization.cfg
yes|./non-makepkg-build.sh

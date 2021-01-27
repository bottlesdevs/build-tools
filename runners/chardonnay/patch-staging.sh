#!/bin/bash

# ---------------------------------------
# patch-staging.sh
# This script fetch and apply the wine-staging patches
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

echo $release

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

# Fetching Wine Staging
# ---------------------------------------
title "Fetching Wine Staging"
print_execution "cd $HOME/work"

if [[ -z ${release+x} ]]
then
	print_execution "echo No release declared, fallback on git"
	print_execution "git clone https://github.com/wine-staging/wine-staging.git"
else
	print_execution "echo Requested the $release release"
	print_execution "wget -O wine-staging.tar.gz https://github.com/wine-staging/wine-staging/archive/v$release.tar.gz"
	print_execution "tar zxvf wine-staging.tar.gz"
	print_execution "rm wine-staging.tar.gz"
	print_execution "mv wine-staging-$release wine-staging"
fi

# Applying Wine Staging
# ---------------------------------------
title "Applying Wine Staging"
print_execution "cd $HOME/work/wine-staging/patches"
print_execution "./patchinstall.sh DESTDIR=$HOME/work/wine/wine --all"
print_execution "autoreconf -f"

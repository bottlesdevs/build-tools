#!/bin/bash

# -------------------------------------------------------
# fetch.sh
# This script fetch the wine source code from git or 
# releases
# Variant: cx (Crossover Wine)
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
title "Fetch Wine-CX source code"
print_execution "cd $HOME/work/wine"
print_execution "mkdir -p $HOME/work/wine/wine"

if [[ -z ${release+x} ]]
then
	print_execution "echo No release declared, aborting"
    exit 1
else
	print_execution "echo Requested the $release release"
	print_execution "wget -O wine_source.tar.gz http://media.codeweavers.com/pub/crossover/source/crossover-sources-${release}.tar.gz"
	print_execution "tar -zxvf wine_source.tar.gz"
	print_execution "mv $HOME/work/wine/sources/wine/* wine"
fi


# Fix missing distversion.h
# ---------------------------------------
title "Fix missing distversion.h"
echo '#define WINDEBUG_WHAT_HAPPENED_MESSAGE "This can be caused by a problem in the program or a deficiency in Wine."' >> wine/include/distversion.h
echo '#define WINDEBUG_USER_SUGGESTION_MESSAGE "If this problem is not present under Windows and has not been reported yet, you can save the detailed information to a file using the \"Save As\" button, then file a bug report and attach that file to the report."' >> wine/include/distversion.h

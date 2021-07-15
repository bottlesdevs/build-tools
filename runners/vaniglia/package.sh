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

# Strip unneeded files
# ---------------------------------------
title "Strip unneeded files"
print_execution "cd $HOME/work/wine/wine/winebuild"
find . -type f -exec strip {} \;
for file in {bin, lib, lib64}/{wine/*,*}; do
    if [[ "$_f" = *.so ]] || [[ "$file" = *.dll ]]; then
        strip --strip-unneeded "$file" || true
    fi
done
for file in {bin, lib, lib64}/{wine/{x86_64-unix, x86_64-windows, i386-unix, i386-windows}/*,*}; do
    if [[ "$file" = *.so ]] || [[ "$file" = *.dll ]]; then
        strip --strip-unneeded "$file" || true
    fi
done

# Include runtime libraries
# ---------------------------------------
title "Include runtime libraries"
print_execution "cd $HOME/work/wine/wine/winebuild"
print_execution "mkdir -p lib64"
print_execution "cp -R /lib32/* lib/"
print_execution "cp -R /lib64/* lib64/"

# Remove include directory
# ---------------------------------------
title "Remov include directory"
print_execution "cd $HOME/work/wine/wine/winebuild"
print_execution "rm -rf include"

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
if [[ -z ${suffix+x} ]]
then
	print_execution "echo No suffix defined."
	print_execution "mv $HOME/work/wine/wine/winebuild $HOME/work/wine/wine/vaniglia-${wine_version}-x86_64"
	archive_name="vaniglia-${wine_version}-x86_64.tar.gz"
	print_execution "tar zcvf ${archive_name} vaniglia-${wine_version}-x86_64"
else
	print_execution "mv $HOME/work/wine/wine/winebuild $HOME/work/wine/wine/vaniglia-${wine_version}-${suffix}-x86_64"
	archive_name="vaniglia-${wine_version}-${suffix}-x86_64.tar.gz"
	print_execution "tar zcvf ${archive_name} vaniglia-${wine_version}-${suffix}-x86_64"
fi
print_execution "ls vaniglia*.tar.gz"

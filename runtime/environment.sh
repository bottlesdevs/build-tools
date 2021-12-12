#!/bin/bash

# ---------------------------------------
# environment.sh
# This script configure the build environment
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

# Installing aptitude
# ---------------------------------------
title "Installing aptitude"
print_execution "sudo apt install aptitude -y"

# Adding repositories
# ---------------------------------------
title "Adding repositories"
print_execution "sudo apt -y install software-properties-common"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/vkd3d -y"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport -y"
print_execution "sudo apt-get -qq update"

# Adding repositories
# ---------------------------------------
title "Adding repositories"
print_execution "sudo apt -y install software-properties-common"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/vkd3d -y"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport -y"
print_execution "sudo apt-get -qq update"

# Installing i386 dependencies
# ---------------------------------------
title "Installing i386 dependencies"
print_execution "sudo aptitude install -y libacl1-dev:i386 libasound2-dev:i386 \
libcups2-dev:i386 libdbus-1-dev:i386 libgcrypt-dev:i386 libgif-dev:i386 libglu1-mesa-dev:i386 libgsm1-dev:i386 \
liblcms2-dev:i386 libldap2-dev:i386 libmpg123-dev:i386 libncurses5-dev:i386 libopenal-dev:i386 libosmesa6-dev:i386 \
libpcap-dev:i386 libtiff5-dev:i386 libudev-dev:i386 libv4l-dev:i386 libva-dev:i386 \
libxslt1-dev:i386 libxt-dev:i386 libvulkan-dev:i386 libgnutls28-dev:i386 \
libpng-dev:i386 libsdl2-dev:i386 libavcodec-dev:i386 \
libavutil-dev:i386 libswresample-dev:i386 libswresample3:i386 libavutil56:i386 \
libvkd3d-dev:i386 libvkd3d-utils1:i386 libvulkan1:i386 \
xserver-xorg-dev:i386 libfreetype6-dev:i386 gcc-multilib g++-multilib gcc-mingw-w64-i686 \
mingw-w64-i686-dev gcc-mingw-w64-x86-64 g++-mingw-w64-i686 g++-mingw-w64-x86-64 libvkd3d-shader1:i386 \
ocl-icd-opencl-dev:i386 linux-libc-dev:i386 vkd3d-demos:i386 \
libcupsimage2-dev:i386 libtiff-dev:i386 librsvg2-2:i386 \
libsoxr0:i386 libsdl2-mixer-dev:i386 libglib2.0-0:i386 \
libibus-1.0-dev:i386 libpulse-dev:i386 libsdl2-mixer-2.0-0:i386 \
libavcodec58:i386 libmount1:i386 libselinux1:i386 libglib2.0-dev:i386 
libselinux1-dev:i386 libpcre2-8-0:i386"

title "APT fix"
print_execution "sudo apt install -f -y"

# Installing amd64 dependencies
# ---------------------------------------
title "Installing amd64 dependencies"
print_execution "sudo aptitude install -y autoconf bison ccache debhelper desktop-file-utils docbook-to-man \
docbook-utils docbook-xsl flex fontforge gawk gettext libacl1-dev \
libasound2-dev libdbus-1-dev \
libgcrypt-dev libgif-dev libglu1-mesa-dev libgsm1-dev \
liblcms2-dev libldap2-dev libmpg123-dev libncurses5-dev \
libopenal-dev libosmesa6-dev libpcap-dev \
libssl-dev libtiff5-dev libudev-dev libv4l-dev libva-dev libxslt1-dev libxt-dev \
ocl-icd-opencl-dev prelink valgrind linux-libc-dev libppl14 libvulkan-dev libgnutls28-dev \
libpng-dev libsdl2-dev libavcodec-dev libavutil-dev libswresample-dev libavcodec58 libswresample3 libavutil56 \
libvkd3d1 libvkd3d-dev libvkd3d-utils1 libvkd3d-shader1 vkd3d-demos libvulkan1 liborc-0.4-dev \
gcc-mingw-w64 mingw-w64 mingw-w64-common mingw-w64-x86-64-dev mingw-w64-tools \
libsoxr0 libsdl2-mixer-dev"

title "APT fix"
print_execution "sudo apt install -f -y"

#!/bin/bash

# ---------------------------------------
# environment-tkg.sh
# This script configure the build environment for wine-tkg
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
	fi
}

# Preparing directories
# ---------------------------------------
title "Preparing directories"
print_execution "mkdir -p $HOME/work/wine/wine/winebuild"
print_execution "mkdir -p $HOME/.config/frogminer"

# Enabling i386 architecture
# ---------------------------------------
title "Enabling i386 architecture"
print_execution "sudo dpkg --add-architecture i386"
#print_execution "sudo apt update"
#print_execution "sudo apt dist-upgrade -y"
#print_execution "sudo apt install -y ia32-libs"

# Adding repositories
# ---------------------------------------
title "Adding repositories"
print_execution "sudo apt -y install software-properties-common"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/vkd3d -y"
print_execution "sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport -y"
print_execution "sudo apt-get -qq update"

# Installing aptitude
# ---------------------------------------
title "Installing aptitude"
print_execution "sudo apt install -y aptitude"

# Installing wine development dependencies
# ---------------------------------------
# title "Installing wine development dependencies"
# print_execution "sed -i '/deb-src/s/^# //' /etc/apt/sources.list"
# print_execution "sudo apt update"
# print_execution "sudo apt-get build-dep wine-development"

# Installing i386 dependencies
# ---------------------------------------
title "Installing i386 dependencies"
print_execution "sudo aptitude install -y \
libacl1-dev:i386 \
libasound2-dev:i386 \
libcups2-dev:i386 \
libdbus-1-dev:i386 \
libgcrypt-dev:i386 \
libgif-dev:i386 \
libglu1-mesa-dev:i386 \
libgsm1-dev:i386 \
liblcms2-dev:i386 \
libldap2-dev:i386 \
libmpg123-dev:i386 \
libncurses5-dev:i386 \
libopenal-dev:i386 \
libosmesa6-dev:i386 \
libpcap-dev:i386 \
libpulse-dev:i386 \
libtiff5-dev:i386 \
libudev-dev:i386 \
libv4l-dev:i386 \
libva-dev:i386 \
libxslt1-dev:i386 \
libxt-dev:i386 \
libcolord2:i386 \
libvulkan-dev:i386 \
libgnutls28-dev:i386 \
libgstreamer1.0-dev:i386 \
libgstreamer-plugins-base1.0-dev:i386 \
libgstreamer-plugins-bad1.0-dev:i386 \
gstreamer1.0-plugins-base:i386 \
gstreamer1.0-plugins-good:i386 \
gstreamer1.0-plugins-bad:i386 \
gstreamer1.0-plugins-ugly:i386 \
gstreamer1.0-libav:i386 \
gstreamer1.0-tools:i386 \
gstreamer1.0-x:i386 \
gstreamer1.0-alsa:i386 \
gstreamer1.0-gl:i386 \
gstreamer1.0-gtk3:i386 \
gstreamer1.0-qt5:i386 \
gstreamer1.0-pulseaudio:i386 \
libpng-dev:i386 \
libsdl2-dev:i386 \
libavcodec-dev:i386 \
libavutil-dev:i386 \
libswresample-dev:i386 \
libavcodec58:i386 \
libswresample3:i386 \
libavutil56:i386 \
libfaudio0:i386 \
libfaudio-dev:i386 \
libvkd3d-dev:i386 \
libvkd3d-utils1:i386 \
libvulkan1:i386 \
libgstreamer1.0-0:i386 \
gstreamer1.0-libav:i386 \
xserver-xorg-dev:i386 \
libfreetype6-dev:i386 \
gcc-multilib \
g++-multilib \
gcc-mingw-w64-i686 \
mingw-w64-i686-dev \
gcc-mingw-w64-x86-64 \
g++-mingw-w64-i686 \
g++-mingw-w64-x86-64 \
libvkd3d-shader1:i386 \
libgtk-3-dev:i386 \
ocl-icd-opencl-dev:i386 \
linux-libc-dev:i386 \
libvkd3d1:i386 \
vkd3d-demos:i386 \
gstreamer1.0-tools:i386 \
gstreamer1.0-x:i386 \
gstreamer1.0-alsa:i386 \
gstreamer1.0-gl:i386 \
gstreamer1.0-gtk3:i386 \
gstreamer1.0-pulseaudio:i386 \
libcupsimage2-dev:i386 \
libgdk-pixbuf2.0-dev:i386 \
libtiff-dev:i386 \
libpango1.0-dev:i386"

title "APT fix"
print_execution "sudo apt install -f -y"

# Installing amd64 dependencies
# ---------------------------------------
title "Installing amd64 dependencies"
print_execution "sudo aptitude install -y autoconf bison ccache debhelper desktop-file-utils docbook-to-man \
docbook-utils docbook-xsl flex fontforge gawk gettext schedtool git wget fonttools python3-tk \
libacl1-dev \
libasound2-dev \
libdbus-1-dev \
libgcrypt-dev \
libgif-dev \
libglu1-mesa-dev \
libgsm1-dev \
libgtk-3-dev \
liblcms2-dev \
libldap2-dev \
libmpg123-dev \
libncurses5-dev \
libopenal-dev \
libosmesa6-dev \
libpcap-dev \
libpulse-dev \
libssl-dev \
libtiff5-dev \
libudev-dev \
libv4l-dev \
libva-dev \
libxslt1-dev \
libxt-dev \
ocl-icd-opencl-dev \
prelink \
valgrind \
linux-libc-dev \
libppl14 \
libcolord2 \
libvulkan-dev \
libgnutls28-dev \
libgstreamer-plugins-base1.0-dev \
libgstreamer1.0-dev \
libpng-dev \
libsdl2-dev \
libavcodec-dev \
libavutil-dev \
libswresample-dev \
libavcodec58 \
libswresample3 \
libavutil56 \
libfaudio0 \
libfaudio-dev \
libvkd3d1 \
libvkd3d-dev \
libvkd3d-utils1 \
libvkd3d-shader1 vkd3d-demos \
libvulkan1 \
libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-bad1.0-dev \
gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad \
gstreamer1.0-plugins-ugly \
gstreamer1.0-libav \
gstreamer1.0-tools \
gstreamer1.0-x \
gstreamer1.0-alsa \
gstreamer1.0-gl \
gstreamer1.0-gtk3 \
gstreamer1.0-qt5 \
gstreamer1.0-pulseaudio \
liborc-0.4-dev \
gcc-mingw-w64 \
mingw-w64 \
mingw-w64-common \
mingw-w64-x86-64-dev \
mingw-w64-tools \
libpango1.0-dev \
libfreetype6-dev \
xserver-xorg-dev"

# Configuring GCC
# ---------------------------------------
#title "Configuring GCC"
#if [ "$CXX" = "g++" ]; then export CXX="g++-5" CC="gcc-5"; fi

#export LDFLAGS=-m32
#export CXXFLAGS=-m32
#export CFLAGS=-m32

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

# Installing i386 dependencies
# ---------------------------------------
title "Installing dependencies"
print_execution "sudo aptitude install -y \
libsdl2-mixer-dev libsdl2-mixer-dev:i386 \
libsdl2-mixer-2.0-0 libsdl2-mixer-2.0-0:i386 \
libsoxr0 libsoxr0:i386 \
libdatrie1 libdatrie1:i386 \
libwxbase3.0-0v5 libwxbase3.0-0v5:i386 \
liblua5.2-0 liblua5.2-0:i386 \
libjbig0 libjbig0:i386 \
libjpeg-turbo8 libjpeg-turbo8:i386 \
libfribidi0 libfribidi0:i386 \
libxslt1.1 libxslt1.1:i386 \
libtiff5 libtiff5:i386 \
libmad0 libmad0:i386 \
libtinfo5 libtinfo5:i386 \
libmpg123-0 libmpg123-0:i386 \
libfaad2 libfaad2:i386 \
libgomp1-i386-cross libgomp1-i386-cross:i386 \
lib64gomp1-i386-cross lib64gomp1-i386-cross:i386 \
libx32gomp1-i386-cross libx32gomp1-i386-cross:i386 \
gcc-snapshot gcc-snapshot:i386 \
gcc-snapshot gcc-snapshot:i386 \
libgomp1 libgomp1:i386 \
lib64gomp1 lib64gomp1:i386 \
libx32gomp1 libx32gomp1:i386 \
libaudio2 libaudio2:i386 \
libmikmod3 libmikmod3:i386 \
libxslt1.1 libxslt1.1:i386 \
libsdl2-image-2.0-0 libsdl2-image-2.0-0:i386 \
libxshmfence1 libxshmfence1:i386 \
libthai0 libthai0:i386 \
libsdl-net1.2 libsdl-net1.2:i386 \
libgcrypt20 libgcrypt20:i386 \
libsoundtouch1 libsoundtouch1:i386 \
libportaudio2 libportaudio2:i386 \
liblua5.1-0 liblua5.1-0:i386 \
libgif7 libgif7:i386 \
libatk1.0-0 libatk1.0-0:i386 \
libsdl-sound1.2 libsdl-sound1.2:i386 \
libgraphite2-3 libgraphite2-3:i386 \
libluajit-5.1-2 libluajit-5.1-2:i386 \
libwebp6 libwebp6:i386 \
libmodplug1 libmodplug1:i386 \
libmpeg2-4 libmpeg2-4:i386 \
libsdl-ttf2.0-0 libsdl-ttf2.0-0:i386 \
libjansson4 libjansson4:i386 \
zlib1g zlib1g:i386 \
lib64z1 lib64z1:i386 \
libx32z1 libx32z1:i386 \
libncurses5 libncurses5:i386 \
libxinerama1 libxinerama1:i386 \
libzzip-0-13 libzzip-0-13:i386 \
libfuse2 libfuse2:i386 \
libgpg-error0 libgpg-error0:i386 \
libv4lconvert0 libv4lconvert0:i386 \
libncursesw5 libncursesw5:i386 \
libmpeg2-4 libmpeg2-4:i386 \
libfontconfig1 libfontconfig1:i386 \
libxml2 libxml2:i386 \
libharfbuzz0b libharfbuzz0b:i386 \
libaio1 libaio1:i386"


title "APT fix"
print_execution "sudo apt install -f -y"


#!/bin/bash

# Colorize and add text parameters
export red=$(tput setaf 1)             #  red
export grn=$(tput setaf 2)             #  green
export blu=$(tput setaf 4)             #  blue
export cya=$(tput setaf 6)             #  cyan
export txtbld=$(tput bold)             #  Bold
export bldred=${txtbld}$(tput setaf 1) #  red
export bldgrn=${txtbld}$(tput setaf 2) #  green
export bldblu=${txtbld}$(tput setaf 4) #  blue
export bldcya=${txtbld}$(tput setaf 6) #  cyan
export txtrst=$(tput sgr0)             #  Reset


# check if ccache installed, if not install
if [ ! -e /usr/bin/ccache ]; then
	echo "You must install 'ccache' to continue.";
	sudo apt-get install ccache
fi

# check if xmllint installed, if not install
if [ ! -e /usr/bin/xmllint ]; then
	echo "You must install 'xmllint' to continue.";
	sudo apt-get install libxml2-utils
fi

echo "${bldcya}***** Clean up Environment before compile *****${txtrst}";


# Make clean source
read -t 5 -p "Make clean source, 5sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
make clean;
make distclean;
make mrproper;
fi;

# clear ccache
read -t 5 -p "Clear ccache but keeping the config file, 5sec timeout (y/n)?";
if [ "$REPLY" == "y" ]; then
ccache -C;
fi;


TARGET=$1
if [ "$TARGET" != "" ]; then
	echo
        echo "Starting your build for $TARGET"
else
        echo ""
        echo "You need to define your device target!"
        echo "example: build_kernel.sh N920C"
        echo "example: build_kernel.sh N920P"
        echo "example: build_kernel.sh N9200"
        echo "example: build_kernel.sh G928C"
        exit 1
fi


# location
	export KERNELDIR=`readlink -f .`;


# set build variables
BK=build_kernel
export KCONFIG_NOTIMESTAMP=true
export ARCH=arm64;
export SUB_ARCH=arm64;

# SM-N920 C/CD/G/I
if [ "$TARGET" = "N920C" ] ; then
	export KERNEL_CONFIG="SkyHigh_N920C_defconfig";
fi;

# SM-N920 P (Sprint)
if [ "$TARGET" = "N920P" ] ; then
	export KERNEL_CONFIG="SkyHigh_N920P_defconfig";
fi;

# SM-N9200 HK
if [ "$TARGET" = "N9200" ] ; then
	export KERNEL_CONFIG="SkyHigh_N9200_HK_defconfig";
fi;

# SM-G928 C/F/G/I
if [ "$TARGET" = "G928C" ] ; then
	export KERNEL_CONFIG="SkyHigh_G928C_defconfig";
fi;

# build script
export USER=`whoami`;
export TMPFILE=`mktemp -t`;


# system compiler : UBERTC 5.3.1 20160401 https://bitbucket.org/UBERTC/aarch64-linux-android-5.3-kernel
export CROSS_COMPILE=/home/upintheair/aarch64-linux-android-5.3-kernel/bin/aarch64-linux-android-


# CPU Core
export NUMBEROFCPUS=`grep 'processor' /proc/cpuinfo | wc -l`;

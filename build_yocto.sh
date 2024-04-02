#!/bin/bash
#
#

echo "Initalizing repo for langdale"

TOPDIR=$(pwd)

git clone git://git.yoctoproject.org/poky -b langdale
cd poky
echo "applying patches"
patch -p1 < $TOPDIR/patches/poky.patches

git clone https://git.yoctoproject.org/meta-raspberrypi/ -b langdale
cd meta-raspberrypi
echo "applying patches"
patch -p1 < $TOPDIR/patches/meta-raspberrypi.patch

cd ..
source oe-init-build-env

bitbake-layers layerindex-fetch meta-oe
bitbake-layers layerindex-fetch meta-networking
bitbake-layers layerindex-fetch meta-filesystems

bitbake-layers add-layer ../meta-raspberrypi

cp $TOPDIR/local.conf ./conf/

bitbake core-image-full-cmdline



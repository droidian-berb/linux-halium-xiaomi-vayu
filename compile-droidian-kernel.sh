#!/bin/bash
#export PATH=/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
chmod +x /buildd/sources/debian/rules
cd /buildd/sources
rm -f debian/control
debian/rules debian/control
#source /buildd/sources/droidian/scripts/python-zlib-upgrade.sh

RELENG_HOST_ARCH="arm64" releng-build-package

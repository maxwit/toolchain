#!/bin/sh
#
# http://www.maxwit.com
# http://maxwit.googlecode.com
#

case $3 in
arm-*)
	arch="arm"
	;;
mips*)
	arch="mips"
	;;
*)
	arch="x86"
	;;
esac

make ARCH=${arch} INSTALL_HDR_PATH=${TOOLCHAIN_PATH}/usr headers_install || exit 1

#!/bin/sh
#
# http://www.maxwit.com
# http://maxwit.googlecode.com
#

../${1}/configure \
	--prefix=/usr \
	--build=${2} \
	--host=${2} \
	--target=${3} \
	--with-sysroot=${ROOTFS_PATH} \
	--with-pkgversion="MaxWit Software, http://www.maxwit.com" \
	--disable-multilib \
	--disable-nls \
	--enable-shared \
	--enable-__cxa_atexit \
	--enable-c99 \
	--enable-long-long \
	--enable-threads=posix \
	--enable-languages=c,c++ \
	${GCC_CPU_OPT} \
	|| exit 1

make AS_FOR_TARGET=${3}-as LD_FOR_TARGET=${3}-ld && \
make DESTDIR=${TOOLCHAIN_PATH} install || exit 1

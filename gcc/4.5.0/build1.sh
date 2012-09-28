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
	--without-headers \
	--with-newlib \
	--disable-multilib \
	--disable-nls \
	--disable-decimal-float \
	--disable-libgomp \
	--disable-libmudflap \
	--disable-libssp \
	--disable-shared \
	--disable-threads \
	--enable-long-long \
	--enable-languages=c \
	${GCC_CPU_OPT} \
	|| exit 1

make && \
make DESTDIR=${TOOLCHAIN_PATH} install || exit 1

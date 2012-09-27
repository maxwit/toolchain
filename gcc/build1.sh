#!/bin/sh
#
# http://www.maxwit.com
# http://maxwit.googlecode.com
#
#	--with-system-zlib \
#	--disable-FEATURE \

../${MWP_GCC}/configure \
	--prefix=/usr \
	--build=${BUILD_PLAT} \
	--host=${BUILD_PLAT} \
	--target=${TARGET_PLAT} \
	--with-sysroot=${ROOTFS_PATH} \
	--without-headers \
	--with-newlib \
	--disable-libada \
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
	--disable-libquadmath \
	--disable-libquadmath-support \
	${GCC_CPU_OPT} \
	|| exit 1

make && \
make DESTDIR=${TOOLCHAIN_PATH} install || exit 1

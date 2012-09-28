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
	--disable-nls \
	--disable-werror \
	--disable-multilib \
	${BU_CPU_OPT} \
	|| exit 1

make && \
make DESTDIR=${TOOLCHAIN_PATH} install || exit 1

cp -v ../${1}/include/libiberty.h ${TOOLCHAIN_PATH}/usr/include

#!/bin/sh
#
# http://www.maxwit.com
# http://maxwit.googlecode.com
#

case $3 in
mips64el*)
	libc_cc="${3}-gcc -mabi=64"
	;;
*)
	libc_cc="${3}-gcc"
	;;
esac

echo "install_root=${TOOLCHAIN_PATH}" > configparms
libc_cv_forced_unwind=yes \
libc_cv_c_cleanup=yes \
libc_cv_gnu99_inline=yes \
HOST_CC=gcc \
CC="${libc_cc}" \
AR="${3}-ar" \
RANLIB="${3}-ranlib" \
../${1}/configure \
	--prefix=/usr \
	--build=${2} \
	--host=${3} \
	--disable-profile \
	--enable-add-ons \
	--with-tls \
	--enable-kernel=2.6.0 \
	--with-__thread \
	--with-binutils=${TOOLCHAIN_PATH}/usr/bin \
	--with-headers=${TOOLCHAIN_PATH}/usr/include \
	|| exit 1

make && make install || exit 1

# fixme
mkdir -p ${ROOTFS_PATH}/usr && \
cp -av ${TOOLCHAIN_PATH}/usr/include ${ROOTFS_PATH}/usr && \
cp -av ${TOOLCHAIN_PATH}/usr/lib ${ROOTFS_PATH}/usr && \
cp -av ${TOOLCHAIN_PATH}/lib ${ROOTFS_PATH}/ || exit 1

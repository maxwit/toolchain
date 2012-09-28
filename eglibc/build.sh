#!/bin/sh
#
# http://www.maxwit.com
# http://maxwit.googlecode.com


sed -i 's/-lgcc_eh//g' ../${1}/Makeconfig

echo libc_cv_forced_unwind=yes > config.cache
echo libc_cv_c_cleanup=yes >> config.cache
echo libc_cv_gnu89_inline=yes >> config.cache
echo "install_root=${TOOLCHAIN_PATH}" >> configparms

case $3 in
mips64el*)
	libc_cc="${3}-gcc -mabi=64"
	;;
*)
	libc_cc="${3}-gcc"
	;;
esac

BUILD_CC="gcc" \
CC="${libc_cc}" \
AR="${3}-ar" \
RANLIB="${3}-ranlib" \
../${1}/configure \
    --host=${3} \
    --build=${2} \
    --prefix=/usr \
    --disable-profile \
    --enable-kernel=2.6.0 \
	--enable-add-ons \
    --with-tls \
    --with-__thread \
    --with-binutils=${TOOLCHAIN_PATH}/usr/bin \
    --with-headers=${TOOLCHAIN_PATH}/usr/include \
    --cache-file=config.cache \
    || exit 1

make && make install || exit 1

# fixme
if [ ${ROOTFS_PATH} != ${TOOLCHAIN_PATH} ]; then
	mkdir -p ${ROOTFS_PATH}/usr && \
	cp -av ${TOOLCHAIN_PATH}/usr/include ${ROOTFS_PATH}/usr && \
	cp -av ${TOOLCHAIN_PATH}/usr/lib ${ROOTFS_PATH}/usr && \
	cp -av ${TOOLCHAIN_PATH}/lib ${ROOTFS_PATH}/ || exit 1
fi

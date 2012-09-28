#!/bin/sh

LIBC=${1} # eglibc-2.16
OUT=${2}  # /maxwit/source
URL="svn://svn.eglibc.org/branches"
EXT="tar.bz2"

[ -d ${OUT} ] || mkdir -vp ${OUT} || exit 1

cd ${OUT} && \
svn co ${URL}/`echo ${LIBC} | sed 's/\./_/g'` ${LIBC} || exit 1

cd ${LIBC}

for dir in libc ports
do
	if [ $dir = libc ]; then
		pkg=${LIBC}
	else
		pkg="eglibc-${dir}${LIBC#eglibc}"
	fi

	echo -n "Generating ${pkg}.${EXT} "

	mv ${dir} ${pkg} || exit 1
	echo -n "."

	rm -rf `find ${pkg} -name .svn`
	echo -n "."

	tar cjf ../${pkg}.${EXT} ${pkg}
	echo ". Done"
done

cd .. && rm -rf ${LIBC}

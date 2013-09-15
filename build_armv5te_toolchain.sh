#!/bin/sh
#
# picmaster@mail.bg
# 20.Feb.2013
#
# Script for building a standalone cross-toolchain for ARMv5TE-based CPUs.
# You can find the latest version here: https://github.com/picmaster/arm-toolchains
#
# This script is public domain. Do whatever you want with it.

# Stop script execution on any error
set -e

BINUTILS_VER=2.23.2
#GCC_VER=4.5.4
#GCC_VER=4.6.3
GCC_VER=4.7.2
NEWLIB_VER=2.0.0
GDB_VER=7.5.1
INSIGHT_VER=6.8-1a

# Target configuration
TARGET_ARCH=arm-none-eabi
TARGET_CPU=arm926ej-s
PROG_PREFIX=$TARGET_ARCH-

PREFIX=~/$TARGET_CPU-toolchain
HOST_CORES=2

for i in binutils-build binutils-$BINUTILS_VER gcc-build gcc-$GCC_VER \
 newlib-build newlib-$NEWLIB_VER gdb-build gdb-$GDB_VER; do
	[ -d $i ] && echo "Deleting $i" && rm -fr $i
done

BINUTILS=binutils-$BINUTILS_VER.tar.gz
GCC=gcc-$GCC_VER.tar.gz
NEWLIB=newlib-$NEWLIB_VER.tar.gz
GDB=gdb-$GDB_VER.tar.gz


# Download all sources
[ ! -f $BINUTILS ] && wget http://ftp.gnu.org/gnu/binutils/$BINUTILS
[ ! -f $GCC ] && wget http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VER/$GCC

echo "Extracting $BINUTILS"
tar xf $BINUTILS

mkdir -pv binutils-build
cd binutils-build
../binutils-$BINUTILS_VER/configure \
 --prefix=$PREFIX \
 --program-prefix=$PROG_PREFIX \
 --target=$TARGET_ARCH \
 --disable-nls \
 --disable-werror \
 --with-cpu=$TARGET_CPU \
 --with-no-thumb-interwork \
 --with-mode=arm \
 --with-gnu-as \
 --with-gnu-ld

make -j$HOST_CORES
make install
cd ..
rm -fr binutils-build binutils-$BINUTILS_VER


echo "Extracting $GCC"
tar xf $GCC

mkdir -pv gcc-build
cd gcc-build
../gcc-$GCC_VER/configure \
 --prefix=$PREFIX \
 --program-prefix=$PROG_PREFIX \
 --target=$TARGET_ARCH \
 --disable-werror \
 --with-cpu=$TARGET_CPU \
 --with-mode=arm \
 --disable-multilib \
 --with-float=soft \
 --without-headers \
 --enable-languages="c" \
 --disable-shared \
 --with-gnu-as \
 --with-gnu-ld \
 --with-no-thumb-interwork \
 --disable-libssp

make all -j$HOST_CORES
make install
cd ..
rm -fr gcc-build gcc-$GCC_VER

#!/bin/bash

export ARCH=arm64

if [ ! -d out ]; then
	mkdir out
fi
BUILD_CROSS_COMPILE=/home/mohaaserver1/data/rr_m51/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=/home/mohaaserver1/data/llvm8/toolchains/llvm-Snapdragon_LLVM_for_Android_8.0/prebuilt/linux-x86_64/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE m51_defconfig
make -j$(nproc) -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE

# error_copy_script
 cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
# This will cause some errors after the last make command is done and the Image is still not produced.
# No need to copy Image into the other location since it is not useful, and it will duplicate and cause such an error when compiling the kernel again without cleaning the out/Image loc after some modifications.
# Disabled till stable script is found.

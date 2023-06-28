#!/bin/sh

# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#

###############################################################################################
# This is the script to generate split PIL bins for Gunyah hypervisor                         #
# Need to run this script from the device/qcom/gen4_gvm_gy directory                         #
# Before running this script full android build should be done and below directory is present #
# device/qcom/msmnile-kernel with dtbs and Image present in the directory                     #
###############################################################################################

PWD=`pwd`;
#echo "$PWD"
ROOT_DIR="$PWD/../../../"
#echo "$ROOT_DIR"
IMG_PATH="$PWD/../msmnile-kernel"
#echo "$IMG_PATH"
cd $IMG_PATH
OUTPATH="$PWD/../../../out/target/product/gen4_gvm_gy"
#echo "$OUTPATH"
cd $OUTPATH
# Create scratch folder to copy the images for creating split PIL images
if [ -d "$OUTPATH/scratch" ]
then
	rm -Rf scratch
fi
mkdir scratch
cp $IMG_PATH/dtbs/dtbo.img $OUTPATH/scratch/
cp $IMG_PATH/Image $OUTPATH/scratch/
cp $OUTPATH/ramdisk.img $OUTPATH/scratch/
cd $OUTPATH/scratch

python3 $ROOT_DIR/kernel_platform/prebuilts/qcom_boot_artifacts/vm/pil_tools/image_header.py autogvm-boot.elf Image,0x0 dtbo.img,0x3000000 ramdisk.img,0x3100000 --32

$ROOT_DIR/kernel_platform/prebuilts/qcom_boot_artifacts/sectools/sectools secure-image autogvm-boot.elf --image-id GVM1 --security-profile $ROOT_DIR/kernel_platform/prebuilts/qcom_boot_artifacts/sectools/profiles/lemans_tz_security_profile.xml --sign --signing-mode TEST --outfile autogvm_signed-boot.elf

$ROOT_DIR/kernel_platform/prebuilts/qcom_boot_artifacts/sectools/sectools secure-image autogvm-boot.elf --inspect

if [ -d "$OUTPATH/scratch/boot" ]
then
	rm -Rf boot
fi
mkdir boot
python3 $ROOT_DIR/kernel_platform/prebuilts/qcom_boot_artifacts/vm/pil_tools/pil-splitter.py autogvm_signed-boot.elf boot/autoghgvm



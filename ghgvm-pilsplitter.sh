#!/bin/sh

# Copyright (c) 2023-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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
PIL_PATH="$PWD"
#echo "$PIL_PATH"
ROOT_DIR="$PWD/../../../"
#echo "$ROOT_DIR"
MKDTBOIMGPY_PATH=$ROOT_DIR/system/libufdt/utils/src
#echo "$MKDTBOIMGPY_PATH"
IMG_PATH="$PWD/../gen4-kernel"
#echo "$IMG_PATH"
cd $IMG_PATH
OUTPATH="$PWD/../../../out/target/product/gen4_gvm_gy"
#echo "$OUTPATH"
QCPATH="$PWD/../../../vendor/qcom/proprietary"
#echo "$QCPATH"
SECURITY_PROFILE_PATH="$QCPATH/securemsm/security_profiles"
cd $OUTPATH
# Create scratch folder to copy the images for creating split PIL images
if [ -d "$OUTPATH/scratch" ]; then
	rm -Rf scratch
fi
mkdir scratch

# Create dtb.img with DT table structure
# ref: https://source.android.com/docs/core/architecture/dto/partitions
DTB_FILE_LIST=$(find $IMG_PATH/dtbs -name "*.dtb" | sort)
if [ -z "${DTB_FILE_LIST}" ]; then
	echo "No *.dtb files found in $IMG_PATH/dtbs"
	exit 1
else
	echo "Creating the dtb.img"
	python3 $MKDTBOIMGPY_PATH/mkdtboimg.py create $OUTPATH/scratch/dtb.img $DTB_FILE_LIST
fi

cp $IMG_PATH/kernel-abl/abl-*/LinuxLoader.efi $OUTPATH/scratch/
cp $QCPATH/guest-bootloader/FVMAIN_COMPACT.Fv $OUTPATH/scratch/
cd $OUTPATH/scratch

python3 $PIL_PATH/image_header.py autogvm-bootloader.elf FVMAIN_COMPACT.Fv,0x0 \
	dtb.img,0x10000000 LinuxLoader.efi,0x10100000 --32

$QCPATH/sectools/Linux/sectools secure-image autogvm-bootloader.elf \
	--image-id GVM1 \
	--security-profile $SECURITY_PROFILE_PATH/lemans_tz_security_profile.xml \
	--sign --signing-mode TEST \
	--outfile autogvm_signed-bootloader.elf

$QCPATH/sectools/Linux/sectools secure-image autogvm-bootloader.elf --inspect

if [ -d "$OUTPATH/scratch/bootloader" ]; then
	rm -Rf bootloader
fi
mkdir bootloader
python3 $PIL_PATH/pil-splitter.py autogvm_signed-bootloader.elf bootloader/autoghgvm

echo "Creating the vm-bootloader.img"
$ROOT_DIR/out/host/linux-x86/bin/mkuserimg_mke2fs $OUTPATH/scratch/bootloader \
	$OUTPATH/vm-bootloader.img ext4 / 7000000

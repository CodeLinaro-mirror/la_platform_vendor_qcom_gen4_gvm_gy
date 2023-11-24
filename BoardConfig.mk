# Include the BoardConfig.mk of base product
include device/qcom/msmnile_gvmq/BoardConfig.mk

TARGET_ARCH := arm64
TARGET_2ND_ARCH := arm
BOARD_BOOT_HEADER_VERSION := 2
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT :=
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT :=
BOARD_INIT_BOOT_HEADER_VERSION :=
#If AVB is disabled need to override AB_OTA_PARTITIONS so that vbmeta is not part of
#OTA partiotion
ifeq ($(ENABLE_AB), true)
  AB_OTA_PARTITIONS := system system_ext vendor vendor_dlkm system_dlkm
endif
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE :=
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE :=
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x08000000
BOARD_BOOTCONFIG += androidboot.selinux=enforcing

BOARD_AVB_ENABLE := false

DEVICE_MANIFEST_FILE := device/qcom/gen4_gvm_gy/manifest.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/gen4_gvm_gy/framework_manifest.xml

ifeq ($(TARGET_USES_AUDIOLITE), true)
AUDIO_USE_STUB_HAL := true
endif

#Overwrite required variables below this
# Base product BoardConfigVendor.mk will already be included. So, use below to set new variables or to override old ones
-include $(QCPATH)/common/gen4_gvm_gy/BoardConfigVendor.mk

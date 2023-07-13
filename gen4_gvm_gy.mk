# Inherit from the base product
$(call inherit-product, device/qcom/msmnile_gvmq/msmnile_gvmq.mk)
TARGET_BASE_PRODUCT := msmnile_gvmq

PRODUCT_NAME := gen4_gvm_gy
PRODUCT_DEVICE := gen4_gvm_gy
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_gy for arm64
#flag to differentiate b/w HQX and HGY builds
TARGET_USES_GY := true

TARGET_USES_GAS := true
BOARD_HAS_QCOM_WLAN := false
#TODO - These defines will be removed after the AVB is enabled by security team.
PRODUCT_SUPPORTS_BOOT_SIGNER := false
PRODUCT_SUPPORTS_VERITY := false
PRODUCT_SUPPORTS_VERITY_FEC := false
#Flags to disable HSI2S and AIS dlkm for compilation
#TODO: Remove these once compilation issues are fixed
TARGET_DISABLE_HSI2S_DLKM := true
TARGET_DISABLE_AIS_DLKM := true

ENABLE_AB ?= true

ifeq ($(ENABLE_AB), true)
PRODUCT_COPY_FILES += device/qcom/gen4_gvm_gy/fstab_AB_dynamic_partition_variant.gen4_gy.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom
endif

TARGET_HAS_DIAG_ROUTER := false


#Disable gps services
TARGET_USES_QMAA_OVERRIDE_GPS := false

TARGET_OUT_INTERMEDIATES := out/target/product/$(PRODUCT_NAME)/obj
$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr:
	mkdir -p $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

# Change Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
ifeq ($(KERNEL_MODULES_OUT),)
  KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_DEVICE)/$(KERNEL_MODULES_INSTALL)/lib/modules
endif

# TARGET_KERNEL_VERSION := 5.15
# TARGET_HAS_GENERIC_KERNEL_HEADERS := true
# Set the system.prop files to that of the inherited product plus the new product. Alternatively, the system.prop file can be copied over
# TARGET_SYSTEM_PROP := device/qcom/msmnile_gvmq/system.prop device/qcom/gen4_gvm_gy/system.prop
PRODUCT_VENDOR_PROPERTIES += \
    ro.boot.audio=audioreach_vio

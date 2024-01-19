#Configure derivative suffix for conditional compilation
TARGET_BOARD_DERIVATIVE_SUFFIX:=_gy

# Inherit from the base product
include device/qcom/gen4_gvm/gen4_gvm.mk

PRODUCT_NAME := gen4_gvm_gy
PRODUCT_DEVICE := gen4_gvm_gy
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_gy for arm64

#flag to differentiate b/w HQX and HGY builds
TARGET_USES_GY := true

TARGET_USES_GAS := false

# Enable Smcinvoke based System Listeners
TARGET_ENABLE_SMCI_SYSLISTENER := true

TARGET_DISABLE_AIS_DLKM := true
TARGET_HAS_VIRTIO_FASTRPC := false
TARGET_HAS_DIAG_ROUTER := false

#Disable QCOM WLAN
BOARD_HAS_QCOM_WLAN := false

ENABLE_AB ?= true

ifeq ($(ENABLE_AB), true)
PRODUCT_COPY_FILES += device/qcom/gen4_gvm_gy/fstab_AB_dynamic_partition_variant.gen4_gy.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom
endif


#Disable gps services
###########
#QMAA flags starts
###########
#QMAA global flag for modular architecture
#true means QMAA is enabled for system
#false means QMAA is disabled for system

TARGET_USES_QMAA := true

#QMAA tech team flag to override global QMAA per tech team
#true means overriding global QMAA for this tech area
#false means using global, no override
TARGET_USES_QMAA_OVERRIDE_AUDIO   := true
TARGET_USES_QMAA_OVERRIDE_GPS := false
TARGET_USES_QMAA_OVERRIDE_DISPLAY := true
TARGET_USES_QMAA_OVERRIDE_GFX := true
TARGET_USES_QMAA_OVERRIDE_HSI2S := false

#Full QMAA HAL List
QMAA_HAL_LIST := audio

# Change Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
ifeq ($(KERNEL_MODULES_OUT),)
  KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_DEVICE)/$(KERNEL_MODULES_INSTALL)/lib/modules
endif


# TARGET_KERNEL_VERSION := 5.15
# TARGET_HAS_GENERIC_KERNEL_HEADERS := true
# Set the system.prop files to that of the inherited product plus the new product. Alternatively, the system.prop file can be copied over

PRODUCT_VENDOR_PROPERTIES += \
    ro.boot.audio=audioreach_vio

PRODUCT_PACKAGES += uhabtest

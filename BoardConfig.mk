# Include the BoardConfig.mk of base product
include device/qcom/gen4_gvm/BoardConfig.mk

ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS), true)
ifeq ($(TARGET_BOARD_TYPE), auto)
ifneq "$(wildcard external/boost)" ""
ifneq "$(wildcard external/vsomeip)" ""
${call soong_config_set,wifi,wifi_enable_someip,true}
endif
endif
endif
endif

TARGET_ARCH := arm64
TARGET_2ND_ARCH := arm

DEVICE_MANIFEST_FILE := device/qcom/gen4_gvm_gy/manifest.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/gen4_gvm_gy/framework_manifest.xml

#Clear the HQX command line parameters.
BOARD_KERNEL_CMDLINE :=

#Set the gen4_gvm_gy specific parameters.
BOARD_KERNEL_CMDLINE := debug user_debug=31 loglevel=9 print-fatal-signals=1  init=/init swiotlb=4096  kpti=0  firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7

BOARD_BOOTCONFIG += androidboot.usbcontroller=a400000.dwc3

ifeq ($(TARGET_USES_AUDIOLITE), true)
AUDIO_USE_STUB_HAL := true
endif

#namespace definition for qtiwifi
#differentiate auto and non-auto target
SOONG_CONFIG_NAMESPACES += qtiwifi
SOONG_CONFIG_qtiwifi += automobile
SOONG_CONFIG_qtiwifi_automobile := true

#Overwrite required variables below this
# Base product BoardConfigVendor.mk will already be included. So, use below to set new variables or to override old ones
-include $(QCPATH)/common/gen4_gvm_gy/BoardConfigVendor.mk

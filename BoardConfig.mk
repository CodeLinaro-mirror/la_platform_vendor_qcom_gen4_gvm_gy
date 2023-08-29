# Include the BoardConfig.mk of base product
include device/qcom/gen4_gvm/BoardConfig.mk


#If AVB is disabled need to override AB_OTA_PARTITIONS so that vbmeta is not part of
#OTA partiotion
ifeq ($(ENABLE_AB), true)
  AB_OTA_PARTITIONS := system system_ext vendor vendor_dlkm system_dlkm
endif

BOARD_AVB_ENABLE := false

DEVICE_MANIFEST_FILE := device/qcom/gen4_gvm_gy/manifest.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/gen4_gvm_gy/framework_manifest.xml

#Overwrite required variables below this
# Base product BoardConfigVendor.mk will already be included. So, use below to set new variables or to override old ones
-include $(QCPATH)/common/gen4_gvm_gy/BoardConfigVendor.mk

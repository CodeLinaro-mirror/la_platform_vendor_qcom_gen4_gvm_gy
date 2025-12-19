LOCAL_PATH := $(call my-dir)
ifeq ($(strip $(BOARD_DYNAMIC_PARTITION_ENABLE)),true)
  include $(CLEAR_VARS)
  LOCAL_MODULE       := fstab.qcom
  LOCAL_MODULE_TAGS  := optional
  LOCAL_MODULE_CLASS := ETC
  ifeq ($(ENABLE_AB), true)
    LOCAL_SRC_FILES := fstab_AB_dynamic_partition_variant.gen4_gy.qti
  else
    LOCAL_SRC_FILES := fstab_non_AB_dynamic_partition_variant.gen4_gy.qti
  endif #ENABLE_AB
  LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
  include $(BUILD_PREBUILT)
else
  include $(CLEAR_VARS)
  LOCAL_MODULE       := fstab.qcom
  LOCAL_MODULE_CLASS := ETC
  LOCAL_SRC_FILES    := $(LOCAL_MODULE)
  LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
  ifeq ($(ENABLE_VENDOR_IMAGE), true)
    LOCAL_POST_INSTALL_CMD := echo $(VENDOR_FSTAB_ENTRY) >> $(LOCAL_MODULE_PATH)/$(LOCAL_MODULE)
  endif
  include $(BUILD_PREBUILT)
endif ##BOARD_DYNAMIC_PARTITION_ENABLE

#----------------------------------------------------------------------
# Radio image
#----------------------------------------------------------------------
ifeq ($(ADD_RADIO_FILES), true)
radio_dir := $(LOCAL_PATH)/radio
RADIO_FILES := $(shell cd $(radio_dir) ; ls)
$(foreach f, $(RADIO_FILES), \
        $(call add-radio-file,radio/$(f)))
endif

# Include the base products AndroidBoard.mk
include device/qcom/gen4_gvm/AndroidBoard.mk


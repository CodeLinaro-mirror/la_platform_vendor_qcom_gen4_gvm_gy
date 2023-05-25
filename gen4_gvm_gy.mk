# Inherit from the base product
$(call inherit-product, device/qcom/msmnile_gvmq/msmnile_gvmq.mk)
TARGET_BASE_PRODUCT := msmnile_gvmq

PRODUCT_NAME := gen4_gvm_gy
PRODUCT_DEVICE := gen4_gvm_gy
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_gy for arm64

TARGET_OUT_INTERMEDIATES := out/target/product/$(PRODUCT_NAME)/obj
$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr:
	mkdir -p $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

# Change Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_DEVICE)/$(KERNEL_MODULES_INSTALL)/lib/modules
# TARGET_KERNEL_VERSION := 5.15
# TARGET_HAS_GENERIC_KERNEL_HEADERS := true
# Set the system.prop files to that of the inherited product plus the new product. Alternatively, the system.prop file can be copied over
# TARGET_SYSTEM_PROP := device/qcom/msmnile_gvmq/system.prop device/qcom/gen4_gvm/system.prop

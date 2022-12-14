# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common NusantaraROM stuff.
$(call inherit-product, vendor/nusantara/config/common_full_phone.mk)
$(call inherit-product-if-exists, packages/apps/NusantaraParts/nadproject.mk)
TARGET_BOOT_ANIMATION_RES := 720
# Offline Charger
USE_PIXEL_CHARGING := true
USE_AOSP_CLOCK := true
WITH_GMS=false
WITH_GAPPS=false
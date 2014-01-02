FW_DEVICE_IP=192.168.1.4
ARCHS = armv7 armv7s arm64
SDKVERSION = 7.0
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.0

SUBPROJECTS = Apps Helper

include theos/makefiles/common.mk
include theos/makefiles/aggregate.mk

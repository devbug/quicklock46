FW_DEVICE_IP=192.168.1.4
ARCHS = armv7 armv7s
TARGET = iphone:clang::6.0
SDKVERSION = 6.0

SUBPROJECTS = Apps Helper

include theos/makefiles/common.mk
include theos/makefiles/aggregate.mk

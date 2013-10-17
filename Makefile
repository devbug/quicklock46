FW_DEVICE_IP=192.168.1.4
ARCHS = armv7
TARGET = iphone:clang:5.0:5.0

SUBPROJECTS = Apps Helper

include theos/makefiles/common.mk
include theos/makefiles/aggregate.mk

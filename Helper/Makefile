FW_DEVICE_IP = 192.168.1.4
ARCHS = armv7
TARGET = iphone:clang:5.0:5.0

include theos/makefiles/common.mk

TWEAK_NAME = quicklock46helper
quicklock46helper_FILES = Tweak.xm
quicklock46helper_FRAMEWORKS = UIKit Foundation
quicklock46helper_PRIVATE_FRAMEWORKS = AppSupport
quicklock46helper_CFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

ri:: remoteinstall
remoteinstall:: all internal-remoteinstall after-remoteinstall
internal-remoteinstall::
	scp -P 22 "$(FW_PROJECT_DIR)/$(THEOS_OBJ_DIR_NAME)/$(TWEAK_NAME).dylib" root@$(FW_DEVICE_IP):
	scp -P 22 "$(FW_PROJECT_DIR)/$(TWEAK_NAME).plist" root@$(FW_DEVICE_IP):
	ssh root@$(FW_DEVICE_IP) "mv $(TWEAK_NAME).* /Library/MobileSubstrate/DynamicLibraries/"
after-remoteinstall::
	ssh root@$(FW_DEVICE_IP) "killall -9 SpringBoard"

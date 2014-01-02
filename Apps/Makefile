FW_DEVICE_IP = 192.168.1.4
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

APPLICATION_NAME = quicklock46
quicklock46_FILES = main.m quicklock46Application.mm RootViewController.mm
quicklock46_FRAMEWORKS = UIKit CoreGraphics
quicklock46_CFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/application.mk

ri:: remoteinstall
remoteinstall:: all internal-remoteinstall after-remoteinstall
internal-remoteinstall::
	scp -P 22 "$(FW_PROJECT_DIR)/$(THEOS_OBJ_DIR_NAME)/$(APPLICATION_NAME).app/$(APPLICATION_NAME)" root@$(FW_DEVICE_IP):
	ssh root@$(FW_DEVICE_IP) "mv $(APPLICATION_NAME) /Applications/$(APPLICATION_NAME).app/"
after-remoteinstall::
	ssh root@$(FW_DEVICE_IP) "killall -9 SpringBoard"

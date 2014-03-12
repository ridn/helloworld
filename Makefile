#TARGET=simulator:clang:7.0
ARCHS =  armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = helloworld
helloworld_FILES = Tweak.xm
helloworld_PRIVATE_FRAMEWORKS = BulletinBoard
include $(THEOS_MAKE_PATH)/tweak.mk

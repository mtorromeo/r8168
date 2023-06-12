CONFIG_SOC_LAN = n
ENABLE_FIBER_SUPPORT = n
ENABLE_REALWOW_SUPPORT = n
ENABLE_DASH_SUPPORT = n
ENABLE_DASH_PRINTER_SUPPORT = n
CONFIG_DOWN_SPEED_100 = n
CONFIG_ASPM = y
ENABLE_S5WOL = y
ENABLE_S5_KEEP_CURR_MAC = n
ENABLE_EEE = y
ENABLE_S0_MAGIC_PACKET = n
CONFIG_DYNAMIC_ASPM = y
ENABLE_USE_FIRMWARE_FILE = n
CONFIG_CTAP_SHORT_OFF = n

ifneq ($(KERNELRELEASE),)
	obj-m := r8168.o
	r8168-objs := r8168_n.o r8168_asf.o rtl_eeprom.o rtltool.o
	ifeq ($(CONFIG_SOC_LAN), y)
		EXTRA_CFLAGS += -DCONFIG_SOC_LAN
	endif
	ifeq ($(ENABLE_FIBER_SUPPORT), y)
	    r8168-objs += r8168_fiber.o
		EXTRA_CFLAGS += -DENABLE_FIBER_SUPPORT
	endif
	ifeq ($(ENABLE_REALWOW_SUPPORT), y)
	    r8168-objs += r8168_realwow.o
		EXTRA_CFLAGS += -DENABLE_REALWOW_SUPPORT
	endif
	ifeq ($(ENABLE_DASH_SUPPORT), y)
	    r8168-objs += r8168_dash.o
		EXTRA_CFLAGS += -DENABLE_DASH_SUPPORT
	endif
	ifeq ($(ENABLE_DASH_PRINTER_SUPPORT), y)
	    r8168-objs += r8168_dash.o
		EXTRA_CFLAGS += -DENABLE_DASH_SUPPORT -DENABLE_DASH_PRINTER_SUPPORT
	endif
	EXTRA_CFLAGS += -DCONFIG_R8168_NAPI
	EXTRA_CFLAGS += -DCONFIG_R8168_VLAN
	ifeq ($(CONFIG_DOWN_SPEED_100), y)
		EXTRA_CFLAGS += -DCONFIG_DOWN_SPEED_100
	endif
	ifeq ($(CONFIG_ASPM), y)
		EXTRA_CFLAGS += -DCONFIG_ASPM
	endif
	ifeq ($(ENABLE_S5WOL), y)
		EXTRA_CFLAGS += -DENABLE_S5WOL
	endif
	ifeq ($(ENABLE_S5_KEEP_CURR_MAC), y)
		EXTRA_CFLAGS += -DENABLE_S5_KEEP_CURR_MAC
	endif
	ifeq ($(ENABLE_EEE), y)
		EXTRA_CFLAGS += -DENABLE_EEE
	endif
	ifeq ($(ENABLE_S0_MAGIC_PACKET), y)
		EXTRA_CFLAGS += -DENABLE_S0_MAGIC_PACKET
	endif
	ifeq ($(CONFIG_DYNAMIC_ASPM), y)
		EXTRA_CFLAGS += -DCONFIG_DYNAMIC_ASPM
	endif
	ifeq ($(ENABLE_USE_FIRMWARE_FILE), y)
		r8168-objs += r8168_firmware.o
		EXTRA_CFLAGS += -DENABLE_USE_FIRMWARE_FILE
	endif
	ifeq ($(CONFIG_CTAP_SHORT_OFF), y)
		EXTRA_CFLAGS += -DCONFIG_CTAP_SHORT_OFF
	endif
else
	KERNELDIR ?= /lib/modules/$(shell uname -r)/build
	PWD :=$(shell pwd)
	TARGET_PATH := kernel/drivers/net/ethernet/realtek
	INBOXDRIVER := $(shell find $(subst build,$(TARGET_PATH),$(KERNELDIR)) -name r8168.ko.* -type f)

.PHONY:modules
modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

.PHONY: all
all: clean modules install

.PHONY: clean
clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean

.PHONY:install
install:
ifneq ($(shell lsmod | grep r8169),)
	rmmod r8169
endif
ifneq ($(shell lsmod | grep r8168),)
	rmmod r8168
endif
ifneq ($(INBOXDRIVER),)
	rm -f $(INBOXDRIVER)
endif
	$(MAKE) -C $(KERNELDIR) M=$(PWD) INSTALL_MOD_DIR=$(TARGET_PATH) modules_install
	modprobe r8168

endif

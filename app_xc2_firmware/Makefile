TARGET ?= XC-2
BASE_DIR = .

DEMO_SOURCE_DIRS = src \
		   src/misc \
                   src/config \
                   src/httpd \
                   src/httpd/fsdata 

SOURCE_DIRS = $(DEMO_SOURCE_DIRS)

INCLUDE_DIRS = $(DEMO_SOURCE_DIRS)

XCC_FLAGS = -Xmapper --map -Xmapper map.out -DMDNS_NETBIOS=1 -O3 -save-temps -g -DXC2_FIRMWARE_VERSION=2v0

EXCLUDE_FILES = httpd-fsdata.c app.c fsdata.c fsdata_old.c

USED_MODULES = module_xtcp module_zeroconf module_ethernet module_locks

USE_XTCP_MAC_CUSTOM_FILTER = 1

XCC_FLAGS_Debug = $(XCC_FLAGS)
XCC_FLAGS_Release = $(XCC_FLAGS)

#=============================================================================
# The following part of the Makefile includes the common build infrastructure
# for compiling XMOS applications. You should not need to edit below here.

XMOS_MAKE_PATH ?= ../..
include $(XMOS_MAKE_PATH)/xcommon/module_xcommon/build/Makefile.common

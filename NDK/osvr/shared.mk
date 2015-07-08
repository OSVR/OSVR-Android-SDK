OSVR_LIB_TYPE := SHARED
OSVR_LIB_SUFFIX := so
OSVR_TARGET_ARCH_ABI := $(TARGET_ARCH_ABI)

OSVR_LIBS_DIR := $(OSVR_ROOT)/$(OSVR_TARGET_ARCH_ABI)/lib
OSVR_INCLUDES_DIR := $(OSVR_ROOT)/$(OSVR_TARGET_ARCH_ABI)/include


include $(CLEAR_VARS)
LOCAL_MODULE:=jsoncpp_link
LOCAL_C_INCLUDES:=$(OSVR_INCLUDES_DIR)
LOCAL_SRC_FILES:=$(OSVR_LIBS_DIR)/libjsoncpp.$(OSVR_LIB_SUFFIX)
include $(PREBUILT_$(OSVR_LIB_TYPE)_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE:=osvrCommon
LOCAL_C_INCLUDES:=$(OSVR_INCLUDES_DIR)
LOCAL_SRC_FILES:=$(OSVR_LIBS_DIR)/libosvrCommon.$(OSVR_LIB_SUFFIX)
LOCAL_SHARED_LIBRARIES:=jsoncpp_link
include $(PREBUILT_$(OSVR_LIB_TYPE)_LIBRARY)

# Used to define internal modules that won't be used directly
# (and thus can have dependencies ignored)
define add_osvr_module
    include $(CLEAR_VARS)
    LOCAL_MODULE:=osvr$1
    LOCAL_C_INCLUDES:=$(OSVR_INCLUDES_DIR)
    LOCAL_SRC_FILES:=$(OSVR_LIBS_DIR)/libosvr$1.$(OSVR_LIB_SUFFIX)
    include $(PREBUILT_$(OSVR_LIB_TYPE)_LIBRARY)
endef

ifeq ($(OSVR_SHARED_MK_INCLUDED),)
    OSVR_COMMON_LIBS := Client Connection PluginHost Server Util VRPNServer
    $(foreach module,$(OSVR_COMMON_LIBS),$(eval $(call add_osvr_module,$(module))))
    OSVR_SHARED_MK_INCLUDED := ON
endif
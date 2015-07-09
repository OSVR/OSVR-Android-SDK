LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE    := dummy
LOCAL_SRC_FILES := dummy.cpp
LOCAL_SHARED_LIBRARIES := osvrClientKit
include $(BUILD_SHARED_LIBRARY)

$(call import-add-path,../../NDK)
$(call import-module,osvr/ClientKit)
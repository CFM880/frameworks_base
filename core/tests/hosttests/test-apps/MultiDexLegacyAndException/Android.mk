# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)


## The application with a minimal main dex
include $(CLEAR_VARS)

LOCAL_STATIC_JAVA_LIBRARIES := android-support-multidex android-support-multidex-instrumentation androidx.test.rules
LOCAL_MODULE_TAGS := tests

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_SDK_VERSION := 8

LOCAL_PACKAGE_NAME := MultiDexLegacyAndException
LOCAL_LICENSE_KINDS := SPDX-license-identifier-Apache-2.0
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE  := $(LOCAL_PATH)/../../../../../NOTICE

LOCAL_DEX_PREOPT := false

LOCAL_JAVACFLAGS := -nowarn

mainDexList:= \
    $(call intermediates-dir-for,APPS,$(LOCAL_PACKAGE_NAME),$(LOCAL_IS_HOST_MODULE),common)/maindex.list

LOCAL_DX_FLAGS := --multi-dex --main-dex-list=$(mainDexList) --minimal-main-dex

LOCAL_MIN_SDK_VERSION := 8

include $(BUILD_PACKAGE)

# $(mainDexList): $(full_classes_pre_proguard_jar) $(MAINDEXCLASSES) $(PROGUARD_DEPS)
# 	$(hide) mkdir -p $(dir $@)
#	PROGUARD_HOME=$(PROGUARD_HOME) $(MAINDEXCLASSES) $< 1>$@
#	echo "com/android/multidexlegacyandexception/Test.class" >> $@

$(built_dex_intermediate): $(mainDexList)

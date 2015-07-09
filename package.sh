#!/bin/sh -e


(
cd $(dirname $0)
tar -jcvf osvr-android-ndk.tar.bz2 NDK
)
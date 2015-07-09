#!/bin/sh -e
(
cd $(dirname $0) && cd NDK-test
for dir in *; do
    echo "-------------- $dir --------------"
    ndk-build NDK_LOG=1 V=1 -C $dir
done
)

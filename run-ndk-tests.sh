#!/bin/sh

#Include sh2ju
. $(dirname $0)/sh2ju/sh2ju.sh

(
cd $(dirname $0) && cd NDK-test
juLogClean
for dir in *; do
    juLog -name=$dir               ndk-build NDK_LOG=1 V=1 -C $dir
done
)

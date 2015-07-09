#!/bin/sh

ROOT=$(cd $(dirname $0) && pwd)
#Include sh2ju
. ${ROOT}/sh2ju/sh2ju.sh

(
cd ${ROOT}/NDK-test
juLogClean

# Loop through each test case
for dir in *; do
    # Loop through each ABI
    cat ${ROOT}/abilist.txt | while read ABI; do
        echo "------------ $dir.$ABI ------------"
        # Log the build as a test.
        juLog -name=$dir.$ABI \
          ndk-build NDK_LOG=1 V=1 APP_ABI=$ABI -C $dir
    done
done
)

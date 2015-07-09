#!/bin/sh -e
(
cd $(dirname $0)
builds=$(cd NDK/osvr/builds && pwd)

cd snapshots
for abi in *; do
    echo "Moving build for ABI $abi"
    mv $abi/build/install $builds/$abi
done

echo " ---------- Compressing!"
cd $(dirname $0)
tar -jcvf osvr-android-ndk.tar.bz2 NDK
)
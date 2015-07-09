#!/bin/sh -e

# Given a string describing a matrix build as Jenkins Copy-Artifacts does
# (like ANDROID_ABI=armeabi-v7a,label=ndk) on the pipeline, get the named field.
# Example: echo ANDROID_ABI=armeabi-v7a,label=ndk | getMatrixField ANDROID_ABI
# outputs armeabi-v7a to stdout.
getMatrixField() {
    tr ',' '\n' | grep "$1" | cut --only-delimited -d = -f 2
}


(
cd $(dirname $0)
builds=$(cd NDK/osvr/builds && pwd)

cd snapshots
for dir in *; do
    abi=$(echo $dir | getMatrixField ANDROID_ABI)
    echo "Moving build: $dir"
    echo "Detected ABI: $abi"
    mv $dir/build/install $builds/$abi
done
)

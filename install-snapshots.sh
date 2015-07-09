#!/bin/sh -e

# Given a string describing a matrix build as Jenkins Copy-Artifacts does
# (like ANDROID_ABI=armeabi-v7a,label=ndk) on the pipeline, get the named field.
# Example: echo ANDROID_ABI=armeabi-v7a,label=ndk | getMatrixField ANDROID_ABI
# outputs armeabi-v7a to stdout.
getMatrixField() {
    tr ',' '\n' | grep "$1" | cut --only-delimited -d = -f 2
}

ROOT=$(cd $(dirname $0) && pwd)

(
cd $ROOT
builds=$(cd NDK/osvr/builds && pwd)
abis=""
cd snapshots
for dir in *; do
    abi=$(echo $dir | getMatrixField ANDROID_ABI)
    echo "Moving build: $dir"
    echo "Detected ABI: $abi"
    abis="${abis} $abi"
    mv $dir/build/install $builds/$abi
done

cd $ROOT

# Record list of ABIs
echo "OSVR_ABIS := $abis" > NDK/osvr_abis.mk

# Update all the tests with the full ABI list.
cd NDK-tests
for dir in *; do
    appmk="${dir}/jni/Application.mk"
    echo "APP_ABI := $abis" >> $appmk
done
)

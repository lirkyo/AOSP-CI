#!/bin/bash

mkdir ~/bin
PATH=~/bin:$PATH

cd ~

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# FUCK H
rm -rf ~/android
mkdir ~/android
cd ~/android

# Clone the Sync Repo
cd ~/android
repo init --depth=1 -u https://github.com/ProjectSakura/android.git -b 14 --git-lfs

# Sync the Sources
cd ~/android
echo '[DEBUG]repo sync -j6'
repo sync -j6

# Clone Device Specific
git clone --depth=1 -b lineage-21 https://github.com/whatawurst/android_device_sony_maple_dsds.git device/sony/maple_dsds
git clone --depth=1 -b lineage-21 https://github.com/whatawurst/android_device_sony_yoshino-common.git device/sony/yoshino-common

# Clone Vendor Specific
git clone --depth=1 -b lineage-21 https://github.com/whatawurst/android_vendor_sony_maple_dsds.git vendor/sony/maple_dsds
git clone --depth=1 -b lineage-21 https://github.com/whatawurst/android_vendor_sony_yoshino-common.git vendor/sony/yoshino-common

# Clone the Kernel Sources
git clone --depth=1 -b lineage-21 https://github.com/whatawurst/android_kernel_sony_msm8998.git kernel/sony/msm8998

cd ~/android
# Additional
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 gcc64
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 gcc32
mkdir clang && cd clang
wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/android12-release/clang-r416183b1.tar.gz
tar -xzf clang-r416183b1.tar.gz

exit 0

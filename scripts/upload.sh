#!/bin/bash

# Source Vars
# source $CONFIG
export REPO=https://github.com/ProjectSakura/android
export DEVICE=maple_dsds
export TYPE=userdebug
export AOSP=lineage
export BRANCH=14

export USE_CCACHE=1
export CCACHE_SIZE=50G
#export ALLOW_MISSING_DEPENDENCIES=true
# export LC_ALL="C"
##########################

# Change to the Source Directory
cd ~/android
# Color
ORANGE='\033[0;33m'

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

# Change to the Output Directory
cd out/target/product/${DEVICE}

# Set FILENAME var
ls lineage_maple_dsds*.zip > FILENAME.txt
FILENAME=$(cat FILENAME.txt)
cat FILENAME.txt
# Upload to oshi.at
if [ -z "$TIMEOUT" ];then
    TIMEOUT=20160
fi

# Upload to WeTransfer
# NOTE: the current Docker Image, "registry.gitlab.com/sushrut1101/docker:latest", includes the 'transfer' binary by Default
transfer wet *.zip > link.txt || { echo "ERROR: Failed to Upload the Build!" && exit 1; }

# Mirror to oshi.at
curl -T $FILENAME https://oshi.at/${FILENAME}/${OUTPUT} > mirror.txt || { echo "WARNING: Failed to Mirror the Build!"; }

DL_LINK=$(cat link.txt | grep Download | cut -d\  -f3)
MIRROR_LINK=$(cat mirror.txt | grep Download | cut -d\  -f1)

# Show the Download Link
echo "=============================================="
echo "Download Link: ${DL_LINK}" || { echo "ERROR: Failed to Upload the Build!"; }
echo "Mirror: ${MIRROR_LINK}" || { echo "WARNING: Failed to Mirror the Build!"; }
echo "=============================================="

DATE_L=$(date +%d\ %B\ %Y)
DATE_S=$(date +"%T")

# Exit
exit 0

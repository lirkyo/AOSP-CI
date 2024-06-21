#!/bin/bash

echo “Source Vars”
export USE_CCACHE=1
export CCACHE_SIZE=60G
export ALLOW_MISSING_DEPENDENCIES=true

# Change to the Source Directry
cd ~/android

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 60G
else
    ccache -M ${CCACHE_SIZE}
fi


# Prepare the Build Environment
cd ~/android

source build/envsetup.sh

lunch lineage_maple_dsds-ap1a-userdebug

# Build!
echo 'Start Build!'
mka bacon -j16

# Exit
exit 0

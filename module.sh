#!/bin/bash

VERSION=14/UKW1.250103.001
VERSION_CODE=12869825

echo "VERSION=$VERSION" >>"$GITHUB_ENV"
echo "VERSION_CODE=$VERSION_CODE" >>"$GITHUB_ENV"

# Create a VERSION file for release action
echo "VERSION=$VERSION" >>VERSION
echo "VERSION_CODE=$VERSION_CODE" >>VERSION

mkdir -p module/system/vendor
cp ARM_TO_AMD_DBT_LICENSE.txt module/
rsync -av -l prebuilts/ module/system/vendor

# Move init .rc files to /system
mkdir -p module/system/etc
mv module/system/vendor/etc/init module/system/etc

# Link list
# <source> <target>
LINKS=(
	"vendor/bin/houdini system/bin/houdini"
	"vendor/bin/houdini64 system/bin/houdini64"
	"vendor/bin/arm system/bin/arm"
	"vendor/bin/arm64 system/bin/arm64"
	"vendor/lib/arm system/lib/arm"
	"vendor/lib/libhoudini.so system/lib/libhoudini.so"
	"vendor/lib64/arm64 system/lib64/arm64"
	"vendor/lib64/libhoudini.so system/lib64/libhoudini.so"
	"vendor/etc/binfmt_misc system/etc/binfmt_misc"
)

for link in "${LINKS[@]}"; do
	src=$(echo "$link" | cut -d' ' -f1)
	dst=$(echo "$link" | cut -d' ' -f2)
	mkdir -p "module/$(dirname "$dst")"
	echo "ln -s /$src \$MODPATH/system/$dst" >>module/customize.sh
done

find sepolicy -name "*.te" -exec cat {} + >>module/sepolicy.rule
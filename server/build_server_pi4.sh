#!/bin/bash
# Raspberry Pi 4 Buildroot build script
# Run this script using `. ./buildroot-rpi4-build.sh` after sourcing the assignment helper script
# from this directory or one with necessary functions:
#   add_validate_error
#   validate_buildroot_config
#   before_script
# Before sourcing this script, ensure you have changed directory to the root of the buildroot
# build directory (which includes build.sh script)

# Ensure we use download cache by specifying on the commandline
export BR2_DL_DIR=~/.dl
mkdir -p ${BR2_DL_DIR}

# Remove config if it exists, to clear any previous partial runs
rm -rf buildroot/.config

# Set up Buildroot configuration for Raspberry Pi 4
make raspberrypi4_defconfig

# Modifications to specific packages or configs
# (e.g., modify package configs here if necessary)

# Validate and setup environment
if [ ! -e clean.sh ]; then
	echo "Creating clean.sh and setting executable permissions"
	echo '#!/bin/bash' > clean.sh
	echo "make distclean" >> clean.sh
	chmod a+x clean.sh
else
	if [ ! -x clean.sh ]; then
		echo "Setting executable permission for clean.sh"
		chmod a+x clean.sh
	fi
fi

# Set executable permissions for build.sh, if not already set
if [ ! -x build.sh ]; then
	add_validate_error "build.sh is not executable"
	echo "Setting executable permission for build.sh"
	chmod a+x build.sh
fi

# Validate build configuration
validate_buildroot_config

# Run preliminary scripts
before_script

echo "Running build.sh to compile the system"
bash build.sh
rc=$?
if [ $rc -ne 0 ]; then
	add_validate_error "Build script failed with error $rc"
	exit $rc
fi

# Optionally, you can add post-build actions here, like customizing the output image or handling deployment
echo "Build successful"

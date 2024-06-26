#!/bin/bash
# 1st argument: absolute or relative path to the base directory
# Defaults to dirname `git rev-parse --absolute-git-dir` if not specified

source script-helpers

script_dir="$(pwd -P )"
testdir=$1
executable_path=/usr/bin	#Path where writer,finder,tester.sh are stored
ROOTFS_PATH=buildroot/output/target/${executable_path}		# add ${script_dir} before buildroot to make it an absolute path 

pushd ${testdir}
. ${script_dir}/build_server_pi4.sh
popd
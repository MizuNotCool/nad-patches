#!/bin/bash

set -e

source="$(dirname "$(readlink -f -- "$0")")"
phh="$source/patches/phh"
personal="$source/patches/personal"

printf "\n #### APPLYING PHH PATCHES ####\n";
sleep 1.0;
for path in $(cd $phh; echo *); do
	tree="$(tr _ / <<<$path | sed -e 's;platform/;;g')"
	printf "\n| $path #####\n";
	[ "$tree" == build ] && tree=build/make
    [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
    [ "$tree" == treble/app ] && tree=treble_app
	pushd $tree

	for patch in $phh/$path/*.patch; do
		# Check if patch is already applied
		if patch -f -p1 --dry-run -R < $patch > /dev/null; then
            printf "### ALREDY APPLIED: $patch \n";
			continue
		fi

		if git apply --check $patch; then
			git am $patch
		elif patch -f -p1 --dry-run < $patch > /dev/null; then
			#This will fail
			git am $patch || true
			patch -f -p1 < $patch
			git add -u
			git am --continue
		else
			printf "### FAILED APPLYING: $patch \n"
		fi
	done

	popd
done



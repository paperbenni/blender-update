#!/bin/bash

if pgrep 2.81.sh; then
	echo "another one already running"
	exit 1
fi

if ! wget --version; then
	echo "please install wget to proceed"
fi

pushd ~/
if ! ls ~/.cache/blender81; then
	mkdir -p .cache/blender81
fi

if ! curl google.com; then
	echo "curl not installed or no internet"
	if [ -e .cache/blender81/blender/blender ]; then
		.cache/blender81/blender/blender
	else
		exit 0
	fi
else
	echo internet >.cache/blender81/internet.txt
fi

if [ -e .cache/blender81/internet.txt ]; then
	echo "checking for updates"
	cd .cache/blender81
	rm internet.txt
	if ! ls *.tar.bz2; then
		touch blender.tar.bz2
	fi
	CURRENT=$(ls *.tar.bz2)
	if curl https://builder.blender.org/download/ | grep "$CURRENT"; then
		echo "up to date"
	else
		if ls *.tar.bz2; then
			rm *.tar.bz2
		fi
		echo "updating blender"
		wget -r --no-parent -A 'blender-2.81*linux*x86_64.tar.bz2' https://builder.blender.org/download/
		cd builder.blender.org/download
		tar -xvjf *.tar.bz2
		mv *.tar.bz2 ../../
		mv ./blender* ./blender
		rm -rf ../../blender
		mv ./blender ~/.cache/blender81
		cd ../..
		chmod +x blender/blender
		mv ./*.tar.bz2 ~/.cache/blender81
	fi
	~/.cache/blender81/blender/blender
fi

popd

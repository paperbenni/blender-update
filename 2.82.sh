#!/bin/bash

if pgrep wget || pgrep blender || [ -e ~/.blenderupdating ]; then
	echo "another instance already running"
	exit 1
fi

if ! wget --version; then
	echo "please install wget to proceed"
fi

pushd ~/
if ! ls ~/.cache/blender82; then
	mkdir -p .cache/blender82
fi

if ! curl google.com; then
	echo "curl not installed or no internet"
	if [ -e .cache/blender82/blender/blender ]; then
		.cache/blender82/blender/blender
	else
		exit 0
	fi
else
	echo internet >.cache/blender82/internet.txt
fi

if [ -e .cache/blender82/internet.txt ]; then
	echo "checking for updates"
	cd .cache/blender82
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
		wget -r --no-parent -A 'blender-2.82*linux*x86_64.tar.bz2' https://builder.blender.org/download/
		cd builder.blender.org/download
		touch ~/.blenderupdating
		tar -xvjf *.tar.bz2
		mv *.tar.bz2 ../../
		mv ./blender* ./blender
		rm -rf ../../blender
		mv ./blender ~/.cache/blender82
		cd ../..
		chmod +x blender/blender
		mv ./*.tar.bz2 ~/.cache/blender82
		rm ~/.blenderupdating
	fi
	~/.cache/blender82/blender/blender
fi

popd

#!/bin/bash
pushd ~/
if ! ls ~/.cache/blender7; then
	mkdir -p .cache/blender7
fi

if ! curl google.com; then
	echo "curl not installed or no internet"
	if [ -e .cache/blender7/blender/blender ]; then
		.cache/blender7/blender/blender
	else
		exit 0
	fi
else
	echo internet >.cache/blender7/internet.txt
fi


if [ -e .cache/blender7/internet.txt ]; then
	cd .cache/blender7
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
		wget -r --no-parent -A 'blender-2.79*linux*x86_64.tar.bz2' https://builder.blender.org/download/
		cd builder.blender.org/download
		tar -xvjf *.tar.bz2
        mv *.tar.bz2 ../../
        mv ./blender* ./blender
		rm -rf ../../blender
		mv ./blender ~/.cache/blender7
		cd ../..
		chmod +x blender/blender
		mv ./*.tar.bz2 ~/.cache/blender7
	fi
	~/.cache/blender7/blender/blender
fi

popd

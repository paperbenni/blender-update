#!/bin/bash
#########################################################
## automatically updates and runs blender daily builds ##
#########################################################

if pgrep wget || pgrep blender || [ -e /tmp/blenderupdating ]; then
	notify-send "the blender updater is already running"
	echo "another instance already running"
	exit 1
fi

if ! command -v wget &>/dev/null; then
	echo "please install wget to proceed"
fi

[ -e ~/.cache/blender83 ] || mkdir -p ~/.cache/blender83
cd ~/.cache/blender83 || exit
curl -s 'https://builder.blender.org/download/' >download.html
CURRENTVERSION="$(grep -o 'blender-2.83-[a-zA-Z0-9]*-linux64.tar.xz' download.html)"

if [ -e curversion ]; then
	if [ "$CURRENTVERSION" = "$(cat curversion)" ]; then
		echo "already up to date"
	fi
else
	echo "updating blender, please wait. "
	notify-send "updating blender, please wait. Do not open another instance"
	touch /tmp/blenderupdating
	rm -rf ./*blender*
	rm -rf ./blender*
	wget https://builder.blender.org/download/"$CURRENTVERSION"
	echo "$CURRENTVERSION" >curversion
	mv *.tar.xz blender.tar.xz
	notify-send "extracting blender archive"
	tar -xf blender.tar.xz
	rm blender.tar.xz
	mv blender* blender
	chmod +x ./blender/blender
	rm /tmp/blenderupdating
fi

./blender/blender

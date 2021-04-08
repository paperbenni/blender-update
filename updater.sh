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
    command -v instantinstall && {
        instantinstall wget || exit 1
    }
    echo "please install wget to proceed"
    exit 1
fi

[ -e ~/.cache/blender93 ] || mkdir -p ~/.cache/blender93
cd ~/.cache/blender93 || exit

echo "checking for updates"
CURRENTVERSION="$(
    curl -s https://builder.blender.org/download/ | grep -o '/download/blender[^"]*tar.xz"' |
        grep linux | tail -1 | grep -o '[^"]*' | grep -o '[^/]*$'
)"

if [ -e curversion ] && [ "$CURRENTVERSION" = "$(cat curversion)" ]; then
    
    echo "blender already up to date"
else
    echo "updating blender, please wait. "
    notify-send "updating blender, please wait. Do not open another instance"
    touch /tmp/blenderupdating
    rm -rf ./*blender*
    rm -rf ./blender*
    wget https://builder.blender.org/download/"$CURRENTVERSION"
    echo "$CURRENTVERSION" >curversion
    mv ./*.tar.xz blender.tar.xz
    notify-send "extracting blender archive"
    tar -xf blender.tar.xz
    rm blender.tar.xz
    mv blender* blender
    chmod +x ./blender/blender
    rm /tmp/blenderupdating

fi

./blender/blender

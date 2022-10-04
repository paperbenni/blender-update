#!/bin/bash
#########################################################
## automatically updates and runs blender daily builds ##
#########################################################

if {
    pgrep wget || pgrep blender || [ -e /tmp/blenderupdating ]
} && ! [ "$1" = "-f" ]; then
        notify-send "the blender updater is already running" &
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

[ -e ~/.cache/blender34 ] || mkdir -p ~/.cache/blender34
cd ~/.cache/blender34 || exit

echo "checking for updates"
CURRENTVERSION="$(curl -s https://builder.blender.org/download/daily/ | grep -io '"[^"]*blender[^"]*3.4.0[^"]*linux[^"]*xz"' | sort -u | grep -o '[^"]*')"
echo "current version $CURRENTVERSION"

if [ -e curversion ] && [ "$CURRENTVERSION" = "$(cat curversion)" ]; then
    echo "blender already up to date"
else
    echo "updating blender, please wait. "
    notify-send "updating blender, please wait. Do not open another instance" &
    touch /tmp/blenderupdating
    rm -rf ./*blender*
    rm -rf ./blender*
    echo "downloading $CURRENTVERSION"

    if command -v aria2c
    then
        aria2c "$CURRENTVERSION"
    else
        wget "$CURRENTVERSION"
    fi

    echo "$CURRENTVERSION" >curversion
    if ! ls | grep -q '\.tar\.xz'; then
        echo 'blender download failed'
        notify-send 'blender download failed' &
        rm /tmp/blenderupdating
        rm curversion
        exit 1
    fi
    mv ./*.tar.xz blender.tar.xz
    notify-send "extracting blender archive" &
    tar -xf blender.tar.xz
    rm blender.tar.xz
    mv blender* blender
    chmod +x ./blender/blender
    rm /tmp/blenderupdating

fi

./blender/blender

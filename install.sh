#!/bin/bash
cd
LINK=https://github.com/paperbenni/blender-update.git
mkdir workspace
cd workspace

if ! [ -e blender-update ]; then
    git clone --depth=1 "$LINK"
    cd blender-update
else
    cd blender-update
    git pull
fi

chmod +x *.sh
mv *.desktop ~/.local/share/applications

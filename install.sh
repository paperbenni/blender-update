#!/bin/bash
cd
LINK=https://github.com/paperbenni/blender-update.git
mkdir workspace
cd workspace

git clone --depth=1 "$LINK"
cd blender-update
chmod +x *.sh
mv *.desktop ~/.local/share/applications

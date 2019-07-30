#!/bin/bash
LINK="https://raw.githubusercontent.com/paperbenni/blender-update/master"
cd
mkdir blender-update
cd blender-update
wget "$LINK/2.79.sh"
wget "$LINK/2.80.sh"
wget "$LINK/2.81.sh"
wget "$LINK/Blender2.79.svg"
wget "$LINK/Blender2.80.svg"
wget "$LINK/Blender2.81.svg"

chmod +x *.sh

cd
cd ./.local/share/applications
wget "$LINK/blender2.79.desktop"
wget "$LINK/blender2.80.desktop"
wget "$LINK/blender2.81.desktop"

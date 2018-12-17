#!/bin/bash
cd $HOME
mkdir -p workspace/blender-update
cd workspace/blender-update
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/2.79.sh
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/2.80.sh
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/Blender2.70.svg
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/Blender2.80.svg

chmod +x *.sh

cd $HOME

cd ./.local/share/applications
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/blender27.desktop
wget https://raw.githubusercontent.com/paperbenni/blender-update/master/blender28.desktop
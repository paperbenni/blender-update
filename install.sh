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
echo "installing desktop entries"
cp *.desktop ~/.local/share/applications/
echo "replacing home dir"
sed -i 's:HOME:'"$HOME"':g' ~/.local/share/applications/blender2.*.desktop

echo "done installing"
echo "starting the app up might take a while, it downloads blender"
echo "do not force quit the app!"
echo "check your network usage to see if its working"

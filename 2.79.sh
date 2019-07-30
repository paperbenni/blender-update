#!/bin/bash
if [ -e .cache/blender7/blender ]; then
    .cache/blender7/blender
    exit 0
fi

curl cht.sh > /dev/null || exit 1
command -v wget || exit 1

cd
mkdir -p .cache/blendercache &> /dev/null
cd .cache/blendercache
echo "downloading blender"
wget https://ftp.halifax.rwth-aachen.de/blender/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2
tar -xvjf *.tar.bz2
rm *.tar.bz2
mv ./blender* ../blender7
cd ..
chmod +x blender7/blender
rm -rf blendercache
~/.cache/blender7/blender

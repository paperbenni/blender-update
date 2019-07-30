#!/bin/bash
if [ -e .cache/blender8/blender/blender ]; then
    .cache/blender8/blender/blender
    exit 0
fi

curl cht.sh > /dev/null || exit 1
command -v wget || exit 1

cd
mkdir -p .cache/blendercache &> /dev/null
cd .cache/blendercache
echo "downloading blender"
wget https://ftp.halifax.rwth-aachen.de/blender/release/Blender2.80/blender-2.80rc3-linux-glibc217-x86_64.tar.bz2
tar -xvjf *.tar.bz2
rm *.tar.bz2
mv ./blender* ../blender8
cd ..
chmod +x blender8/blender
rm -rf blendercache
~/.cache/blender8/blender

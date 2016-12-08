#!/bin/sh

mkdir /Volumes/Untitled/
mount -t afp afp://deploystudio-tower.local/DS /Volumes/Untitled

echo "Mounted DS on /Volumes/Untitled"
curl 10.0.2.252/er2utils/OSSelect.py | python
echo "Selected workflow: "

exit 0

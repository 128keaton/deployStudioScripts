LOCATION=10.0.2.252/er2utils
SERIAL="$( system_profiler SPHardwareDataType | grep 'Serial Number' | sed 's/.*: //'  | head -n 1 )" 
curl $LOCATION/AppleInfo.sh | bash
scp -o StrictHostKeyChecking=no /Volumes/Untitled/$SERIAL.txt apple@10.0.2.252:$SERIAL.txt
ssh -o StrictHostKeyChecking=no apple@10.0.2.252 "./print.sh $SERIAL"
rm /Volumes/Untitled/$SERIAL.txt
# curl $LOCATION/AppleDiskWipe | bash

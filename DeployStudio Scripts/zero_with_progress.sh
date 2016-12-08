#!/bin/sh
#
# This script uses cocoaDialog to bring up a GUI dialog requesting which package to install. It will set a variable to be used later in the workflow.

# Set the 891 variable
# Path to the cocoaDialog tool
POPUP=/Volumes/Untitled/cocoaDialog.app/Contents/MacOS/cocoaDialog

# create a named pipe
rm -f /tmp/hpipe
mkfifo /tmp/hpipe

# create a background job which takes its input from the named pipe
$POPUP progressbar \
	--float \
	--title "Zeroing Disk" \
	< /tmp/hpipe &



# associate file descriptor 3 with that pipe and send a character through the pipe
exec 3<> /tmp/hpipe
echo -n . >&3

diskutil unmountDisk /dev/disk0
DISKSIZEBYTES=$( diskutil info /dev/disk0 | grep "Total Size" | sed 's/.*(\([0-9]*\) Bytes.*/\1/g' )
DISKSIZE="$(expr $DISKSIZEBYTES / 1024 / 1024 / 1024)G"
echo "Disk size: $DISKSIZE"


# do all of your work here
(/Volumes/Untitled/pv -n -s $DISKSIZE < /dev/zero > /dev/rdisk0) 2>&3


# now turn off the progress bar by closing file descriptor 3
exec 3>&-

# wait for all background jobs to exit
wait
rm -f /tmp/hpipe

exit 0


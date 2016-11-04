DRIVE=Untitled
SERIAL="$( system_profiler SPHardwareDataType | grep 'Serial Number' | sed 's/.*: //'  | head -n 1 )"  
VERSION="$( system_profiler SPHardwareDataType | grep 'Processor Name' | sed 's/.*: \([A-Za-z]*\) .*/\1/' )" 


echo -e " Name: "  " $( curl -s http://support-sp.apple.com/sp/product?cc=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-` | sed 's|.*<configCode>\(.*\)</configCode>.*|\1|' ) " >> /Volumes/$DRIVE/$SERIAL.txt
echo " Model: " $( sysctl -n hw.model ) >> /Volumes/$DRIVE/$SERIAL.txt
    
echo " Memory:" $( expr $( sysctl -n hw.memsize ) / 1024 / 1024 / 1024 ) " GB" >> /Volumes/$DRIVE/$SERIAL.txt
echo -e " Memory Speed:" $( system_profiler SPMemoryDataType | grep Speed | grep -v Empty | sed -e 's/Speed: //g' | tail -1 ) >> /Volumes/$DRIVE/$SERIAL.txt
echo -e " Memory Type:" $( system_profiler SPMemoryDataType | grep Type | grep -v Empty | sed -e 's/Type: //g' | tail -1 ) >> /Volumes/$DRIVE/$SERIAL.txt


if [[ $VERSION == *"Intel"* ]]
then
	echo -e " CPU:\n" "$( system_profiler SPHardwareDataType | grep -E 'Processor Name|Processor Speed|Number of Processors|Total Number of Cores' | sed 's/ *Processor Name/     Processor Name/g' )" >> /Volumes/$DRIVE/$SERIAL.txt
	echo -e "       Model:" $( sysctl -n machdep.cpu.brand_string | sed 's/.*CPU *//' | sed 's/ *@.*//') >> /Volumes/Untitled/$SERIAL.txt

	echo " Graphics:" $( system_profiler SPDisplaysDataType | grep "Chipset" | sed 's/.*: //' ) >> /Volumes/$DRIVE/$SERIAL.txt
	echo -e " Disk Drives:\n" "$( system_profiler SPSerialATADataType | grep -E 'Model|Capacity|Medium' | grep -vE 'DVD-*' | grep -vE '              C' |  sed -e 's/\(GB\) .*/\1/g'  -e 's/\(TB\) .*/\1/g' -e 's/Medium/Drive/g' -e 's/Rotational/HDD/g' -e 's/ C/C/g' -e 's/ *Capacity/     Capacity/g' -e 's/ *Drive/      Drive/g' -e 's/ *Model/      Model/g ' | grep -vE 'Volume UUID:*'  )" "\n\n" >> /Volumes/$DRIVE/$SERIAL.txt
elif [[ $VERSION == *"PowerPC"* ]]
then
	echo -e " OS Version: Mac OS X 10.5: Leopard" >> /Volumes/$DRIVE/$SERIAL.txt
	echo -e " CPU:\n" "$( system_profiler SPHardwareDataType | grep -E 'Processor Name|Processor Speed|Number Of CPUs|Total Number of Cores'  | sed 's/ *Number Of CPUs/      Total Number of Cores/g' | sed 's/ *Processor Name/     Processor Name/g' )" >> /Volumes/$DRIVE/$SERIAL.txt
	echo -e "      " $( system_profiler SPHardwareDataType | grep -E 'Model Name:' ) >> /Volumes/Untitled/$SERIAL.txt

	echo " Graphics:" $( system_profiler SPDisplaysDataType | grep "Chipset" | sed 's/.*: //' ) >> /Volumes/$DRIVE/$SERIAL.txt
	echo -e " Disk Drives:\n" "$( system_profiler SPSerialATADataType | grep -E 'Model|Capacity|Medium' | sed -e 's/\(GB\) .*/\1/g' -e 's/Medium/Drive/g' -e 's/Rotational/HDD/g' -e 's/^              Capacity.*//g' -e 's/ C/C/g' -e 's/ *Capacity/     Capacity/g' -e 's/ *Drive/      Drive/g' -e 's/ *Model/      Model/g' )" "\n\n" >> /Volumes/$DRIVE/$SERIAL.txt
else
	echo "Something's busted!  Call for help! (blame Erick, he did it I swear!)"
fi

echo -e " Serial: $SERIAL" >> /Volumes/$DRIVE/$SERIAL.txt
CPU=" $( system_profiler SPHardwareDataType | grep 'Processor Name' | sed 's/.*: \([A-Za-z]*\) .*/\1/' )" 

if [ $CPU = "PowerPC" ]
then
	echo "RuntimeSelectWorkflow: InstallLeopard"
else
	curl 10.0.2.252/er2utils/OSSelect.py | python
fi

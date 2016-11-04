import os

snowLeopard=[
		"MacMini1",
		"MacBook1",
		"MacBookPro1"

]
lion=[
		"iMac4",
		"iMac5",
        "iMac6",
        "MacBookAir1",
        "MacBookPro2",
        "MacBook2",
        "MacBook3",
        "MacBook4",
        "MacPro2",
        "MacPro1",
        "MacMini2"
]

elCapitan=[
		"iMac7",
        "iMac8",
        "iMac9",
        "MacBook6",
        "MacBook5",
        "MacBook7",
        "MacBookPro3",
        "MacBookPro4",
        "MacBookPro5",
        "MacBookAir2",
        "MacPro4",
        "MacPro3",
        "MacMini3"
]

modelFamily = os.popen("sysctl -n hw.model | sed 's/,[0-9]//' ").read().rstrip("\n")
serial = os.popen("system_profiler SPHardwareDataType | grep 'Serial Number' | sed 's/.*: //'  | head -n 1").read().rstrip("\n")
fileName = "/Volumes/Untitled/%s.txt" % serial
newFile = open(fileName, 'w')
print(modelFamily)

if modelFamily in elCapitan:
	newFile.write(" OS: 10.11 El Capitan\n")
	print("RuntimeSelectWorkflow: InstallElCapitan")
	
elif modelFamily in lion:
	newFile.write(" OS: 10.7 Lion\n")
	print("RuntimeSelectWorkflow: InstallLion")
elif modelFamily in snowLeopard:
	newFile.write(" OS: 10.6 Snow Leopard\n")
	print("RuntimeSelectWorkflow: InstallSL")
else:
	newFile.write(" OS: 10.12 Sierra\n")
	print("RuntimeSelectWorkflow: InstallSierra")
    
newFile.close()
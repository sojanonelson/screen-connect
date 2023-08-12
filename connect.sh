#!/bin/bash
echo -e "\e[32m Connecting...\e[25m \e[0m"
#adb devices
adb kill-server
output=$(adb devices)
device_lines=$(echo "$output" | grep -E '^[0-9a-f]+\s+device$')
if [ -z "$device_lines" ]; then
  echo "Could not find any adb devices"
else
  adb tcpip 5555
  adb connect 192.168.108.63:5555
  echo -e "\e[1m\e[32m[+] ADB done!"
  echo "$device_lines"
fi

#scrcpy
errorb=$(scrcpy 2>&1)
scrcpy --bit-rate 2M --max-size 800
if [ -z "$errorb" ]; then
  echo -e "\e[1m\e[32m[+]Scrcpy done!"
  echo -e "\e[32mAll done..."
  echo -e "\e[33m[#]You can unplug your device"

else
  clear
  echo -e "\e[31m[-]scrcpy stopped!\e[0m"
fi
                           

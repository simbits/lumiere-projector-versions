#!/bin/bash

MNT_LED=stat1

UPDATED=false

while true
do
	dev=$(blkid | grep sd | awk -F ':' '{print $1}')

	if [[ -n $dev ]]
	then
		if [[ "$UPDATED" = false ]]
		then
			echo 1 > /sys/class/leds/${MNT_LED}/brightness
			echo "mounting $dev"
			mount $dev /mnt

			if [[ -f /mnt/lumierefw.bin ]]
			then
				killall receiver_simple.bin
				killall player.bin
				psplash-write QUIT
				cp /mnt/lumierefw.bin /tmp
				chmod +x /tmp/lumierefw.bin
				/tmp/lumierefw.bin
				rm /tmp/lumierefw.bin
			fi
			umount /mnt
			echo 0 > /sys/class/leds/${MNT_LED}/brightness
			UPDATED=true
			reboot
		fi
	else
		UPDATED=false
	fi

	sleep 5
done

echo $MNT_GPIO > /sys/class/gpio/unexport

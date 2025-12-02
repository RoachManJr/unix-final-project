while true; do
	PS3="Please select an operation: "
	select cnt in DisplayNetworkInterfaces EnableOrDisableNetworkInterface IPAddressAssignment DisplayAvailableWiFiNetworks Exit
	do
	case $cnt in
		DisplayNetworkInterfaces)
			for interface in $(ls /sys/class/net/); do
				ip_address=$(ip -o -4 addr show $interface | awk '{print $4}')
				gateway=$(ip route show default dev $interface | awk '/default/ {print $3}')
				if [ -n "$ip_address" ]; then
					echo -n "Interface: $interface, IP Address: $ip_address"
					if [ -n "$gateway" ]; then
						echo ". Gateway: $gateway"
					else
						echo ", No Default Gateway"
					fi
				else
					echo "Interface: $interface, No IP Address assigned"
				fi
			done
			echo ""
			break 1
			;;
		EnableOrDisableNetworkInterface)
			PS3="Would you like to enable or disable a network interface? 1 for Enable, 2 for Disable: "
			while true; do
				select choice in Enable Disable Return
				do
				case $choice in
					Enable)
					read -p "Please enter the name of the network interface you would like to enable " interfaceName
					sudo ip link set "$interfaceName" up
					echo ""
					break 1
					;;
					Disable)
					read -p "Please enter the name of the network interface you would like to disable " interfaceName
					sudo ip link set "$interfaceName" down
					echo ""
					break 1
					;;
					Return)
					echo "Returning to Network Management Menu"
					echo ""
					break 2
					;; 
					*)
					echo "Invalid"
					;;
				esac
				done
			done
			echo ""
			break 1
			;;
		IPAddressAssignment)
			read -p "Enter the Interface you want to assign an IP Address to: " interfaceName
			read -p "Enter the IP Address you want to assign to that Interface: " ipAddress
			sudo ip addr add $ipAddress dev $interfaceName
			echo ""
			break 1
			;;
		DisplayAvailableWiFiNetworks)
			nmcli device wifi list
			read -p "Enter the name of the network you would like to connect to: " network
			read -p "Enter the password of that network: " passwordInput
			nmcli device wifi connect $network password $passwordInput
			echo ""
			break 1
			;;
		Exit)
			echo "Goodbye"
			break 2
			;;
		*)
			echo "Invalid"
			;;
	esac
	done
done

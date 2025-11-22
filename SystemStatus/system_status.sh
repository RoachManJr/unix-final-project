
while true ; do
echo "SYSTEM STATUS"
echo "Choose an Option with the number 1 to 5: "
echo "1) Display detailed memory usage"
echo "2) Check the CPU temperature"
echo "3) List all active system processes (use the key q for exiting)"
echo "4) Terminate an active program with the PID"
echo "5) Main Menu"
read -p "option : "  option 
echo " "
	case $option in
		1)
			free -h
			;;
		2)
			cd ~
			temp=$(cat /sys/class/thermal/thermal_zone9/temp);
			result=$((temp / 1000));
			echo -e "\e[34m Temperature    ${result} C \e[0m"
			if [ $result -gt 70 ]; then
				echo "Warning: the CPU is extremely hot"
			fi
			;;
		3)
			echo "enter Ctrl + Z to exit"
			top
			;;
		4)
		echo "Enter the PID of the process that you want to terminate"
		read PID
		kill $PID;;
		Menu)
		echo "nothing yet"
		;;
		*)
		echo  "invalid option";;
esac
		echo " "
done
			
	
			

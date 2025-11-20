echo "SYSTEM STATUS"
echo "Choose an Option with the number 1 to 5: "
select option in Memory_usage_info Cpu_temperature Active_System_processes Terminate_specific_process Menu
do 
	case $option in
		Memory_usage_info)
			free -h;;
		Cpu_temperature)
			cd ~
			temp=$(cat /sys/class/thermal/thermal_zone9/temp);
			result=$((temp / 1000));
			echo "Temperature    ${result} C"
			if [ $result -gt 70 ]; then
				echo "Warning: the CPU is extremely hot"
			
			fi
			;;
		Active_System_processes)
			ps aux;;
		Terminate_specific_process)
		echo "Enter the PID of the process that you want to terminate"
		read PID
		kill $PID;;
		Menu)
		echo "nothing yet";;
		*)
		echo  "invalid option";;
esac
done
			
	
			

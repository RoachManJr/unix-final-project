
echo "  SYSTEM MANAGEMENT  "
echo "Chose an option from 1 to 3"

while true; 
do 

echo "1) Display a list of currently running services"
echo "2) Start service"
echo "3) Stop service"
echo "4) Main Menu"
read -p "Option : " option
	case $option in 
	 1)
	systemctl list-units --type=service --stat=active | head -n 1
	systemctl list-units --type=service --stat=active | grep running;;
	2)
	read -p "Enter service name : " service
	sudo systemctl start "$service"
	echo "$service started"
	;;
	3)
	check=false
	read -p "Enter service name : " service
	for s in $(systemctl list-units --type=service --stat=running | awk '{print $1}');
 	do
	if [ "$s" = "$service" ]; then
	check=true
	break
	fi
	done
	if [ "$check" = false ]; then
	echo "The service name you entered is not available"
	else
	echo "$service stopped" 
	fi;;
	4)
	break;;
	*)
	echo "invalide option";;
esac
	echo " "
done


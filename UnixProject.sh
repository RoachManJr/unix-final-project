
while true
do
echo -e "\e[1;44;97m             MAIN MENU              \e[0m"
echo -e "\e[97;40m       1) System Status             \e[0m  "
echo -e "\e[97;40m       2) Backup Management         \e[0m "
echo -e "\e[97;40m       3) Network Managment         \e[0m "
echo -e "\e[97;40m       4) Service Management        \e[0m  "
echo -e "\e[97;40m       5) User Management           \e[0m    "
echo -e "\e[97;40m       6) File Management           \e[0m   "
echo -e "\e[91;40m       7) EXIT                      \e[0m   "

read -p " Enter the option   : " option

case $option in
		1)
			while true ; do
			echo -e "\e[1;97;45m        SYSTEM STATUS                                          \e[0m"
			echo -e "\e[97;40mChoose an Option with the number 1 to 5:                       \e[0m "
			echo -e "\e[97;40m1) Display detailed memory usage                               \e[0m "
			echo -e "\e[97;40m2) Check the CPU temperature                                   \e[0m "
			echo -e "\e[97;40m3) List all active system processes (use the key q for exiting)\e[0m "
			echo -e "\e[97;40m4) Terminate an active program with the PID                    \e[0m"
			echo -e "\e[97;40m5) Main Menu                                                   \e[0m "
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
					5)
					break
					;;
					*)
					echo  "invalid option";;
			esac
					echo " "
			done ;;
	2)
				crontab_information(){
		    echo  "======== Schedule Backup ========";
		    echo
		    echo "-------- Minute Frequency -------"
		    # ASK FOR THE MINUTES
		    PS3="Please enter your choice "
		    select min in "* (every minute)" "custom" "Exit"
		    do
		        case $min in
		        "* (every minute)")
		            minOfDay="*"
		            echo "you have chosen every min option"
		            break
		            ;;
		        "custom")
		            while true;
		            do
		                read -p "Please enter minute (0-59) " customMin
		                # check if not matches the specified regular expression
		                if ! [[ "$customMin" =~ ^[0-9]+$ ]];
		                then
		                    echo "Invalid input. Please enter a number "
		                    continue
		                fi

		                if [ "$customMin" -ge 0 ] && [ "$customMin" -le 59 ];
		                then
		                    minOfDay="$customMin"
		                    echo "you have selected $customMin"
		                    break
		                else
		                    echo "Invalid minute. Please enter a number between 0-59"
		                fi
		            done
		            break
		            ;;
		        "Exit")
		            echo "Exiting..."
		            return 1
		            ;;
		        *)
		            echo "Please choose between 1, 2, or 3"
		            ;;
		        esac
		    done

		    echo
		    # ASK FOR THE HOURS
		    echo "--------- Hour Frequency --------"
		    PS3="Please enter your choice "
		    select hour in "* (every hour)" "custom" "Exit"
		    do
		        case $hour in 
		        "* (every hour)")
		            hourOfDay="*"
		            echo "you have chosen every hour option"
		            break
		            ;;
		        "custom")
		            while true;
		            do
		                read -p "Please enter hour (0-23) " customHour
		                if ! [[ "$customHour" =~ ^[0-9]+$ ]];
		                then
		                    echo "Invalid input. Please enter a number. "
		                    continue
		                fi

		                if [ "$customHour" -ge 0 ] && [ "$customHour" -le 23 ];
		                then
		                    hourOfDay="$customHour"
		                    echo "you have entered hour $customHour"
		                    break
		                else
		                    echo "Invalid minute. Please enter a number between 0-59"
		                fi
		            done
		            break
		            ;;
		        "Exit")
		             echo "Exiting..."
		            return 1
		            ;;
		        *)
		            echo "Please choose between 1, 2, or 3"
		            ;;
		        esac
		    done

		    echo
		    # ASK FOR THE DAY OF THE MONTH
		    echo "--- Day of the Month Frequency --"
		    PS3="Please enter your choice "
		    select dayMonthChoice in "* (every day of the month)" "custom" "Exit"
		    do
		        case $dayMonthChoice in
		        "* (every day of the month)")
		            dayOfMonth="*"
		            echo "you have selected every day"
		            break
		            ;;
		        "custom")
		            while true;
		            do
		                read -p "Please enter a day of the month (1-31) " customDayMonth
		                if ! [[ "$customDayMonth" =~ ^[0-9]+$ ]];
		                then
		                    echo "Invalid input. Please enter a number. "
		                    continue
		                fi

		                if [ "$customDayMonth" -ge 1 ] && [ "$customDayMonth" -le 31 ];
		                then
		                    dayOfMonth="$customDayMonth"
		                    echo "You have selected day $customDayMonth"
		                    break
		                else
		                    echo "Invalid day of the month. Please enter a number between 1-31. "
		                fi
		            done
		            break
		            ;;
		        "Exit")
		            echo "Exiting..."
		            return 1
		            ;;
		        *)
		            echo "Invalid choice. Please choose between 1, 2, or 3 "
		            ;;
		        esac
		    done

		    echo
		    # ASK FOR THE MONTH
		    echo "-------- Month Frequency --------"
		    PS3="Please enter your choice "
		    select monthChoice in "* (every month)" "custom" "Exit"
		    do
		        case $monthChoice in
		        "* (every month)")
		            month="*"
		            echo "you have selected every month"
		            break
		            ;;
		        "custom")
		            PS3="Please select a month "
		            select customMonth in January February March April May June July August September October November December
		            do
		                case $customMonth in
		                    January) month=1 ;;
		                    February) month=2 ;;
		                    March) month=3 ;;
		                    April) month=4 ;;
		                    May) month=5 ;;
		                    June) month=6 ;;
		                    July) month=7 ;;
		                    August) month=8 ;;
		                    September) month=9 ;;
		                    October) month=10 ;;
		                    November) month=11 ;;
		                    December) month=12 ;;
		                    *) echo "Invalid input. Please select a number between 1-12 "
		                        continue
		                        ;;
		                esac
		                echo "you have selected $customMonth";
		                break
		            done
		            break
		            ;;
		        "Exit")
		            echo "Exiting..."
		            return 1
		            ;;
		        *)
		            echo "Invalid choice. Please choose between 1, 2, or 3 "
		            ;;
		        esac
		    done

		    echo
		    # ASK FOR THE DAY OF THE WEEK
		    echo "--- Day of the Week Frequency ---"
		    PS3="Please enter your choice: "
		    select dayChoice in "* (every day)" "custom" "Exit"
		    do
		        case $dayChoice in
		        "* (every day)")
		            dayOfWeek="*"
		            echo "you have selected every day"
		            break
		            ;;
		        "custom")
		            PS3="Please select a day of the week: "
		            select day in Monday Tuesday Wednesday Thursday Friday Saturday Sunday
		            do
		                case $day in
		                    Monday) dayOfWeek=1 ;;
		                    Tuesday) dayOfWeek=2 ;;
		                    Wednesday) dayOfWeek=3 ;;
		                    Thursday) dayOfWeek=4 ;;
		                    Friday) dayOfWeek=5 ;;
		                    Saturday) dayOfWeek=6 ;;
		                    Sunday) dayOfWeek=0 ;;
		                    *)echo "Invalid input. Please select a number between 1-7: "
		                        continue
		                        ;;
		                esac
		                echo "you have selected $day";
		                break
		            done
		            break
		            ;;
		        "Exit")
		            echo "Exiting..."
		            return 1
		            ;;
		        *)
		            echo "Invalid choice. Please choose between 1, 2, or 3: "
		            ;;
		        esac
		    done
		    echo
		}

		asking_forDestination(){
		    # ASK FOR FULL PATH OF THE FILE OR FOLDER THE USER WANT TO BACKUP
		    while true;
		    do
		        read -p "Please enter the full path directory of the file/folder you wish to backup: " fileToBackup

		        # Validate if the file/folder exists
		        if [ -e "$fileToBackup" ];
		        then
		            echo "file path: $fileToBackup"
		            break
		        else
		            echo "Error: File/folder not found!"
		            return 1
		        fi
		    done

		    echo
		    # ASK FOR FULL PATH OF WHERE THE USER WANTS THEIR FILE OR FOLDER TO BACKUP
		    while true;
		    do
		        read -p "Please enter the full path of the destination directory: " backupDirectory

		        # Validate the directory exists
		        if [ -d "$backupDirectory" ];
		        then
		            echo "Destination path: $backupDirectory"
		            break
		        else
		            echo "Error: Directory path not found!"
		            return 1
		        fi
		    done
		    echo
		}


		create_backup(){
		    echo "======== Creating Backup Job ========"
		    echo " Backup Frequency Summary"
		    echo " Minute: $minOfDay"
		    echo " Hour: $hourOfDay"
		    echo " Day of Month: $dayOfMonth"
		    echo " Month: $month"
		    echo " Day of Week: $dayOfWeek"
		    echo " Source: $fileToBackup"
		    echo " Destination: $backupDirectory"
		    echo

		    while true;
		    do
		        read -p "Do you wish to backup your file at the specified frequency? Y/N: " answer

		        if [ "$answer" == "Y" ] || [ "$answer" == "y" ];
		        then
		            # location of the logging file
		            logfile="${backupDirectory}/backup.log"

		            # backup command line and assign the date and time into the logging file
		            backup_cmd="tar -czf ${backupDirectory}/backup_\$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz ${fileToBackup} && echo \"backup file: \$(date)\" >> ${logfile}"

		            # crontab frequency
		            cron_entry="$minOfDay $hourOfDay $dayOfMonth $month $dayOfWeek $backup_cmd"

		            # Read existing crontab, append new entry, then replace entire crontab
		            (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -

		            # confirming if the previous command was successful
		            if [ $? -eq 0 ];
		            then
		                echo "Crontab created successfully!"
		            else
		                echo "Crontab failed"
		            fi
		            break

		        elif [ "$answer" == "N" ] || [ "$answer" == "n" ];
		        then
		            echo "Backup cancelled."
		            return
		        else
		            echo "Invalid input. Please enter Y/y or N/n: "
		        fi
		    done
		    echo
		}


		show_lastBackup(){

		    echo "======== Last Backup ========"
		    read -p "Please enter the full path of the backup directory: " backupDir
		    logfile="${backupDir}/backup.log"

		    # check if a regular file exists
		    if [ -f "$logfile" ];
		    then
		        # Read the last line of the log file
		        last_backup=$(tail -n 1 "$logfile")
		        echo "Last Backup: $last_backup"
		    else
		        echo "no file backup yet"
		    fi
		    echo
		}


		while true; 
		do
		    echo -e "\e[1;97;45m     Backup Management Menu    \e[0m"
		    echo -e "\e[97;40m 1. Create a schedule backup   \e[0m   "
		    echo -e "\e[97;40m 2. Check last backup          \e[0m   "
		    echo -e "\e[97;40m 3. Exit                       \e[0m  "

		    read -p "Please choose an option: " choice
		    case $choice in
		        1) 
		            echo
		            crontab_information
		            if [ $? -eq 0 ];
		            then
		                asking_forDestination
		                if [ $? -eq 0 ];
		                then
		                    create_backup
		                fi
		            fi
		            ;;
		        2)
		            show_lastBackup
		            ;;
		        3)
		            echo "Exiting..."
		            break
		            ;;
		        *) 
		            echo "Invalid input. Please try again."
		            ;;
		    esac
		    echo
		done

 
	
		;;
	3) 

		echo "this is the networl management";;
	4)
		    echo -e "\e[1;97;45m     SERVICE MANAGEMENT                          \e[0m"
		    echo -e "\e[97;40m Chose an option from 1 to 4                     \e[0m  "

		while true
		do
		    echo -e "\e[97;40m 1) Display a list of currently running services \e[0m "
		    echo -e "\e[97;40m 2) Start service                                \e[0m  "
		    echo -e "\e[97;40m 3) Stop service                                 \e[0m "
		    echo -e "\e[97;40m 4) Main Menu                                    \e[0m  "

		    read -p "Option : " option

		    case $option in
		        1)
		            echo "Running services:"
		            systemctl list-units --type=service --state=running
		            ;;
		        2)
		            read -p "Enter service name : " service
		            sudo systemctl start "$service"
		            echo "$service started"
		            ;;
		        3)
		            read -p "Enter service name : " service
		         
		                sudo systemctl stop "$service"
		                echo "$service stopped"
		            
		            ;;
		        4)
		            break
		            ;;
		        *)
		            echo "Invalid option"
		            ;;
		    esac

		    echo ""
		done


		;;
	5)
				#  Create a new user based on input username and password.
		#  Grant root privileges to a specified user.
		#  Delete a user account.
		#  Display a list of currently connected users.
		#  Disconnect a specific remote user.
		#  Show all groups a user belongs to.
		#  Change a user’s group membership.

		#!/bin/bash
		# Function to create a new user
		create_user() {
		    read -p "Enter username: " username
		    read -s -p "Enter password: " password #-s hide input
		    echo
		    read -p "Are you sure you want to create user $username? (Y/N)" confirmation
		    if [[ $confirmation == "n" ]] || [[ $confirmation == "N" ]]; then
		        echo "User creation cancelled."
		        return
		    fi

		    # check if the user has created successfully and create a home directory (-m)
		    if sudo useradd -m "$username"; then
		        echo "$username:$password" | sudo chpasswd
		        echo "User $username created successfully."
		    else
		        echo "Failed to create user $username."
		        return
		    fi
		}

		# Function to grant root privileges to a user
		grant_root_privileges() {
		    read -p "Enter username to grant root privileges: " username

		    #check if username exist
		    if ! id $username &>/dev/null;
		    then
		        echo "User ($username) does not exist"
		        return
		    fi

		    read -p "Are you sure you want to grant root privileges to $username? (Y/N)" confirmation
		    if [[ $confirmation == "n" ]] || [[ $confirmation == "N" ]]; then
		        echo "Operation cancelled."
		        return
		    fi
	
		    sudo usermod -aG sudo "$username" #append group sudo (root privilage)
		    echo "User $username granted root privileges."
		}

		# Function to delete a user account
		delete_user() {
		    read -p "Enter username to delete: " username

		    if ! id $username &>/dev/null;
		    then
		        echo "user ($username) does not exist"
		        return
		    fi

		    #search and check if user is currently connected 
		    if w | grep ^$username;
		    then
		        echo "user: $username is still connected. Please disconnect before deleting."
		        return;
		    fi

		    read -p "Are you sure you want to delete user $username? (Y/N)" confirmation
		    if [[ $confirmation == "n" ]] || [[ $confirmation == "N" ]]; 
		    then
		        echo "User deletion cancelled."
		        return
		    fi

		    if sudo userdel -r "$username"; #remove the home directory (-r)
		    then
		        #delete user group if still exist
		        if getent group $username &>/dev/null;
		        then
		            sudo groupdel $username
		        fi
		        echo "User $username deleted successfully."
		    else
		        echo "Failed to delete user: $username"
		        return
		    fi
		}   

		# Function to display currently connected users
		display_connected_users() {
		    echo "Currently connected users:"
		    # who
		    w
		}   

		# Function to disconnect a specific remote user
		disconnect_user() {
		    read -p "Enter username to disconnect: " username

		    #check if the user exist
		    if ! id $username &>/dev/null;
		    then
		        echo "User ($username) does not exist"
		        return
		    fi

		    read -p "Are you sure you want to disconnect user $username? (Y/N)" confirmation
		    if [[ $confirmation == "y" ]] || [[ $confirmation == "Y" ]]; 
		    then
		        #Kill every process by the username (-u)
		        if sudo pkill -KILL -u "$username";
		        then
		            echo "User $username has been disconnected."
		        fi
		    else
		        echo "Operation cancelled."
		        return
		    fi
		}

		# Function to show all groups a user belongs to
		show_user_groups() {
		    read -p "Enter username to show groups: " username
		    groups "$username"
		}

		# Function to change a user's group membership
		change_user_group() {
		    read -p "Enter username to change group: " username

		    if ! id $username &>/dev/null;
		    then
		        echo "username ($username) does not exist"
		        return
		    fi

		    read -p "Enter new group: " group
		    sudo usermod -g "$group" "$username" #primary group (-g)
		    echo "User $username's group changed to $group."
		}

		# Main menu
		while true; do
		    echo -e "\e[1;97;45m     User Management Menu                  \e[0m     "
		    echo -e "\e[97;40m 1. Create a new user                      \e[0m  "
		    echo -e "\e[97;40m 2. Grant root privileges to a user        \e[0m  "
		    echo -e "\e[97;40m 3. Delete a user account                  \e[0m  "
		    echo -e "\e[97;40m 4. Display currently connected users      \e[0m  "
		    echo -e "\e[97;40m 5. Disconnect a specific remote user      \e[0m  "
		    echo -e "\e[97;40m 6. Show all groups a user belongs to      \e[0m  "
		    echo -e "\e[97;40m 7. Change a user's group membership       \e[0m  "
		    echo -e "\e[97;40m 8. Exit                                   \e[0m  "
		    read -p "Choose an option : " choice
		    case $choice in
		        1) create_user ;;
		        2) grant_root_privileges ;;
		        3) delete_user ;;
		        4) display_connected_users ;;
		        5) disconnect_user ;;
		        6) show_user_groups ;;
		        7) change_user_group ;;
		        8) echo "Exiting..."; break ;;
		        *) echo "Invalid option. Please try again." ;;
		    esac
		    echo
		done


		echo "this is the user management";;
	6)
		echo -e "\e[1;97;45m     File Management     \e[0m"
		PS3=" Please select an operation: "
		select cnt in FindFile LargestTen OldestTen Exit
		do
		case $cnt in
		FindFile)
		read -p "Enter username: " userName
		read -p "Enter file name: " fileName

		if getent passwd "$userName" >/dev/null 2>&1; then
			filePath="/home/$userName/$fileName"
			if [ -f "$filePath" ]; then
				full=$(realpath "$filePath")
				echo "Full path is: $full"
			else
				echo "File does not exist"
			fi
		else
			echo "User does not exist"
		fi
		;;
		LargestTen)
		echo "Here are the ten largest files in your home directory"

		du -a -h "$HOME" | sort -rh | head -n 10
		;;
		OldestTen)
		echo "Here are the ten oldest files in your home directory"

		find "$HOME" -type f -printf "%T@ %TY-%Tm-%Td %TH:%TM %p\n" | sort -n | head -n 10 | awk '{timestamp=$2" "$3; $1=""; $2=""; $3=""; print timestamp, $0}'
		;;
		Exit)
		echo "Goodbye"
		break
		;;
		*)
		echo "Invalid Option"
		esac
		done

		;;
	7)
	break
	;;
	*)
		echo "invalid option";;
esac
done

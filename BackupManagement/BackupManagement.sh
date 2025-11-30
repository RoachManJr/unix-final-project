crontab_information(){
    echo "======== Schedule Backup ========";
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
    echo "==== Backup Management Menu ===="
    echo "1. Create a schedule backup"
    echo "2. Check last backup"
    echo "3. Exit"

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

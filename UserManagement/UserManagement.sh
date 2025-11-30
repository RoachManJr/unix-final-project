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
    echo "====== User Management Menu: ======"
    echo "1. Create a new user"
    echo "2. Grant root privileges to a user"
    echo "3. Delete a user account"
    echo "4. Display currently connected users"
    echo "5. Disconnect a specific remote user"
    echo "6. Show all groups a user belongs to"
    echo "7. Change a user's group membership"
    echo "8. Exit"
    read -p "Choose an option (1-8): " choice
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


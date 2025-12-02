PS3="Please select an operation: "

while true; do
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
		echo ""
	else
		echo "File does not exist"
		echo ""
	fi
else
	echo "User does not exist"
	echo ""
fi
break
;;
LargestTen)
echo "Here are the ten largest files in your home directory"

du -a -h "$HOME" | sort -rh | head -n 10
echo ""
break
;;
OldestTen)
echo "Here are the ten oldest files in your home directory"

find "$HOME" -type f -printf "%T@ %TY-%Tm-%Td %TH:%TM %p\n" | sort -n | head -n 10 | awk '{timestamp=$2" "$3; $1=""; $2=""; $3=""; print timestamp, $0}'
echo ""
break
;;
Exit)
echo "Goodbye"
break 2
;;
*)
echo "Invalid Option"
esac
done
done

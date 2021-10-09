#!/bin/bash
clear
echo "Modified and Created by Diego Cruz John H Francis Polytechnigh High, CA, USA."
#echo "Last Modified on Wednesday, Janurary 8th, 2021"
echo "This is the Linux/Ubuntu Cyberpatriot User Account Configurations Script."
echo "It Will Help Do The Following:"
echo "Allow Authorized Admins to Administrator groups. "
echo "Set/Change Chosen Users's Passwords To a Strong Password."
echo "Lock/Secure root."
echo "Set Basic Password Policies (login.defs)."
echo "Set Advanced Password Policies (Pam.d)."
echo "Configure lightdm"
echo -e "Enter Any Key To Continue."
read warning1
clear
echo "WARNING: Make sure you have solved your forensic questions!! As Script Modification May Ruin Forensic Question Answers."
echo -n Are you ready??
echo "Enter Anything"
read warning2
startTime=$(date +"%s")
printTime()
{
	endTime=$(date +"%s")
	diffTime=$(($endTime-$startTime))
	if [ $(($diffTime / 60)) -lt 10 ]
	then
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "0$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/User_Account_Conf.log
		else
			echo -e "0$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/User_Account_Conf.log
		fi
	else
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/User_Account_Conf.log
		else
			echo -e "$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/User_Account_Conf.log
		fi
	fi
}

mkdir ~/Desktop/Logs/
touch ~/Desktop/Logs/User_Account_Conf.log
#echo > ~/Desktop/Script.log
chmod 777 ~/Desktop/Logs/User_Account_Conf.log

if [[ $EUID -ne 0 ]]
then
  echo This script must be run as root
  exit
fi
printTime "Script is being run as root."

printTime "The current OS is Linux Ubuntu."

mkdir -p ~/Desktop/backups/
chmod 777 ~/Desktop/backups/
printTime "Backups folder created on the Desktop."
echo -e "Backups folder created on the Desktop.\n"
sleep 1s

cp /etc/group ~/Desktop/backups/
cp /etc/passwd ~/Desktop/backups/

printTime "/etc/group and /etc/passwd files backed up."
echo -e "/etc/group and /etc/passwd files backed up.\n"
sleep 2s

echo Type all user account names, with a space in between
read -a users

usersLength=${#users[@]}	

for (( i=0;i<$usersLength;i++))
do
	clear
	echo ${users[${i}]}
	echo Delete ${users[${i}]}? yes or no
	read yn1
	if [ $yn1 == yes ]
	then
		userdel -r ${users[${i}]}
		printTime "${users[${i}]} has been deleted."
	else	
		echo Make ${users[${i}]} administrator? yes or no
		read yn2								
		if [ $yn2 == yes ]
		then
			gpasswd -a ${users[${i}]} sudo
			gpasswd -a ${users[${i}]} adm
			gpasswd -a ${users[${i}]} lpadmin
			gpasswd -a ${users[${i}]} sambashare
			printTime "${users[${i}]} has been made an administrator."
		else
			gpasswd -d ${users[${i}]} sudo
			gpasswd -d ${users[${i}]} adm
			gpasswd -d ${users[${i}]} lpadmin
			gpasswd -d ${users[${i}]} sambashare
			gpasswd -d ${users[${i}]} root
			printTime "${users[${i}]} has been made a standard user."
		fi
		
		echo Make custom password for ${users[${i}]}? yes or no
		read yn3								
		if [ $yn3 == yes ]
		then
			echo Please Type in a Password:
			read pw
			echo -e "$pw\n$pw" | passwd ${users[${i}]}
			printTime "${users[${i}]} has been given the password '$pw'."
		else
			echo -e "Cyberpatriot!11\nCyberpatriot!11" | passwd ${users[${i}]}
			printTime "${users[${i}]} has been given the password 'Cyberpatriot!11'."
		fi
		#passwd -x90 -n30 -w7 ${users[${i}]}
		#usermod -L ${users[${i}]}
		printTime "${users[${i}]}'s password has been given a maximum age of 30 days, minimum of 3 days, and warning of 7 days. ${users[${i}]}'s account has been locked."
	fi
done
clear

echo "Type user account names of users you want to add, with a space in between"
echo "If you have no one new to add just press enter."
read -a usersNew

usersNewLength=${#usersNew[@]}	

for (( i=0;i<$usersNewLength;i++))
do
	clear
	echo ${usersNew[${i}]}
	adduser ${usersNew[${i}]}
	printTime "A user account for ${usersNew[${i}]} has been created."
	clear
	echo Make ${usersNew[${i}]} administrator? yes or no
	read ynNew								
	if [ $ynNew == yes ]
	then
		gpasswd -a ${usersNew[${i}]} sudo
		gpasswd -a ${usersNew[${i}]} adm
		gpasswd -a ${usersNew[${i}]} lpadmin
		gpasswd -a ${usersNew[${i}]} sambashare
		printTime "${usersNew[${i}]} has been made an administrator."
	else
		printTime "${usersNew[${i}]} has been made a standard user."
	fi
	
	echo "Configuring login.defs..."
	echo "Is it recommended to put the following for password policies in login.defs:"
	echo "PASSMAX   90"
	echo "PASSMIN   10"
	echo "PASSWARN  14"
	echo "are you ready to configure login.defs?"
	read wait
	sudo nano /etc/login.defs

	passwd -x90 -n10 -w14 ${usersNew[${i}]}
	#usermod -L ${usersNew[${i}]}
	printTime "${usersNew[${i}]}'s password has been given a maximum age of 30 days, minimum of 7 days, and warning of 14 days. ${users[${i}]}'s account has been locked."
	echo -e "${usersNew[${i}]}'s password has been given a maximum age of 30 days, minimum of 7 days, and warning of 14 days. ${users[${i}]}'s account has been locked."
done

	echo "Configuring lightdm.conf..."
	echo "Is it recommended to put the following for password policies in login.defs:"
	echo "allow-guest=false"
	echo "greeter-hide-users=true"
	echo "greeter-show-manual-login=true"
	echo "are you ready to configure lightdm.conf?"
	read wait1
	sudo nano /etc/lightdm/lightdm.conf
	printTime "Lightdm has been configured and guest has bene disabled."
	echo -e "Lightdm has been configured and guest has bene disabled."
#lightdm

sudo apt install members -y


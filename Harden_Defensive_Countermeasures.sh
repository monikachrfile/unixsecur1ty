#!/bin/bash
clear
echo "Modified and Created by Diego Cruz John H Francis Polytechnigh High, CA, USA."
#echo "Last Modified on Wednesday, Janurary 8th, 2021"
echo "This is the Linux/Ubuntu Cyberpatriot Hardening Defensive Countermeasures Script."
echo "This Script will Manage Services on Local Machine By: ."
echo -e "Enter Any Key To Continue"
read warning1
clear
echo "WARNING: Make sure you have solved your forensic questions!! As Script Modification May Ruin Forensic Question Answers."
echo -n Are you ready??
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
			echo -e "0$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Harden_Defense.log
		else
			echo -e "0$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Harden_Defense.log
		fi
	else
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Harden_Defense.log
		else
			echo -e "$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Harden_Defense.log
		fi
	fi
}

touch ~/Desktop/Logs/
echo > ~/Desktop/Logs/Unneeded_Services_Script.log
chmod 777 ~/Desktop/Logs/Unneeded_Services_Script.log

if [[ $EUID -ne 0 ]]
then
  echo "This script must be run as root"
  echo "You can use the command: 'sudo -s' or 'sudo -i'"
  exit
fi
printTime "Script is being run as root."

printTime "The current OS is Linux Ubuntu."

#sudo apt-get install chkrootkit clamav rkhunter apparmor apparmor-profiles lynis nmap git fail2ban -y

loop=1
first_menu()
{
        clear
        echo -e "[1] Security Hardening Tools Analyze Menu"
        echo -e "[2] Firewall Configurations"
        echo -e "[3] Exit"
        read input1
        clear
}
nmap_menu()
{
        while [ $loop == 1 ]; do

                clear
                echo -e "NMAP is a Network Security Scanner, Port Scanner, & Network Exploration Tool."
                echo -e "However For This Instance, it will be used as a Port Scanner & "
                echo ""
                echo ""
                echo -e "[1] Normal Open-Port/Services Scanner"
                echo -e "[2] Intensive Vulnerability Scanner"
		echo -e "[3] Go Back to Previous Menu"
                read nmap_input
                if [ $nmap_input == 1 ]
                then
                        clear
                        nmap -sV 127.0.0.1
			echo -e "Press Enter to contine."
			read wait
                elif [ $nmap_input == 2 ]
                then
                        clear
                        nmap --script nmap-vulners -sV 127.0.0.1
			echo -e "Press Enter to Continue."
			read wait
		elif [ $nmap_input == 3]
		then
			break
                else 
                        echo You Chose the Wrong Option.
                        sleep 1s
                fi
        done
}
debsecan()
{
        while [ $loop == 1 ];do
                clear
                echo -e "Debsecan Configuration Menu"
                echo "[1] Debsecan Activated in cron."
                echo "[2] Debsecan CVE Scan."
                echo "[3] Go back to Previous Menu."
                echo ""
                echo "Choose Your Option."
                read debsecan_input

                if [ $debsecan_input == 1 ]
                then
                        debsecan --cron
                        sudo debsecan-create-cron
                elif [ $debsecan_input == 2 ]
                then
                        debsecan
			echo -e "Press Enter to contine."
			read wait
                elif [ $debsecan_input == 3 ]
                then
                        break
                else
                        echo "You have picked the wrong option."
                fi
        done
}
sec_tool()
{
        clear
        echo "Installing The Following Tools (NEEDED)..."
        sleep 0.5s
        sudo apt-get install chkrootkit clamav rkhunter apparmor apparmor-profiles apparmor-profiles-extra apparmor-notify lynis nmap git fail2ban modsecurity-crs fakeroot fakeroot-ng debsecan unattended-upgrades aide arpwatch logwatch clamav-freshclam -y -qq
        git clone https://github.com/vulnersCom/nmap-vulners.git
        clear
        while [ $loop == 1 ]; do
                clear
                echo "[1] Lynis System Vulnerability Scanner (RECOMMENDED)."
                echo "[2] NMAP Network Vulnerability Scanner."
                echo "[3] Rkhunter Anti-RootKit & System Vulnerability Scanner, And Configurations."
                echo "[4] Clamav Anti-Virus Scanner & Configurations."
                echo "[5] Apparmor and security profiles configurations."
                echo "[6] Debsecan Configuration and CVE System Scan"
                echo -e "[7] Go Back to First Menu."
                echo ""
                read tool_input
        
                if [ $tool_input == 1 ]
                then
                        clear
                        echo "This Program will scan the whole Linux Operating System for vulnerabilities."
                        echo "So Please most attention to anything with a 'WARNING' tag on."
			echo "Scan Will Commence in 6 Seconds..."
                        sleep 6s
                        lynis audit system
                        #sudo lynis audit system
                elif [ $tool_input == 2 ]
                then
                        nmap_menu
                elif [ $tool_input == 3 ]
                then
			rkhunter --update
			rkhunter --propupd
			rkhunter --check
			echo ""
			echo -e "Press Enter to go Back to the Menu."
			read wait3
                elif [ $tool_input == 4 ]
                then
                        service ClamAV-freshclam start
			systemctl start clamav-freshclam
			systemctl start ClamAV-freshclam
			freshclam -v
			echo ""
			echo -e "Press Enter to go Back to the Menu."
			read wait3
			
                elif [ $tool_input == 5 ]
                then
                        sudo apparmor_status
                elif [ $tool_input == 6 ]
                then
                        debsecan
                elif [ $tool_input == 7 ]
                then
                        break 
                else
                        echo "Wrong Choice"
                fi
        done
}
firewall_conf()
{
        clear
        apt-get install gufw -y -qq
        clear
        ufw logging on
        ufw logging high
        ufw deny 23
        ufw deny 110
	ufw deny 111
	ufw deny 515
        ufw deny 1234
        ufw deny 1337
	ufw deny 7100
        ufw deny 49152
        echo ""
        echo -e "Do you want to Configure Firewall Through GUFW as well? [yes/no]: "
        read gufwYN

        while [ $loop == 1 ]; do
                if [ $gufwYN == yes ]
                then
                        sudo gufw
                        break
                elif [ $gufwYN == no ]
                then
                        break
                else
                        clear
                        echo "Wrong Choice"
                        sleep 1s
                fi
        done
}
while [ $loop == 1 ];do
        first_menu
        if [ $input1 == 1 ]
        then
                sec_tool
        elif [ $input1 == 2 ]
        then
                firewall_conf
        elif [ $input1 == 3 ]
        then
                break
        else
                echo "Wrong option"
                sleep 1s
        fi
done

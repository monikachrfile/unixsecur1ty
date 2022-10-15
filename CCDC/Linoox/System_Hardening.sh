#!/bin/bash
clear
echo "Modified and Created by Diego, CSUN"
echo "This is the Ubuntu/Debian Hivestorm System Hardening Script."

if [[ $EUID -ne 0 ]]
then
  echo This script must be run as root
  exit
fi

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
                        echo "Do you have specific ports to scan?"
                        echo -e "[y/n]: "
                        read scan_type

                        if [ $scan_type == y]
                        then
                            clear
                            echo -e "Enter Ports:\nExample: 22,11,56373\n\n: "
                            read ports
                            nmap --script vulners.nse -A -sV 127.0.0.1 -p $ports
                        elif [ $scan_type == n ]
                        then
                            clear
                            nmap --script vulners.nse -A -sV 127.0.0.1

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
                        sleep 2s
                        lynis audit system
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
        apt-get install ufw -y -qq
        clear
        ufw logging on
        ufw logging high
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
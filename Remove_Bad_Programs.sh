#!/bin/bash
clear
echo "Modified and Created by Diego Cruz John H Francis Polytechnigh High, CA, USA."
#echo "Last Modified on Wednesday, Janurary 8th, 2021"
echo "This is the Linux/Ubuntu Cyberpatriot Bad Programs Removal Script."
echo -e "It will delete the following from the system: \nHacking Tools, \nGames, \nMedia Programs, \nand Possible Dangerous Programs.\n"
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
			echo -e "0$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Remove_Bad_Programs.log
		else
			echo -e "0$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Remove_Bad_Programs.log
		fi
	else
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Remove_Bad_Programs.log
		else
			echo -e "$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Remove_Bad_Programs.log
		fi
	fi
}

mkdir ~/Desktop/Logs/
#echo -e "This Folder Will Hold Logs/Records of every Script Run\nThis is for the purpose of any find any incidents caused by the script\nthat you want to fix."
touch ~/Desktop/Logs/Remove_Bad_Programs.log
echo > ~/Desktop/Logs/Remove_Bad_Programs.log
chmod 777 ~/Desktop/Logs/Remove_Bad_Programs.log

if [[ $EUID -ne 0 ]]
then
  echo This script must be run as root
  exit
fi
printTime "Script is being run as root."

printTime "The current OS is Linux Ubuntu."

clear
apt-get purge netcat -y -qq
apt-get purge netcat-openbsd -y -qq
apt-get purge netcat-traditional -y -qq
apt-get purge ncat -y -qq
apt-get purge pnetcat -y -qq
apt-get purge socat -y -qq
apt-get purge sock -y -qq
apt-get purge socket -y -qq
apt-get purge sbd -y -qq
rm /usr/bin/nc
printTime "Netcat and all other instances have been removed."
echo -e "Netcat and all other instances have been removed."
sleep 2s

clear
apt-get purge john -y -qq
apt-get purge john-data -y -qq
printTime "John the Ripper has been removed."
echo -e "John the Ripper has been removed."
sleep 2s

clear
apt-get purge hydra -y -qq
apt-get purge hydra-gtk -y -qq
printTime "Hydra has been removed."
echo -e "Hydra has been removed."
sleep 2s

clear
apt-get purge aircrack-ng -y -qq
printTime "Aircrack-NG has been removed."
echo -e "Aircrack-NG has been removed."
sleep 2s

clear
apt-get purge fcrackzip -y -qq
printTime "FCrackZIP has been removed."
echo -e "FCrackZIP has been removed."
sleep 2s

clear
apt-get purge lcrack -y -qq
printTime "LCrack has been removed."
echo -e "LCrack has been removed."
sleep 2s

clear
apt-get purge ophcrack -y -qq
apt-get purge ophcrack-cli -y -qq
printTime "OphCrack has been removed."
echo -e "OphCrack has been removed."
sleep 2s

clear
apt-get purge pdfcrack -y -qq
printTime "PDFCrack has been removed."
echo -e "PDFCrack has been removed."
sleep 2s

clear
apt-get purge pyrit -y -qq
printTime "Pyrit has been removed."
echo -e "Pyrit has been removed."
sleep 2s

clear
apt-get purge rarcrack -y -qq
printTime "RARCrack has been removed."
echo -e "RARCRACK has been removed"
sleep 2s

clear
apt-get purge sipcrack -y -qq
printTime "SipCrack has been removed."
echo -e "SipCrack has been removed."
sleep 2s

clear
apt-get purge crack -y -qq
apt-get purge crack-common -y -qq
printTime "Crack has been Removed."
echo -e "Crack has beem Removed."
sleep 2s

clear
apt-get purge irpas -y -qq
printTime "IRPAS has been removed."
echo -e "IRPAS has been removed."
sleep 2s

clear
printTime 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
dpkg -l | egrep "crack|hack" >> ~/Desktop/possible_hacking_tools.log

clear
apt-get purge logkeys -y -qq
printTime "LogKeys has been removed."
echo -e "LogKeys has been removed."
sleep 2s

clear
apt-get purge etherwake -y -qq
printTime "Etherwake has been Removed."
echo -e "Etherwake has been Removed."
sleep 2s

clear
apt-get purge zeitgeist-core -y -qq
apt-get purge zeitgeist-datahub -y -qq
apt-get purge python-zeitgeist -y -qq
apt-get purge rhythmbox-plugin-zeitgeist -y -qq
apt-get purge zeitgeist -y -qq
printTime "Zeitgeist has been removed."
echo -e "Zeitgeist has been removed."
sleep 2s

clear
apt-get purge nfs-kernel-server -y -qq
apt-get purge nfs-common -y -qq
apt-get purge portmap -y -qq
apt-get purge rpcbind -y -qq
apt-get purge autofs -y -qq
printTime "NFS has been removed."
echo -e "NFS has been removed"
sleep 2s

clear
apt-get purge nmap -y -qq
apt-get purge zenmap -y -qq
printTime "NMAPs' has been removed."
sleep 2s

#Last Try (Use if you have no idea what to do next)
#apt-get purge inetd -y -qq
#apt-get purge openbsd-inetd -y -qq
#apt-get purge xinetd -y -qq
#apt-get purge inetutils-ftp -y -qq
#apt-get purge inetutils-ftpd -y -qq
#apt-get purge inetutils-inetd -y -qq
#apt-get purge inetutils-ping -y -qq
#apt-get purge inetutils-syslogd -y -qq
#apt-get purge inetutils-talk -y -qq
#apt-get purge inetutils-talkd -y -qq
#apt-get purge inetutils-telnet -y -qq
#apt-get purge inetutils-telnetd -y -qq
#apt-get purge inetutils-tools -y -qq
#apt-get purge inetutils-traceroute -y -qq
#printTime "Inetd (super-server) and all inet utilities have been removed."
#echo -e "Inetd (super-server) and all inet utilities have been removed."

clear
apt-get purge vnc4server -y -qq
apt-get purge vncsnapshot -y -qq
apt-get purge vtgrab -y -qq
apt-get purge remmina-plugin-vnc -y -qq
apt-get purge tigervnc -y -qq
apt-get purge tightvncserver -y -qq
apt-get purge x11vnc -y -qq
printTime "VNC has been removed."
echo -e "VNC has been removed."
sleep 2s

clear
apt-get purge wireshark -y -qq
printTime "Wireshark has been removed."
echo -e "Wireshark has been removed."
sleep 2s

clear
apt-get purge snmp -y -qq
printTime "SNMP has been removed."
echo -e "SNMP has been removed."
sleep 2s

clear
apt-get purge nikto -y -qq
printTime "Nikto has been removed."
echo -e "Nikto has been removed."
sleep 1s

clear
apt-get purge medusa -y -qq
apt-get purge hashcat -y -qq
apt-get purge acccheck -y -qq
apt-get purge arp-scan -y -qq
apt-get purge braa -y -qq
apt-get purge dnsrecon -y -qq
apt-get purge dnstracer -y -qq
apt-get purge metasploit-framework -y -qq
apt-get purge cryptocat -y -qq
apt-get purge w3af -y -qq
apt-get purge w3af-console -y -qq
apt-get purge corkscrew -y -qq
apt-get purge netrw -y -qq
apt-get purge dns2tcp -y -qq
apt-get purge httptunnel -y -qq
apt-get purge patator -y -qq
apt-get purge polenum -y -qq
apt-get purge cmospwd -y -qq
printTime "More Hacking Tools Removed."
echo -e "More Hacking Tools Removed."
sleep 1s

clear
apt-get purge nexuiz -y -qq
apt-get purge darkplaces -y -qq
apt-get purge hitori -y -qq
apt-get purge iagno -y -qq
apt-get purge four-in-a-row -y -qq
apt-get purge lightsoff -y -qq
apt-get purge minetest -y -qq
apt-get purge minetest-server -y -qq
apt-get purge swell-foop -y -qq
apt-get purge quadrapassel -y -qq
apt-get purge gnome-chess -y -qq
apt-get purge gnome-mines -y -qq
apt-get purge gnome-mahjongg -y -qq
apt-get purge gnome-robots -y -qq
apt-get purge gnome-nibbles -y -qq
apt-get purge gnome-sudoku -y -qq
apt-get purge gnome-taquin -y -qq
apt-get purge gnome-klotski -y -qq
apt-get purge defendguin -y -qq
apt-get purge crack-attack -y -qq
apt-get purge airstrike -y -qq
apt-get purge airstrike-common -y -qq
apt-get purge doomsday -y -qq
apt-get purge doomsday-common -y -qq
apt-get purge doomsday-server -y -qq
apt-get purge dopewars -y -qq
apt-get purge dopewars-data -y -qq
apt-get purge empire empire-hub -y -qq
apt-get purge wing wing-data -y -qq
apt-get autoremove -y -qq
printTime "Games have been removed."
echo -e "Games have been removed."
sleep 2s

clear
apt-get purge

clear 
apt-get purge monopd -y -qq
printTime "Monopd Game Server has been removed."
echo -e "Monopd Game Server has been removed."
sleep 2s

clear
apt-get purge sqlmap -y -qq
printTime "SQLMAP has been Removed."
echo -e "SQLMAP has been Removed."
sleep 2s

clear
apt-get purge ettercap -y -qq
apt-get purge ettercap-common -y -qq
apt-get purge ettercap-graphical -y -qq
apt-get purge ettercap-dbg -y -qq
apt-get purge ettercap-text-only -y -qq
printTime "Ettercap has been Removed."
echo -e "Ettercap has been Removed."
sleep 2s

clear
apt-get purge rhythmbox -y -qq
apt-get purge rhythmbox-plugins -y -qq
printTime "Rhythmbox has been Removed."
echo -e "Rhythmbox has been Removed."
sleep 2s

clear
apt-get purge vlc -y -qq
apt-get purge vlc-plugin-samba -y -qq
apt-get purge vlc-plugin-notify -y -qq
apt-get purge vlc-nox -y -qq
printTime "VlC has been Removed."
echo -e "VlC has been Removed."
sleep 1s

clear
apt-get purge snarf -y -qq
apt-get purge fido -y -qq
apt-get purge fimap -y -qq
apt-get purge pykek -y -qq
apt-get purge spraywmi -y -qq
apt-get purge trevorc2 -y -qq
apt-get purge fuzzbunch -y -qq
apt-get purge spiderfoot -y -qq
apt-get purge sniper -y -qq
apt-get purge phishery -y -qq
apt-get purge 3proxy -y -qq
apt-get purge metasploit -y -qq
apt-get purge tplmap -y -qq
apt-get purge rats -y -qq
apt-get purge exploit-db -y -qq
apt-get purge findsploit -y -qq
apt-get purge powersploit -y -qq
apt-get purge ettercap -y -qq
apt-get purge buttercap -y -qq
apt-get purge wireshark -y -qq
apt-get purge pluginhook -y -qq
apt-get purge poshc2 -y -qq
apt-get purge rhythmbox-plugins -y -qq
printTime "Other Known Hacking Tools has been Removed."
echo -e "Other Known Hacking Tools has been Removed."
sleep 2s

clear
echo "It's not over just yet..."
echo -e "You have to check the 'Ubuntu Software' Store and review the 'installed' applications." 
read wait

#flawfinder -examines source code and looks for security weakness.
#ike- Shrew soft VPN client
#ike-scan  - Discover and fingerprint IKE hosts (IPsec VPN Servers)
#sipsak - SIP Swiss army knife
#siproxd SIP proxy/redirect/registrar
#sipwitch - secure peer-to-peer VoIP server for the SIP protocol
#xdotool - simulate (generate) X11 keyboard/mouse input events (Remote Keyboard?)
#vinagre - remote desktop client for the GNOME Desktop
#remote-tty = multiuser "tip"/"cu" replacement with logging
#remotetea - Sun ONC/RPC support for Java
#remctl-server = server for Kerberos-authenticated command execution


#unneeded services:
#unicorn - Rack HTTP server for fast clients
#vinagre - remote desktop client for the GNOME Desktop
#remmina - a remote desktop client that supports the Remote Desktop Protocol, VNC, NX, XDMCP, SPICE and SSH protocols
#remote desktop services/programs

#yersenia -network vulnerability check software (might be good)
#	example: sudo yersenia dhcp -attack 1 (DOS attack on Discover packet)
#auditd -might be good
#vsaudit
#nessus -  a Windows- as well as Linux-based automated network vulnerability and audit tool
#tiger - a security tool that can be use both as a security audit and intrusion detection system.
#	example: "be in a root shell and use the command: 'tiger'"


#games:
#nexuiz - fast paced 3D first-person shooter
#darkplaces - Game engine for Quake and similar 3D first person shooter
#four-in-a-row -game for gnome
#hitori - logiz puzzle game similar to sudoku
#iagno - popular Othellow game for gnome
#lightsoff - Light puzzle game
#minetest - minecraft parody game
#quadrapassel - Popular Russian game, similar to Tetris
#swell-foop - Colored ball puzzle game
#gnome-chess
#gnome-games
#gnome-mines
#gnome-mahjongg
#gnome-nibbles
#gnome-robots
#gnome-taquin
#gnome-klotski
#defendguin -penguin game


#fuzz - stress-test programs by giving them random input


#Notes:
#Use Antivirus, antirootkit, vulnerabilties, antimalware scanners while doing Forensic Questions
#^To save time!

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
if [[ $EUID -ne 0 ]]
then
  echo This script must be run as root
  exit
fi
# "Script is being run as root."

# "The current OS is Linux Ubuntu."

#
dnf remove netcat -y -qq
dnf remove netcat-openbsd -y -qq
dnf remove netcat-traditional -y -qq
dnf remove ncat -y -qq
dnf remove pnetcat -y -qq
dnf remove socat -y -qq
dnf remove sock -y -qq
dnf remove socket -y -qq
dnf remove sbd -y -qq
rm /usr/bin/nc
# "Netcat and all other instances have been removed."
echo -e "Netcat and all other instances have been removed."
# 2s

#
dnf remove john -y -qq
dnf remove john-data -y -qq
# "John the Ripper has been removed."
echo -e "John the Ripper has been removed."
# 2s

#
dnf remove hydra -y -qq
dnf remove hydra-gtk -y -qq
# "Hydra has been removed."
echo -e "Hydra has been removed."
# 2s

#
dnf remove aircrack-ng -y -qq
# "Aircrack-NG has been removed."
echo -e "Aircrack-NG has been removed."
# 2s

#
dnf remove fcrackzip -y -qq
# "FCrackZIP has been removed."
echo -e "FCrackZIP has been removed."
# 2s

#
dnf remove lcrack -y -qq
# "LCrack has been removed."
echo -e "LCrack has been removed."
# 2s

#
dnf remove ophcrack -y -qq
dnf remove ophcrack-cli -y -qq
# "OphCrack has been removed."
echo -e "OphCrack has been removed."
# 2s

#
dnf remove pdfcrack -y -qq
# "PDFCrack has been removed."
echo -e "PDFCrack has been removed."
# 2s

#
dnf remove pyrit -y -qq
# "Pyrit has been removed."
echo -e "Pyrit has been removed."
# 2s

#
dnf remove rarcrack -y -qq
# "RARCrack has been removed."
echo -e "RARCRACK has been removed"
# 2s

#
dnf remove sipcrack -y -qq
# "SipCrack has been removed."
echo -e "SipCrack has been removed."
# 2s

#
dnf remove crack -y -qq
dnf remove crack-common -y -qq
# "Crack has been Removed."
echo -e "Crack has beem Removed."
# 2s

#
dnf remove irpas -y -qq
# "IRPAS has been removed."
echo -e "IRPAS has been removed."
# 2s

#
# 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
#dpkg -l | egrep "crack|hack" >> ~/Desktop/possible_hacking_tools.log

#
dnf remove logkeys -y -qq
# "LogKeys has been removed."
echo -e "LogKeys has been removed."
# 2s

#
dnf remove etherwake -y -qq
# "Etherwake has been Removed."
echo -e "Etherwake has been Removed."
# 2s

#
dnf remove zeitgeist-core -y -qq
dnf remove zeitgeist-datahub -y -qq
dnf remove python-zeitgeist -y -qq
dnf remove rhythmbox-plugin-zeitgeist -y -qq
dnf remove zeitgeist -y -qq
# "Zeitgeist has been removed."
echo -e "Zeitgeist has been removed."
# 2s

#
#dnf remove nfs-kernel-server -y -qq
#dnf remove nfs-common -y -qq
dnf remove portmap -y -qq
dnf remove rpcbind -y -qq
dnf remove autofs -y -qq
# "NFS has been removed."
echo -e "NFS has been removed"
# 2s

#
dnf remove nmap -y -qq
dnf remove zenmap -y -qq
# "NMAPs' has been removed."
# 2s

#dnf remove inetd -y -qq
#dnf remove openbsd-inetd -y -qq
#dnf remove xinetd -y -qq
#dnf remove inetutils-ftp -y -qq
#dnf remove inetutils-ftpd -y -qq
#dnf remove inetutils-inetd -y -qq
#dnf remove inetutils-ping -y -qq
#dnf remove inetutils-syslogd -y -qq
#dnf remove inetutils-talk -y -qq
#dnf remove inetutils-talkd -y -qq
#dnf remove inetutils-telnet -y -qq
#dnf remove inetutils-telnetd -y -qq
#dnf remove inetutils-tools -y -qq
#dnf remove inetutils-traceroute -y -qq
## "Inetd (super-server) and all inet utilities have been removed."
#echo -e "Inetd (super-server) and all inet utilities have been removed."

#
dnf remove vnc4server -y -qq
dnf remove vncsnapshot -y -qq
dnf remove vtgrab -y -qq
dnf remove remmina-plugin-vnc -y -qq
dnf remove tigervnc -y -qq
dnf remove tightvncserver -y -qq
dnf remove x11vnc -y -qq
# "VNC has been removed."
echo -e "VNC has been removed."
# 2s

#
dnf remove wireshark -y -qq
# "Wireshark has been removed."
echo -e "Wireshark has been removed."
# 2s

#
dnf remove snmp -y -qq
# "SNMP has been removed."
echo -e "SNMP has been removed."
# 2s

#
dnf remove nikto -y -qq
# "Nikto has been removed."
echo -e "Nikto has been removed."
# 1s

#
dnf remove medusa -y -qq
dnf remove hashcat -y -qq
dnf remove acccheck -y -qq
dnf remove arp-scan -y -qq
dnf remove braa -y -qq
dnf remove dnsrecon -y -qq
dnf remove dnstracer -y -qq
dnf remove metasploit-framework -y -qq
dnf remove cryptocat -y -qq
dnf remove w3af -y -qq
dnf remove w3af-console -y -qq
dnf remove corkscrew -y -qq
dnf remove netrw -y -qq
dnf remove dns2tcp -y -qq
dnf remove httptunnel -y -qq
dnf remove patator -y -qq
dnf remove polenum -y -qq
dnf remove cmospwd -y -qq
# "More Hacking Tools Removed."
echo -e "More Hacking Tools Removed."
# 1s

#
dnf remove nexuiz -y -qq
dnf remove darkplaces -y -qq
dnf remove hitori -y -qq
dnf remove iagno -y -qq
dnf remove four-in-a-row -y -qq
dnf remove lightsoff -y -qq
dnf remove minetest -y -qq
dnf remove minetest-server -y -qq
dnf remove swell-foop -y -qq
dnf remove quadrapassel -y -qq
dnf remove gnome-chess -y -qq
dnf remove gnome-mines -y -qq
dnf remove gnome-mahjongg -y -qq
dnf remove gnome-robots -y -qq
dnf remove gnome-nibbles -y -qq
dnf remove gnome-sudoku -y -qq
dnf remove gnome-taquin -y -qq
dnf remove gnome-klotski -y -qq
dnf remove defendguin -y -qq
dnf remove crack-attack -y -qq
dnf remove airstrike -y -qq
dnf remove airstrike-common -y -qq
dnf remove doomsday -y -qq
dnf remove doomsday-common -y -qq
dnf remove doomsday-server -y -qq
dnf remove dopewars -y -qq
dnf remove dopewars-data -y -qq
dnf remove empire empire-hub -y -qq
dnf remove wing wing-data -y -qq
# "Games have been removed."
echo -e "Games have been removed."
# 2s

# 
dnf remove monopd -y -qq
# "Monopd Game Server has been removed."
echo -e "Monopd Game Server has been removed."
# 2s

#
dnf remove sqlmap -y -qq
# "SQLMAP has been Removed."
echo -e "SQLMAP has been Removed."
# 2s

#
dnf remove ettercap -y -qq
dnf remove ettercap-common -y -qq
dnf remove ettercap-graphical -y -qq
dnf remove ettercap-dbg -y -qq
dnf remove ettercap-text-only -y -qq
# "Ettercap has been Removed."
echo -e "Ettercap has been Removed."
# 2s

#
dnf remove rhythmbox -y -qq
dnf remove rhythmbox-plugins -y -qq
# "Rhythmbox has been Removed."
echo -e "Rhythmbox has been Removed."
# 2s

#
dnf remove vlc -y -qq
dnf remove vlc-plugin-samba -y -qq
dnf remove vlc-plugin-notify -y -qq
dnf remove vlc-nox -y -qq
# "VlC has been Removed."
echo -e "VlC has been Removed."
# 1s

#
dnf remove snarf -y -qq
dnf remove fido -y -qq
dnf remove fimap -y -qq
dnf remove pykek -y -qq
dnf remove spraywmi -y -qq
dnf remove trevorc2 -y -qq
dnf remove fuzzbunch -y -qq
dnf remove spiderfoot -y -qq
dnf remove sniper -y -qq
dnf remove phishery -y -qq
dnf remove 3proxy -y -qq
dnf remove metasploit -y -qq
dnf remove tplmap -y -qq
dnf remove rats -y -qq
dnf remove exploit-db -y -qq
dnf remove findsploit -y -qq
dnf remove powersploit -y -qq
dnf remove ettercap -y -qq
dnf remove buttercap -y -qq
dnf remove wireshark -y -qq
dnf remove pluginhook -y -qq
dnf remove poshc2 -y -qq
dnf remove rhythmbox-plugins -y -qq

#echo -e '# Controls IP packet forwarding\nnet.ipv4.ip_forward = 0\n\n# IP Spoofing protection\nnet.ipv4.conf.all.rp_filter = 1\nnet.ipv4.conf.default.rp_filter = 1\n\n# Ignore ICMP broadcast requests\nnet.ipv4.icmp_echo_ignore_broadcasts = 1\n\n# Disable source packet routing\nnet.ipv4.conf.all.accept_source_route = 0\nnet.ipv6.conf.all.accept_source_route = 0\nnet.ipv4.conf.default.accept_source_route = 0\nnet.ipv6.conf.default.accept_source_route = 0\n\n# Ignore send redirects\nnet.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\n\n# Block SYN attacks\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_max_syn_backlog = 2048\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 5\n\n# Log Martians\nnet.ipv4.conf.all.log_martians = 1\nnet.ipv4.icmp_ignore_bogus_error_responses = 1\n\n# Ignore ICMP redirects\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv6.conf.all.accept_redirects = 0\nnet.ipv4.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\n\n# Ignore Directed pings\nnet.ipv4.icmp_echo_ignore_all = 1\n\n# Accept Redirects? No, this is not router\nnet.ipv4.conf.all.secure_redirects = 0\n\n# Log packets with impossible addresses to kernel log? yes\nnet.ipv4.conf.default.secure_redirects = 0\n\n########## IPv6 networking start ##############\n# Number of Router Solicitations to send until assuming no routers are present.\n# This is host and not router\nnet.ipv6.conf.default.router_solicitations = 0\n\n# Accept Router Preference in RA?\nnet.ipv6.conf.default.accept_ra_rtr_pref = 0\n\n# Learn Prefix Information in Router Advertisement\nnet.ipv6.conf.default.accept_ra_pinfo = 0\n\n# Setting controls whether the system will accept Hop Limit settings from a router advertisement\nnet.ipv6.conf.default.accept_ra_defrtr = 0\n\n#router advertisements can cause the system to assign a global unicast address to an interface\nnet.ipv6.conf.default.autoconf = 0\n\n#how many neighbor solicitations to send out per address?\nnet.ipv6.conf.default.dad_transmits = 0\n\n# How many global unicast IPv6 addresses can be assigned to each interface?\nnet.ipv6.conf.default.max_addresses = 1\n\n########## IPv6 networking ends ##############' >> /etc/sysctl.conf
#echo -e '#Kernal Hardening\n#Kernal Logs\nkernel.dmesg_restrict = 1\n#Kernal Pointers\nkernel.kptr_restrict = 1\n#ExecShield Protection\nkernel.exec-shield = 2\n#Memory Protections\nkernel.randomize_va_space=2' >> /etc/sysctl.conf
#sysctl -p
# "Other Known Hacking Tools has been Removed."
echo -e "Other Known Hacking Tools has been Removed."
# 2s
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

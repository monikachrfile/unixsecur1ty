#!/bin/bash
clear
echo "Modified and Created by Diego Cruz John H Francis Polytechnigh High, CA, USA."
#echo "Last Modified on Wednesday, Janurary 8th, 2021"
echo "This is the Linux/Ubuntu Cyberpatriot Service Management Script."
echo -e "This Script will Manage Services on Local Machine By: \nDeleting Unneeded Services, \nEnforcing and Securing Needed Services, \nAnd Blocking Service Ports."
echo -e "Enter Any Key To Continue"
read warning1
clear
echo "WARNING: Make sure you have solved your forensic questions!! As Script Modification May Ruin Forensic Question Answers."
echo -n Are you ready??
read warning2

mkdir backups/services/
touch backup/services/Manage_Services.log
echo > backups/services/Manage_Services.log
chmod 777 backups/services/Manage_Services.log

if [[ $EUID -ne 0 ]]
then
  echo "This script must be run as root"
  echo "You can use the command: 'sudo -s' or 'sudo -i'"
  exit
fi
# "Script is being run as root."

# "The current OS is Linux Ubuntu."

echo Does this machine need Samba? [yes/no]
read fake
echo Are you sure? [yes/no]
read sambaYN
echo Does this machine need FTP? [yes/no]
read fake
echo Are you sure? [yes/no]
read ftpYN
echo Does this machine need SSH? [yes/no]
read fake
echo Are you sure? [yes/no]
read sshYN
echo Does this machine need Telnet? [yes/no]
read fake
echo Are you sure? [yes/no]
read telnetYN
echo Does this machine need Mail? [yes/no]
read fake
echo Are you sure? [yes/no]
read mailYN
echo Does this machine need Printing? [yes/no]
read fake
echo Are you sure? [yes/no]
read printYN
echo Does this machine need MySQL? [yes/no]
read fake
echo Are you sure? [yes/no]
read dbYN
echo Will this machine be a Web Server? [yes/no]
read fake
echo Are you sure? [yes/no]
read httpYN
echo Does this machine need Remote Desktop? [yes/no]
read fake
echo Are you sure? [yes/no]
read RemoteDesktopYN
echo Does this machine need Firefox Browser? [yes no]
read fake
echo Are you sure? [yes/no]
read FirefoxYN
#echo Does this machine need DNS [no/yes]?
#read dnsYN
echo Does this machine allow media files [yes/no]?
read mediaFilesYN


clear 
#sleep 1s
# "Sources.list has been Updated."
dnf install ufw
sleep 1s
clear

clear
if [ $sambaYN == no ]
then
	ufw deny netbios-ns
	ufw deny netbios-dgm
	ufw deny netbios-ssn
	ufw deny microsoft-ds
	dnf remove samba -y  
	dnf remove samba-common -y   
	dnf remove samba-common-bin -y  
	dnf remove samba4 -y  
	clear
	# "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
	echo -e "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
	sleep 3s
elif [ $sambaYN == yes ]
then
	ufw allow netbios-ns
	ufw allow netbios-dgm
	ufw allow netbios-ssn
	ufw allow microsoft-ds
	cp /etc/samba/smb.conf backups/services/
	dnf install samba-common -y  
	dnf install samba -y  
	dnf install system-config-samba -y  
	#if [ "$(grep '####### Authentication #######' /etc/samba/smb.conf)"==0 ]
	#then
	#	sed -i 's/####### Authentication #######/####### Authentication #######\nsecurity = user/g' /etc/samba/smb.conf
	#fi
	#sed -i 's/usershare allow guests = no/usershare allow guests = yes/g' /etc/samba/smb.conf
	
	#echo "Type all user account names allowed to use Samba, with a space in between."
	#echo -e "If not specified, then put all authorized users from machine."
	#read -a usersSMB
	#usersSMBLength=${#usersSMB[@]}	
	#for (( i=0;i<$usersSMBLength;i++))
	#do
	#	echo "ignore this"
		#echo -e 'Cyberpatriot!11\nCyberpatriot!11' | smbpasswd -a ${usersSMB[${i}]}
		## "${usersSMB[${i}]} has been given the password 'Moodle!22' for Samba."
	#done
	# "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been allowed. Samba config file has been configured."
	echo -e "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been allowed. Samba config file has been configured."
	sleep 3s
	clear
else
	echo Response not recognized.
fi
# "Samba is complete."
echo -e "Samba is complete."
sleep 1s

clear
if [ $ftpYN == no ]
then
	ufw deny 20
	ufw deny 21
	ufw deny ftp 
	ufw deny sftp 
	ufw deny saft 
	ufw deny ftps-data 
	ufw deny ftps
	dnf remove ftpd -y  
	dnf remove ftp -y  
	dnf remove pure-ftpd -y  
	dnf remove pure-ftpd-common pure-ftpd-mysql -y  
	dnf remove proftpd-basic -y  
	dnf remove proftpd -y  
	dnf remove vsftpd -y  
	dnf remove pure-ftp -y  
	dnf remove gftp gftp-common -y  

	# "vsFTPd has been removed. ftp, sftp, saft, ftps-data, and ftps ports have been denied on the firewall."
elif [ $ftpYN == yes ]
then
	ufw allow ftp 
	ufw allow sftp 
	ufw allow saft 
	ufw allow ftps-data 
	ufw allow ftps
	dnf install ftp -y  
	dnf install ftpd-ssl -y  
	cp -ar /etc/vsftpd/* backups/services/
	#cp /etc/vsftpd.conf backups/services/
	#gedit /etc/vsftpd/vsftpd.conf & gedit /etc/vsftpd.conf
	#service vsftpd restart
	# "ftp, sftp, saft, ftps-data, and ftps ports have been allowed on the firewall. vsFTPd service has been restarted."
else
	echo Response not recognized.
fi
# "FTP is complete."


clear
if [ $sshYN == no ]
then
	ufw deny ssh
	dnf remove openssh-server -y
	#dnf remove openssh-client -y  
	# "SSH port has been denied on the firewall. Open-SSH has been removed."
elif [ $sshYN == yes ]
then
	dnf install openssh-server -y 
	ufw allow ssh
	cp /etc/ssh/sshd_config backups/services/
	#echo Type all user account names allowed to use SSH, with a space in between
	#read usersSSH
	#echo -e "# Package generated configuration file\n# See the sshd_config(5) manpage for details\n\n# What ports, IPs and protocols we listen for\nPort 2200\n# Use these options to restrict which interfaces/protocols sshd will bind to\n#ListenAddress ::\n#ListenAddress 0.0.0.0\nProtocol 2\n# HostKeys for protocol version \nHostKey /etc/ssh/ssh_host_rsa_key\nHostKey /etc/ssh/ssh_host_dsa_key\nHostKey /etc/ssh/ssh_host_ecdsa_key\nHostKey /etc/ssh/ssh_host_ed25519_key\n#Privilege Separation is turned on for security\nUsePrivilegeSeparation yes\n\n# Lifetime and size of ephemeral version 1 server key\nKeyRegenerationInterval 3600\nServerKeyBits 1024\n\n# Logging\nSyslogFacility AUTH\nLogLevel VERBOSE\n\n# Authentication:\nLoginGraceTime 60\nPermitRootLogin no\nStrictModes yes\n\nRSAAuthentication yes\nPubkeyAuthentication yes\n#AuthorizedKeysFile	%h/.ssh/authorized_keys\n\n# Don't read the user's ~/.rhosts and ~/.shosts files\nIgnoreRhosts yes\n# For this to work you will also need host keys in /etc/ssh_known_hosts\nRhostsRSAAuthentication no\n# similar for protocol version 2\nHostbasedAuthentication no\n# Uncomment if you don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication\n#IgnoreUserKnownHosts yes\n\n# To enable empty passwords, change to yes (NOT RECOMMENDED)\nPermitEmptyPasswords no\n\n# Change to yes to enable challenge-response passwords (beware issues with\n# some PAM modules and threads)\nChallengeResponseAuthentication yes\n\n# Change to no to disable tunnelled clear text passwords\nPasswordAuthentication no\n\n# Kerberos options\n#KerberosAuthentication no\n#KerberosGetAFSToken no\n#KerberosOrLocalPasswd yes\n#KerberosTicketCleanup yes\n\n# GSSAPI options\n#GSSAPIAuthentication no\n#GSSAPICleanupCredentials yes\n\nX11Forwarding no\nX11DisplayOffset 10\nPrintMotd no\nPrintLastLog no\nTCPKeepAlive yes\n#UseLogin no\n\nMaxStartups 2\n#Banner /etc/issue.net\n\n# Allow client to pass locale environment variables\nAcceptEnv LANG LC_*\n\nSubsystem sftp /usr/lib/openssh/sftp-server\n\n# Set this to 'yes' to enable PAM authentication, account processing,\n# and session processing. If this is enabled, PAM authentication will\n# be allowed through the ChallengeResponseAuthentication and\n# PasswordAuthentication.  Depending on your PAM configuration,\n# PAM authentication via ChallengeResponseAuthentication may bypass\n# the setting of \"PermitRootLogin without-password\".\n# If you just want the PAM account and session checks to run without\n# PAM authentication, then enable this but set PasswordAuthentication\n# and ChallengeResponseAuthentication to 'no'.\nUsePAM yes\n\nAllowUsers $usersSSH\nDenyUsers\nRhostsAuthentication no\nClientAliveInterval 300\nClientAliveCountMax 0\nVerifyReverseMapping yes\nAllowTcpForwarding no\nUseDNS no\nPermitUserEnvironment no" > /etc/ssh/sshd_config
	systemctl enable sshd
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	ssh-keygen -t rsa
	# "SSH port has been allowed on the firewall. SSH config file has been configured. SSH RSA 2048 keys have been created."
else
	echo Response not recognized.
fi
# "SSH is complete."

clear
if [ $telnetYN == no ]
then
	ufw deny 23
	ufw deny telnet 
	ufw deny rtelnet 
	ufw deny telnets
	dnf remove telnet -y  
	dnf remove telnetd -y  
	dnf remove inetutils-telnetd -y  
	dnf remove telnetd-ssl -y  
	# "Telnet port has been denied on the firewall and Telnet has been removed."
elif [ $telnetYN == yes ]
then
	ufw allow telnet 
	ufw allow rtelnet 
	ufw allow telnets
	# "Telnet port has been allowed on the firewall."
else
	echo Response not recognized.
fi
# "Telnet is complete."



clear
if [ $mailYN == no ]
then
	dnf remove postfix -y  
	dnf remove sendmail -y  
	dnf remove pop3 -y  
	dnf remove qmail -y  
	ufw deny 25
	ufw deny smtp 
	ufw deny pop2 
	ufw deny pop3
	ufw deny imap2 
	ufw deny imaps 
	ufw deny pop3s
	# "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been denied on the firewall. Postfix, Sendmail, Pop3, Qmail has been Removed."
elif [ $mailYN == yes ]
then
	dnf install pop3 -y  
	dnf install sendmail -y  
	ufw allow smtp 
	ufw allow pop2 
	ufw allow pop3
	ufw allow imap2 
	ufw allow imaps 
	ufw allow pop3s
	# "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been allowed on the firewall. Pop3 and Sendmail have been installed."
else
	echo Response not recognized.
fi
# "Mail is complete."



clear
if [ $printYN == no ]
then
	ufw deny ipp 
	ufw deny printer 
	ufw deny cups
	dnf remove cups dovecot-core dovecot-antispam dovecot-dbg dovecot-dev dovecot-gssapi dovecot-imapd dovecot-ldap dovecot-lmtpd dovecot-lucene dovecot-sqlite dovecot-solr dovecot-managesieved dovecot-mysql dovecot-pgsql dovecot-pop3d dovecot-sieve -y
	systemctl stop cups.service
	systemctl stop cups.socket
	systemctl stop cups-browsed.service
	# "ipp, printer, and cups ports have been denied on the firewall. Cups, Dovecot and plugins have been Removed."
	echo -e "ipp, printer, and cups ports have been denied on the firewall. Cups, Dovecot and plugins have been Removed."
	sleep
elif [ $printYN == yes ]
then

	ufw allow ipp 
	ufw allow printer 
	ufw allow cups
	dnf install cups
	# "ipp, printer, and cups ports have been allowed on the firewall."
else
	echo Response not recognized.
fi
# "Printing is complete."



clear
if [ $dbYN == no ]
then
	ufw deny ms-sql-s 
	ufw deny ms-sql-m 
	ufw deny mysql 
	ufw deny mysql-proxy
	dnf remove postgresql -y  
	dnf remove sqlcipher -y  
	dnf remove mysql mariadb -y 
	dnf remove mysql-client-core-5.5 -y  
	dnf remove mysql-client-core-5.6 -y  
	dnf remove mysql-common-5.5 -y  
	dnf remove mysql-common-5.6 -y  
	dnf remove mysql-server -y  
	dnf remove mysql-server-5.5 -y  
	dnf remove mysql-server-5.6 -y  
	dnf remove mysql-server-5.7 -y  
	dnf remove mysql-client-5.5 -y  
	dnf remove mysql-client-5.6 -y  
	dnf remove mysql-client-5.7 -y  
	dnf remove mysql-server-core-5.6 -y  
	# "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been denied on the firewall. MySQL has been removed."
elif [ $dbYN == yes ]
then
	ufw allow ms-sql-s 
	ufw allow ms-sql-m 
	ufw allow mysql 
	ufw allow mysql-proxy
	dnf install sqlcipher -y  
	dnf install mysql-server-5.7 -y  
	cp /etc/my.cnf backups/services/
	cp -ar /etc/mysql/ backups/services/
	cp /usr/etc/my.cnf backups/services/
	cp ~/.my.cnf backups/services/
	if grep -q "bind-address" "/etc/mysql/my.cnf"
	then
		sed -i "s/bind-address\t\t=.*/bind-address\t\t= 127.0.0.1/g" /etc/mysql/my.cnf
	fi
	#gedit /etc/my.cnf&gedit /etc/mysql/my.cnf&gedit /usr/etc/my.cnf&gedit ~/.my.cnf
	systemctl enable mysql
	echo "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been allowed on the firewall. MySQL has been installed. MySQL config file has been secured. MySQL service has been restarted."
else
	echo Response not recognized.
fi
# "MySQL is complete."



clear
if [ $httpYN == no ]
then
	#ufw deny http
	#ufw deny https
	dnf remove nginx -y  
	dnf remove unicorn -y  
	dnf remove apache -y  
	dnf remove apache2 -y
	mkdir backups/services/http/
	cp -ar /var/www/* backups/services/http/
	cp -ar /srv/* backups/services/http/
	rm -r /var/www/*
	# "http and https ports have been denied on the firewall. Apache & Apache2 has been removed. Web server files have been removed."
elif [ $httpYN == yes ]
then
	dnf install apache2 -y  
	dnf install apache2-utils -y  
	dnf install libapache2-mod-security2 -y  
	dnf install libapache2-mod-evasive
	apt install install mod_security -y
	systemctl enable apache2
	ufw allow http 
	ufw allow https
	mkdir backups/services/http/
	cp -ar /var/www/* backups/services/http/
	cp -ar /srv/ backups/services/http/
	#if [ -e /etc/apache2/apache2.conf ]
	#then
  	#  echo -e '\<Directory \>\n\t AllowOverride None\n\t Order Deny,Allow\n\t Deny from all\n\<Directory \/\>\nUserDir disabled root' >> /etc/apache2/apache2.conf
	#fi
	chown -R root:root /etc/apache2

	# "http and https ports have been allowed on the firewall. Apache2 config file has been configured. Only root can now access the Apache2 folder."
else
	echo Response not recognized.
fi
# "Web Server is complete."

if [ $RemoteDesktopYN == no ]
then
	ufw deny 3389
	dnf remove vinagre -y  
	dnf remove remmina -y  
	dnf remove remmina-plugin-rdp -y  
	dnf remove remmina-plugin-vnc -y  
	dnf remove remmina-plugin-telepathy
	dnf remove remmina-plugin-xdmcp -y  
	dnf remove remmina-plugin-nx -y  
	dnf remove remmina-plugin-gnome -y  
	dnf remove remmina-common -y  
	dnf remove rsync -y   
	dnf remove unity-scope-video-remote -y  
	dnf remove gdbserver -y  
	dnf remove vino -y  
	# "Remote Desktop Ports have been denied. Vinagre, Remmina, rsync, unity-scope-video-remote, and gsbserver Programs have been Removed."
elif [ $RemoteDesktopYN == yes ]
then
	ufw allow 3389
	#dnf install vinagre  
	# "Remote Desktop port was allowed. Vinagre has been Installed."
else
	echo "Response not recognized."
fi
# "Remote Desktop is Complete."


if [ $FirefoxYN == no ]
then
	echo bruh
elif [ $FirefoxYN == yes ]
then
	echo -e "Make Sure Firefox Is Not Running During Update."
	read Firefox_input
	#sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa
	#dnf update -y  
	#
	dnf install firefox -y  
	echo -e "Firefox will open automatically. Make Sure to Set Mozilla Firefox"
	echo -e "Do The Security Browser Settings and Come Back to the Script after you are Done."
	echo -e "Press Enter to Continue."
	read FireFox_Security
	firefox -new-window www.google.com

	# "Firefox has been Updated, and Browser Security Settings has been enabled."
	echo -e "Firefox has been Updated, and Browser Security Settings has been enabled."
else
	echo "Response not Recognized."
fi
# "Firefox is Complete."
echo -e "Firefox is Complete."

clear
cp /etc/default/irqbalance backups/services/
echo -e "Continue? (make sure backups are working)"
read contine
echo > /etc/default/irqbalance
echo -e "#Configuration for the irqbalance daemon\n\n#Should irqbalance be enabled?\nENABLED=\"0\"\n#Balance the IRQs only once?\nONESHOT=\"0\"" >> /etc/default/irqbalance
# "IRQ Balance has been disabled."

clear
#cp /etc/sysctl.conf backups/services/
#echo -e "Continue? (make sure backups are working)"
#read contine
#echo > /etc/sysctl.conf
#echo -e "# Controls IP packet forwarding\nnet.ipv4.ip_forward = 0\n\n# IP Spoofing protection\nnet.ipv4.conf.all.rp_filter = 1\nnet.ipv4.conf.default.rp_filter = 1\n\n# Ignore ICMP broadcast requests\nnet.ipv4.icmp_echo_ignore_broadcasts = 1\n\n# Disable source packet routing\nnet.ipv4.conf.all.accept_source_route = 0\nnet.ipv6.conf.all.accept_source_route = 0\nnet.ipv4.conf.default.accept_source_route = 0\nnet.ipv6.conf.default.accept_source_route = 0\n\n# Ignore send redirects\nnet.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\n\n# Block SYN attacks\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_max_syn_backlog = 2048\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 5\n\n# Log Martians\nnet.ipv4.conf.all.log_martians = 1\nnet.ipv4.icmp_ignore_bogus_error_responses = 1\n\n# Ignore ICMP redirects\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv6.conf.all.accept_redirects = 0\nnet.ipv4.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\n\n# Ignore Directed pings\nnet.ipv4.icmp_echo_ignore_all = 1\n\n# Accept Redirects? No, this is not router\nnet.ipv4.conf.all.secure_redirects = 0\n\n# Log packets with impossible addresses to kernel log? yes\nnet.ipv4.conf.default.secure_redirects = 0\n\n########## IPv6 networking start ##############\n# Number of Router Solicitations to send until assuming no routers are present.\n# This is host and not router\nnet.ipv6.conf.default.router_solicitations = 0\n\n# Accept Router Preference in RA?\nnet.ipv6.conf.default.accept_ra_rtr_pref = 0\n\n# Learn Prefix Information in Router Advertisement\nnet.ipv6.conf.default.accept_ra_pinfo = 0\n\n# Setting controls whether the system will accept Hop Limit settings from a router advertisement\nnet.ipv6.conf.default.accept_ra_defrtr = 0\n\n#router advertisements can cause the system to assign a global unicast address to an interface\nnet.ipv6.conf.default.autoconf = 0\n\n#how many neighbor solicitations to send out per address?\nnet.ipv6.conf.default.dad_transmits = 0\n\n# How many global unicast IPv6 addresses can be assigned to each interface?\nnet.ipv6.conf.default.max_addresses = 1\n\n########## IPv6 networking ends ##############" >> /etc/sysctl.conf
#sysctl -p >> /dev/null
# "Sysctl has been configured."


#echo Disable IPv6?
#read ipv6YN
#if [ $ipv6YN == yes ]
#then
#	echo -e "\n\n# Disable IPv6\nnet.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
#	sysctl -p >> /dev/null
#	# "IPv6 has been disabled."
#fi

#Last Stand
#clear
#if [ $dnsYN == no ]
#then
#	ufw deny domain
#	dnf remove bind9  
#	# "domain port has been denied on the firewall. DNS name binding has been removed."
#elif [ $dnsYN == yes ]
#then
#	ufw allow domain
#	# "domain port has been allowed on the firewall."
#else
#	echo Response not recognized.
#fi
## "DNS is complete."

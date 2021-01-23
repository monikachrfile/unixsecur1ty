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
startTime=$(date +"%s")
printTime()
{
	endTime=$(date +"%s")
	diffTime=$(($endTime-$startTime))
	if [ $(($diffTime / 60)) -lt 10 ]
	then
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "0$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Manage_Services.log
		else
			echo -e "0$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Manage_Services.log
		fi
	else
		if [ $(($diffTime % 60)) -lt 10 ]
		then
			echo -e "$(($diffTime / 60)):0$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Manage_Services.log
		else
			echo -e "$(($diffTime / 60)):$(($diffTime % 60)) -- $1" >> ~/Desktop/Logs/Manage_Services.log
		fi
	fi
}

mkdir ~/Desktop/Logs/
mkdir ~/Desktop/Backups/
touch ~/Desktop/Logs/Manage_Services.log
echo > ~/Desktop/Logs/Manage_Services.log
chmod 777 ~/Desktop/Logs/Manage_Services.log

if [[ $EUID -ne 0 ]]
then
  echo "This script must be run as root"
  echo "You can use the command: 'sudo -s' or 'sudo -i'"
  exit
fi
printTime "Script is being run as root."

printTime "The current OS is Linux Ubuntu."

echo Does this machine need Samba? [yes/no]
read sambaYN
echo Does this machine need FTP? [yes/no]
read ftpYN
echo Does this machine need SSH? [yes/no]
read sshYN
echo Does this machine need Telnet? [yes/no]
read telnetYN
echo Does this machine need Mail? [yes/no]
read mailYN
echo Does this machine need Printing? [yes/no]
read printYN
echo Does this machine need MySQL? [yes/no]
read dbYN
echo Will this machine be a Web Server? [yes/no]
read httpYN
echo Does this machine need Remote Desktop? [yes/no]
read RemoteDesktopYN
echo Does this machine need Firefox Browser? [yes no]
read FirefoxYN
#echo Does this machine need DNS [no/yes]?
#read dnsYN
echo Does this machine allow media files [yes/no]?
read mediaFilesYN

clear
apt-get update -y -qq
sleep 1s
printTime "Sources.list has been Updated."
echo -e "Sources.list has been Updated."
sleep 1s
clear

clear
if [ $sambaYN == no ]
then
	ufw deny netbios-ns
	ufw deny netbios-dgm
	ufw deny netbios-ssn
	ufw deny microsoft-ds
	apt-get purge samba -y -qq
	apt-get purge samba-common -y  -qq
	apt-get purge samba-common-bin -y -qq
	apt-get purge samba4 -y -qq
	clear
	printTime "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
	echo -e "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
	sleep 3s
elif [ $sambaYN == yes ]
then
	ufw allow netbios-ns
	ufw allow netbios-dgm
	ufw allow netbios-ssn
	ufw allow microsoft-ds
	cp /etc/samba/smb.conf ~/Desktop/backups/
	apt-get install samba-common -y -qq
	apt-get install samba -y -qq
	apt-get install system-config-samba -y -qq
	if [ "$(grep '####### Authentication #######' /etc/samba/smb.conf)"==0 ]
	then
		sed -i 's/####### Authentication #######/####### Authentication #######\nsecurity = user/g' /etc/samba/smb.conf
	fi
	sed -i 's/usershare allow guests = no/usershare allow guests = yes/g' /etc/samba/smb.conf
	
	echo "Type all user account names allowed to use Samba, with a space in between."
	echo -e "If not specified, then put all authorized users from machine."
	read -a usersSMB
	usersSMBLength=${#usersSMB[@]}	
	for (( i=0;i<$usersSMBLength;i++))
	do
		echo -e 'Moodle!22\nMoodle!22' | smbpasswd -a ${usersSMB[${i}]}
		printTime "${usersSMB[${i}]} has been given the password 'Moodle!22' for Samba."
	done
	printTime "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been allowed. Samba config file has been configured."
	echo -e "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been allowed. Samba config file has been configured."
	sleep 3s
	clear
else
	echo Response not recognized.
fi
printTime "Samba is complete."
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
	apt-get purge ftpd -y -qq
	apt-get purge ftp -y -qq
	apt-get purge pure-ftpd -y -qq
	apt-get purge pure-ftpd-common pure-ftpd-mysql -y -qq
	apt-get purge proftpd-basic -y -qq
	apt-get purge proftpd -y -qq
	apt-get purge vsftpd -y -qq
	apt-get purge pure-ftp -y -qq
	apt-get purge gftp gftp-common -y -qq

	apt-get autoremove -y
	printTime "vsFTPd has been removed. ftp, sftp, saft, ftps-data, and ftps ports have been denied on the firewall."
elif [ $ftpYN == yes ]
then
	ufw allow ftp 
	ufw allow sftp 
	ufw allow saft 
	ufw allow ftps-data 
	ufw allow ftps
	apt-get install ftp -y -qq
	apt-get install ftpd-ssl -y -qq
	cp /etc/vsftpd/vsftpd.conf ~/Desktop/backups/
	cp /etc/vsftpd.conf ~/Desktop/backups/
	gedit /etc/vsftpd/vsftpd.conf&gedit /etc/vsftpd.conf
	service vsftpd restart
	printTime "ftp, sftp, saft, ftps-data, and ftps ports have been allowed on the firewall. vsFTPd service has been restarted."
else
	echo Response not recognized.
fi
printTime "FTP is complete."


clear
if [ $sshYN == no ]
then
	ufw deny ssh
	apt-get purge openssh-server -y -qq
	apt-get purge openssh-client -y -qq
	printTime "SSH port has been denied on the firewall. Open-SSH has been removed."
elif [ $sshYN == yes ]
then
	apt-get install openssh-server -y -qq
	ufw allow ssh
	cp /etc/ssh/sshd_config ~/Desktop/backups/	
	#echo Type all user account names allowed to use SSH, with a space in between
	#read usersSSH
	#echo -e "# Package generated configuration file\n# See the sshd_config(5) manpage for details\n\n# What ports, IPs and protocols we listen for\nPort 2200\n# Use these options to restrict which interfaces/protocols sshd will bind to\n#ListenAddress ::\n#ListenAddress 0.0.0.0\nProtocol 2\n# HostKeys for protocol version \nHostKey /etc/ssh/ssh_host_rsa_key\nHostKey /etc/ssh/ssh_host_dsa_key\nHostKey /etc/ssh/ssh_host_ecdsa_key\nHostKey /etc/ssh/ssh_host_ed25519_key\n#Privilege Separation is turned on for security\nUsePrivilegeSeparation yes\n\n# Lifetime and size of ephemeral version 1 server key\nKeyRegenerationInterval 3600\nServerKeyBits 1024\n\n# Logging\nSyslogFacility AUTH\nLogLevel VERBOSE\n\n# Authentication:\nLoginGraceTime 60\nPermitRootLogin no\nStrictModes yes\n\nRSAAuthentication yes\nPubkeyAuthentication yes\n#AuthorizedKeysFile	%h/.ssh/authorized_keys\n\n# Don't read the user's ~/.rhosts and ~/.shosts files\nIgnoreRhosts yes\n# For this to work you will also need host keys in /etc/ssh_known_hosts\nRhostsRSAAuthentication no\n# similar for protocol version 2\nHostbasedAuthentication no\n# Uncomment if you don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication\n#IgnoreUserKnownHosts yes\n\n# To enable empty passwords, change to yes (NOT RECOMMENDED)\nPermitEmptyPasswords no\n\n# Change to yes to enable challenge-response passwords (beware issues with\n# some PAM modules and threads)\nChallengeResponseAuthentication yes\n\n# Change to no to disable tunnelled clear text passwords\nPasswordAuthentication no\n\n# Kerberos options\n#KerberosAuthentication no\n#KerberosGetAFSToken no\n#KerberosOrLocalPasswd yes\n#KerberosTicketCleanup yes\n\n# GSSAPI options\n#GSSAPIAuthentication no\n#GSSAPICleanupCredentials yes\n\nX11Forwarding no\nX11DisplayOffset 10\nPrintMotd no\nPrintLastLog no\nTCPKeepAlive yes\n#UseLogin no\n\nMaxStartups 2\n#Banner /etc/issue.net\n\n# Allow client to pass locale environment variables\nAcceptEnv LANG LC_*\n\nSubsystem sftp /usr/lib/openssh/sftp-server\n\n# Set this to 'yes' to enable PAM authentication, account processing,\n# and session processing. If this is enabled, PAM authentication will\n# be allowed through the ChallengeResponseAuthentication and\n# PasswordAuthentication.  Depending on your PAM configuration,\n# PAM authentication via ChallengeResponseAuthentication may bypass\n# the setting of \"PermitRootLogin without-password\".\n# If you just want the PAM account and session checks to run without\n# PAM authentication, then enable this but set PasswordAuthentication\n# and ChallengeResponseAuthentication to 'no'.\nUsePAM yes\n\nAllowUsers $usersSSH\nDenyUsers\nRhostsAuthentication no\nClientAliveInterval 300\nClientAliveCountMax 0\nVerifyReverseMapping yes\nAllowTcpForwarding no\nUseDNS no\nPermitUserEnvironment no" > /etc/ssh/sshd_config
	systemctl enable sshd
	#mkdir ~/.ssh
	#chmod 700 ~/.ssh
	ssh-keygen -t rsa
	printTime "SSH port has been allowed on the firewall. SSH config file has been configured. SSH RSA 2048 keys have been created."
else
	echo Response not recognized.
fi
printTime "SSH is complete."

clear
if [ $telnetYN == no ]
then
	ufw deny 23
	ufw deny telnet 
	ufw deny rtelnet 
	ufw deny telnets
	apt-get purge telnet -y -qq
	apt-get purge telnetd -y -qq
	apt-get purge inetutils-telnetd -y -qq
	apt-get purge telnetd-ssl -y -qq
	printTime "Telnet port has been denied on the firewall and Telnet has been removed."
elif [ $telnetYN == yes ]
then
	ufw allow telnet 
	ufw allow rtelnet 
	ufw allow telnets
	printTime "Telnet port has been allowed on the firewall."
else
	echo Response not recognized.
fi
printTime "Telnet is complete."



clear
if [ $mailYN == no ]
then
	apt-get purge postfix -y -qq
	apt-get purge sendmail -y -qq
	apt-get purge pop3 -y -qq
	apt-get purge qmail -y -qq
	ufw deny 25
	ufw deny smtp 
	ufw deny pop2 
	ufw deny pop3
	ufw deny imap2 
	ufw deny imaps 
	ufw deny pop3s
	printTime "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been denied on the firewall. Postfix, Sendmail, Pop3, Qmail has been Removed."
elif [ $mailYN == yes ]
then
	apt-get install pop3 -y -qq
	apt-get install sendmail -y -qq
	ufw allow smtp 
	ufw allow pop2 
	ufw allow pop3
	ufw allow imap2 
	ufw allow imaps 
	ufw allow pop3s
	printTime "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been allowed on the firewall. Pop3 and Sendmail have been installed."
else
	echo Response not recognized.
fi
printTime "Mail is complete."



clear
if [ $printYN == no ]
then
	ufw deny ipp 
	ufw deny printer 
	ufw deny cups
	apt-get purge cups
	apt-get purge dovecot-core
	apt-get purge dovecot-antispam
	apt-get purge dovecot-dbg
	apt-get purge dovecot-dev
	apt-get purge dovecot-gssapi
	apt-get purge dovecot-imapd
	apt-get purge dovecot-ldap
	apt-get purge dovecot-lmtpd
	apt-get purge dovecot-lucene
	apt-get purge dovecot-sqlite
	apt-get purge dovecot-solr
	apt-get purge dovecot-managesieved
	apt-get purge dovecot-mysql
	apt-get purge dovecot-pgsql
	apt-get purge dovecot-pop3d
	apt-get purge dovecot-sieve
	printTime "ipp, printer, and cups ports have been denied on the firewall. Cups, Dovecot and plugins have been Removed."
	echo -e "ipp, printer, and cups ports have been denied on the firewall. Cups, Dovecot and plugins have been Removed."
	sleep
elif [ $printYN == yes ]
then

	ufw allow ipp 
	ufw allow printer 
	ufw allow cups
	apt-get install cups
	apt-get 
	printTime "ipp, printer, and cups ports have been allowed on the firewall."
else
	echo Response not recognized.
fi
printTime "Printing is complete."



clear
if [ $dbYN == no ]
then
	ufw deny ms-sql-s 
	ufw deny ms-sql-m 
	ufw deny mysql 
	ufw deny mysql-proxy
	apt-get purge postgresql -y -qq
	apt-get purge sqlcipher -y -qq
	apt-get purge mysql -y -qq
	apt-get purge mysql-client-core-5.5 -y -qq
	apt-get purge mysql-client-core-5.6 -y -qq
	apt-get purge mysql-common-5.5 -y -qq
	apt-get purge mysql-common-5.6 -y -qq
	apt-get purge mysql-server -y -qq
	apt-get purge mysql-server-5.5 -y -qq
	apt-get purge mysql-server-5.6 -y -qq
	apt-get purge mysql-server-5.7 -y -qq
	apt-get purge mysql-client-5.5 -y -qq
	apt-get purge mysql-client-5.6 -y -qq
	apt-get purge mysql-client-5.7 -y -qq
	apt-get purge mysql-server-core-5.6 -y -qq
	printTime "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been denied on the firewall. MySQL has been removed."
elif [ $dbYN == yes ]
then
	ufw allow ms-sql-s 
	ufw allow ms-sql-m 
	ufw allow mysql 
	ufw allow mysql-proxy
	apt-get install sqlcipher -y -qq
	apt-get install mysql-server-5.7 -y -qq
	cp /etc/my.cnf ~/Desktop/backups/
	cp /etc/mysql/my.cnf ~/Desktop/backups/
	cp /usr/etc/my.cnf ~/Desktop/backups/
	cp ~/.my.cnf ~/Desktop/backups/
	if grep -q "bind-address" "/etc/mysql/my.cnf"
	then
		sed -i "s/bind-address\t\t=.*/bind-address\t\t= 127.0.0.1/g" /etc/mysql/my.cnf
	fi
	#gedit /etc/my.cnf&gedit /etc/mysql/my.cnf&gedit /usr/etc/my.cnf&gedit ~/.my.cnf
	systemctl enable mysql
	printTime "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been allowed on the firewall. MySQL has been installed. MySQL config file has been secured. MySQL service has been restarted."
else
	echo Response not recognized.
fi
printTime "MySQL is complete."



clear
if [ $httpYN == no ]
then
	#ufw deny http
	#ufw deny https
	apt-get purge nginx -y -qq
	apt-get purge unicorn -y -qq
	apt-get purge apache -y -qq
	apt-get purge apache2 -y -qq
	rm -r /var/www/*
	printTime "http and https ports have been denied on the firewall. Apache & Apache2 has been removed. Web server files have been removed."
elif [ $httpYN == yes ]
then
	apt-get install apache2 -y -qq
	apt-get install apache2-utils -y -qq
	apt-get install libapache2-mod-security2 -y -qq
	apt-get install libapache2-mod-evasive
	systemctl enable apache2
	ufw allow http 
	ufw allow https
	cp /etc/apache2/apache2.conf ~/Desktop/backups/
	if [ -e /etc/apache2/apache2.conf ]
	then
  	  echo -e '\<Directory \>\n\t AllowOverride None\n\t Order Deny,Allow\n\t Deny from all\n\<Directory \/\>\nUserDir disabled root' >> /etc/apache2/apache2.conf
	fi
	chown -R root:root /etc/apache2

	printTime "http and https ports have been allowed on the firewall. Apache2 config file has been configured. Only root can now access the Apache2 folder."
else
	echo Response not recognized.
fi
printTime "Web Server is complete."

if [ $RemoteDesktopYN == no ]
then
	ufw deny 3389
	apt-get purge vinagre -y -qq
	apt-get purge remmina -y -qq
	apt-get purge remmina-plugin-rdp -y -qq
	apt-get purge remmina-plugin-vnc -y -qq
	apt-get purge remmina-plugin-telepathy
	apt-get purge remmina-plugin-xdmcp -y -qq
	apt-get purge remmina-plugin-nx -y -qq
	apt-get purge remmina-plugin-gnome -y -qq
	apt-get purge remmina-common -y -qq
	apt-get purge rsync -y -qq 
	apt-get purge unity-scope-video-remote -y -qq
	apt-get purge gdbserver -y -qq
	printTime "Remote Desktop Ports have been denied. Vinagre, Remmina, rsync, unity-scope-video-remote, and gsbserver Programs have been Removed."
elif [ $RemoteDesktopYN == yes ]
then
	ufw allow 3389
	apt-get install vinagre -qq
	printTime "Remote Desktop port was allowed. Vinagre has been Installed."
else
	echo "Response not recognized."
fi
printTime "Remote Desktop is Complete."


if [ $FirefoxYN == no ]
then
	apt-get remove firefox 
elif [ $FirefoxYN == yes ]
then
	echo -e "Make Sure Firefox Is Not Running During Update."
	read Firefox_input
	sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa
	apt-get update -y -qq
	#
	apt-get install firefox -y -qq
	echo -e "Firefox will open automatically. Make Sure to Set Mozilla Firefox"
	echo -e "Do The Security Browser Settings and Come Back to the Script after you are Done."
	echo -e "Press Enter to Continue."
	read FireFox_Security
	firefox -new-window www.google.com

	printTime "Firefox has been Updated, and Browser Security Settings has been enabled."
	echo -e "Firefox has been Updated, and Browser Security Settings has been enabled."
else
	echo "Response not Recognized."
fi
printTime "Firefox is Complete."
echo -e "Firefox is Complete."



apt-get autoremove -y
#Last Stand
#clear
#if [ $dnsYN == no ]
#then
#	ufw deny domain
#	apt-get purge bind9 -qq
#	printTime "domain port has been denied on the firewall. DNS name binding has been removed."
#elif [ $dnsYN == yes ]
#then
#	ufw allow domain
#	printTime "domain port has been allowed on the firewall."
#else
#	echo Response not recognized.
#fi
#printTime "DNS is complete."

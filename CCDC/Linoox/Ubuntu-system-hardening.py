#!/usr/bin/python3.7
import os
from pickletools import optimize
from turtle import update

os = os.system
o = os.popen
cls = os("clear")

root_checker = os.popen("./root_checker.sh").read().split('\n')
if (str(root_checker[0]) == "Error"):
    print("Error\nScript Must Be Run As Root")
    os("exit")

def backups():
    cls
    os("mkdir backups")
    os("chmod 777 backups/")
    os("cp /etc/shadow backups/")
    os("cp /etc/passwd backups/")
    os("cp -r /etc/pam.d backups/")
    os("cp /etc/login.defs backups/")
    os("cp /etc/sysctl.conf backups/")
    os("cp /etc/cron.allow backups/")
    os("cp /etc/cron.deny backups/")
    os("cp /etc/at.deny backups/")
    os("cp -r /etc/cron.d backups/")
    os("cp /etc/sudoers backups/")
    os("cp -r /etc/sudoers.d backups/")

def libpam_cracklib():
    cls
    os("apr update")
    os("apt install libpam-cracklib -y")

def pamd_scan():
    cls
    c = o("grep 'minlen=' /etc/pam.d/common-password").read().split('\n')

    if ("minlen=8" in str(c[0])):
        print("Minimum Password Length is: 8.")
    elif ("minlen=9" in str(c[0])):
        print("Minimum Password Length is: 9.")
    elif ("minlen=10" in str(c[0])):
        print("Minimum Password Length is: 10.")
    else:
        print("[!] Minimum Password Length is Lower Than 8!")
    
    c = o("grep 'pam.cracklib' /etc/pam.d/common-password").read().split('\n')

    if ("ucredit=-1" not in str(c[0])):
        print("[!] Misconfigured Password Complexity.")
    else:
        if ("lcredit=-1" not in str(c[0])):
            print("[!] Misconfigured Password Complexity.")
        else:
            if ("dcredit=-1" in str(c[0])):
                print("[!] Misconfigured Password Complexity.")
            else:
                if ("ocredit=-1" in str(c[0])):
                    print("[!] Misconfigured Password Complexity.")
                else:
                    print("Properly Configured Password Complexity.")
    
    c = o("grep 'remember=5' /etc/pam.d/common-password").read().split('\n')

    if ("remember=5" in str(c[0])):
        print("Password History is: 5")
    elif ("remember=6" in str(c[0])):
        print("Password History is: 6")
    elif ("remember=7" in str(c[0])):
        print("Password History is: 7")
    elif ("remember=8" in str(c[0])):
        print("Password History is: 8")
    elif ("remember=9" in str(c[0])):
        print("Password History is: 9")
    elif ("remember=10" in str(c[0])):
        print("Password History is: 10")
    else:
        print("[!] Password History is Lower Than 5")
    
    c = o("grep -R 'sha512' /etc/pam.d/common-password").read().split('\n')
    if ("sha512" in str(c[1])):
        print("SHA512 Encryption Algorithm is Used")
    else:
        print("[!] SHA512 Encryption Algorithm is NOT Used.")
    input("Press Enter to Continue: ")

def update_firefox():
    cls
    os("add-apt-repository ppa:ubuntu-mozilla-security/ppa")
    os("apt update")
    os("apt-get install firefox -y")

def firewall():
    cls
    os("apt install ufw -y")
    os("ufw enable")
    os("ufw logging high")
    os("ufw deny 1234")
    os("ufw deny 1337")

def antivirus():
    cls
    os("apt update")
    os("apt install chkrootkit clamav rkhunter apparmor apparmor-profiles apparmor-profiles-extra apparmor-notify lynis fail2ban modsecurity-crs debsecan unattended-upgrades aide arpwatch logwatch clamav-freshclam -y")
    os("systemctl start clamav-freshclam")

def sysctl():
    cls
    os("echo -e '# Controls IP packet forwarding\nnet.ipv4.ip_forward = 0\n\n# IP Spoofing protection\nnet.ipv4.conf.all.rp_filter = 1\nnet.ipv4.conf.default.rp_filter = 1\n\n# Ignore ICMP broadcast requests\nnet.ipv4.icmp_echo_ignore_broadcasts = 1\n\n# Disable source packet routing\nnet.ipv4.conf.all.accept_source_route = 0\nnet.ipv6.conf.all.accept_source_route = 0\nnet.ipv4.conf.default.accept_source_route = 0\nnet.ipv6.conf.default.accept_source_route = 0\n\n# Ignore send redirects\nnet.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\n\n# Block SYN attacks\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_max_syn_backlog = 2048\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 5\n\n# Log Martians\nnet.ipv4.conf.all.log_martians = 1\nnet.ipv4.icmp_ignore_bogus_error_responses = 1\n\n# Ignore ICMP redirects\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv6.conf.all.accept_redirects = 0\nnet.ipv4.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\n\n# Ignore Directed pings\nnet.ipv4.icmp_echo_ignore_all = 1\n\n# Accept Redirects? No, this is not router\nnet.ipv4.conf.all.secure_redirects = 0\n\n# Log packets with impossible addresses to kernel log? yes\nnet.ipv4.conf.default.secure_redirects = 0\n\n########## IPv6 networking start ##############\n# Number of Router Solicitations to send until assuming no routers are present.\n# This is host and not router\nnet.ipv6.conf.default.router_solicitations = 0\n\n# Accept Router Preference in RA?\nnet.ipv6.conf.default.accept_ra_rtr_pref = 0\n\n# Learn Prefix Information in Router Advertisement\nnet.ipv6.conf.default.accept_ra_pinfo = 0\n\n# Setting controls whether the system will accept Hop Limit settings from a router advertisement\nnet.ipv6.conf.default.accept_ra_defrtr = 0\n\n#router advertisements can cause the system to assign a global unicast address to an interface\nnet.ipv6.conf.default.autoconf = 0\n\n#how many neighbor solicitations to send out per address?\nnet.ipv6.conf.default.dad_transmits = 0\n\n# How many global unicast IPv6 addresses can be assigned to each interface?\nnet.ipv6.conf.default.max_addresses = 1\n\n########## IPv6 networking ends ##############' >> /etc/sysctl.conf")
    os("sysctl -p")

def kernal_hardening():
    cls
    os("echo -e '#Kernal Hardening\n#Kernal Logs\nkernel.dmesg_restrict = 1\n#Kernal Pointers\nkernel.kptr_restrict = 1\n#ExecShield Protection\nkernel.exec-shield = 2\n#Memory Protections\nkernel.randomize_va_space=2' >> /etc/sysctl.conf")
    os("sysctl -p")

def update_machine():
    cls
    os("apt update")
    os("apt upgrade -y")
    os("apt dist-upgrade -y")
    os("apt autoremove -y")

def vuln_scan():
    cls
    os("apt install nmap git -y")
    os("git clone https://github.com/vulnersCom/nmap-vulners.git")

    ports = input("Enter ports: ")

    os("nmap --script vulners.nse -A -sV 127.0.0.1 -p {}".format(ports))
    input("Continue: ")
    os("lynis audit system | tee lynis_scan.txt")
    os("rkhunter --propupd")
    os("rkhunter --update")
    os("rkhunter --check | tee rkhunter_scan.txt")
    

def logging_service():
    cls
    os("apt update")
    os("apt install auditd rsyslog")
    os("systemctl enable rsyslog")
    os("systemctl start rsyslog")
    os("auditctl -e 1")

def unalias():
    cls
    os("unalias -a")
    os("echo 'unalias -a' >> ~/.bashrc")
    os("echo 'unalias -a' >> /root/.bashrc")

def root_pass():
    cls
    os("passwd root")

def start_menu():
    cls
    print("""                
█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗
╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝

        ██    ██ ██████  ██    ██ ███    ██ ████████ ██    ██
        ██    ██ ██   ██ ██    ██ ████   ██    ██    ██    ██
        ██    ██ ██████  ██    ██ ██ ██  ██    ██    ██    ██
        ██    ██ ██   ██ ██    ██ ██  ██ ██    ██    ██    ██
         ██████  ██████   ██████  ██   ████    ██     ██████

                    Created By: Diego Cruz
█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗
╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝

1) Backup Files.                  7) Networking Hardening With Sysctl.
2) Install libpam-cracklib.       8) Kernal Hardening With Sysctl.
3) Scan Pam.d Configurations.     9) Update Machine.
4) Update Firefox                 10) Vuln Scan WIP.
5) Firewall (UFW)                 11) Unalias.
6) Install Antivirus/Anti-Rootkit 12) Change Root Password.
    """)

while True:
    start_menu()
    option = input("Select Option: ")

    if option == "1":
        backups()
    elif option == "2":
        libpam_cracklib()
    elif option == "3":
        pamd_scan()
    elif option == "4":
        update_firefox
    elif option == "5":
        firewall()
    elif option == "6":
        antivirus()
    elif option == "7":
        sysctl()
    elif option == "8":
        kernal_hardening()
    elif option == "9":
        update_machine()
    elif option == "10":
        vuln_scan()
    elif option == "11":
        unalias()
    elif option == "12":
        root_pass()
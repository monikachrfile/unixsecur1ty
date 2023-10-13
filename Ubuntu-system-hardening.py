#!/usr/bin/python3.7
import os
import subprocess
from time import sleep
import datetime

o = os.system
op = os.popen
cls = o("clear")

o("chmod +x external_scripts/*")
o("chmod +x get_users.sh")

root_checker = op("bash external_scripts/root_checker.sh").read().split('\n')
if (str(root_checker[0]) == "Error"):
    print("Error\nScript Must Be Run As Root")
    exit()

input("BEFORE STARTING. HAVE A SECOND TERMINAL LOGGED INTO ROOT IN CASE STUFF GETS BROKEN\nPress Enter Once Complete")

# Function to print messages with timestamps
def printTime(message):
    #import datetime
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print("[{}] {}".format(timestamp,message))
    sleep(2)

#TEST BACKUPS
def backups():
    cls
    print("============== PERFORMING BACKUPS OF CRITICAL SYSTEM FILE! ===============")
    sleep(1)
    o("mkdir backups")
    o("chmod 777 backups/")
    o("cp /etc/shadow* backups/")
    o("cp /etc/passwd* backups/")
    o("cp /etc/group backups/")
    o("cp /etc/group- backups/")
    o("cp -ar /etc/pam.d/ backups/")
    o("cp /etc/login.defs backups/")
    o("cp /etc/sysctl.conf backups/")
    o("cp /etc/cron.allow backups/")
    o("cp /etc/cron.deny backups/")
    o("cp /etc/at.deny backups/")
    o("cp -ar /etc/cron.d/ backups/")
    o("cp -ar /var/spool/cron/ backups/")
    o("cp /etc/sudoers backups/")
    o("cp -r /etc/sudoers.d/ backups/")
    o("cp /etc/login.defs backups/")
    o("cp -ar /etc/lightdm/ backups/")
    printTime("Backups Are Finished & Stored in backups/.\n")
    

#TO DO, HARDEST. MANUAL OR AUTO??
def account_policies():
    cls
    #Installing Libpam modules
    o("apr update")
    o("apt install libpam-cracklib libcrack2 libpam-pwquality -y")
    printTime("Automatic Account Policies Deployed.")
    print("""
    Get Ready to edit /etc/login.defs to the following:
    PASS_MAX_DAYS  90
    PASS_MIN_DAYS  5 
    PASS_WARN_AGE  7
    """)
    input("Press Enter to Continue.")
    o("nano /etc/login.defs")
    o("echo 'auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800' >> /etc/pam.d/common-auth")
    o("sed -i 's/\(pam_unix\.so.*\)$/\1 remember=5 minlen=8/' /etc/pam.d/common-password")
    o("sed -i 's/\(pam_cracklib\.so.*\)$/\1 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1/' /etc/pam.d/common-password")

def pamd_scan():
    cls
    c = op("grep 'minlen=' /etc/pam.d/common-password").read().split('\n')

    if ("minlen=8" in str(c[0])):
        print("Minimum Password Length is: 8.")
    elif ("minlen=9" in str(c[0])):
        print("Minimum Password Length is: 9.")
    elif ("minlen=10" in str(c[0])):
        print("Minimum Password Length is: 10.")
    else:
        print("[!] Minimum Password Length is Lower Than 8!")
    
    c = op("grep 'pam.cracklib' /etc/pam.d/common-password").read().split('\n')

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
    
    c = op("grep 'remember=5' /etc/pam.d/common-password").read().split('\n')

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
    
    c = op("grep -R 'sha512' /etc/pam.d/common-password").read().split('\n')
    if ("sha512" in str(c[1])):
        print("SHA512 Encryption Algorithm is Used")
    else:
        print("[!] SHA512 Encryption Algorithm is NOT Used.")
    input("Press Enter to Continue: ")

def print_time(message):
    print(message)

def user_auditing():
    # Get the list of user accounts from /etc/passwd
    #o("eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1 | tee users")
    o("bash get_users.sh")
    with open('external_files/users', 'r') as passwd_file:
        users = passwd_file.read().split()

    def change_pass():
        while True:
            yn3 = input("Enter Custom Password For {}? | yes or no: ".format(user))

            if yn3 == "yes":
                print("Please Type in a Password: ")
                o("passwd {}".format(user))
                printTime("{} has been given the password.".format(user))
                break
            if yn3 == "no":
                print("Continuing without changing password for {}...".format(user))
                break
            else:
                print("ERROR: NOT AN OPTION. \nOnly type yes or no")

    for user in users:
        cls
        while True:
            yn1 = input("Delete {} | yes or no: ".format(user))
            if yn1 == "yes":
                o("userdel -r {}".format(user))
                printTime("{} has been deleted.".format(user))
                break
            if yn1 == "no":
                while True:
                    yn2 = input("Is {} an administrator? yes or no: ".format(user))
                    if yn2 == "yes":
                        o("gpasswd -a "+user+" sudo")
                        o("gpasswd -a "+user+" adm")
                        o("gpasswd -a "+user+" lpadmin")
                        o("gpasswd -a "+user+" sambashare")
                        print_time("{} has been made an administrator.".format(user))
                        change_pass()
                        o("passwd -x90 -n5 -w7 {}".format(user))
                        printTime("{}'s password has been given a maximum age of 90 days, minimum of 5 days, and warning of 7 days. {}'s account has been locked.".format(user,user))
                        break
                    if yn2 == "no":
                        o("gpasswd -d {} sudo".format(user))
                        o("gpasswd -d {} adm".format(user))
                        o("gpasswd -d {} lpadmin".format(user))
                        o("gpasswd -d {} sambashare".format(user))
                        o("gpasswd -d {} root".format(user))
                        printTime("{} has been made a standard user.".format(user))
                        change_pass()
                        o("passwd -x90 -n5 -w7 {}".format(user))
                        printTime("{}'s password has been given a maximum age of 90 days, minimum of 5 days, and warning of 7 days. {}'s account has been locked.".format(user,user))
                        break
                    else:
                        print("Error, only choose yes or no")
                break
            else:
                print("Error: choose yes or no")
    


    print("Type user account names of users you want to add, with a space in between")
    print("If you have no one new to add just press enter.")
    users_new = input().split()
    
    for user_new in users_new:
        os.system("clear")
        while True:
            o("adduser {}".format(user_new))
            printTime("A user account for {} has been created.".format(user_new))
            yn_new = input("Make {} administrator? yes or no: ".format(user_new))
            if yn_new == "yes":
                o("gpasswd -a {} sudo".format(user_new))
                o("gpasswd -a {} adm".format(user_new))
                o("gpasswd -a {} lpadmin".format(user_new))
                o("gpasswd -a {} sambashare".format(user_new))
                printTime("{} has been made an administrator.".format(user_new))
            if yn_new == "no":
                printTime("{} has been made a standard user.".format(user_new))
            
            else:
                print("Error. Only choose yes or no!")
            
            o("passwd -x90  -n10 -w14 {}".format(user_new))




def updates():
    cls
    printTime("Operating System Updates")
    o("apt update")
    o("apt upgrade -y")
    o("apt dist-upgrade -y")
    o("apt autoremove -y")
    printTime("Firefox Update")
    o("add-apt-repository ppa:ubuntu-mozilla-security/ppa")
    o("apt update")
    o("apt-get install firefox -y")

def defensive_countermeasures():
    cls
    #Firewall
    o("apt install ufw -y")
    o("ufw enable")
    o("ufw logging high")
    o("ufw deny 1234")
    o("ufw deny 1337")
    #Install antivirus
    o("apt update")
    o("apt install chkrootkit clamav rkhunter apparmor apparmor-profiles apparmor-profiles-extra apparmor-notify lynis fail2ban modsecurity-crs debsecan unattended-upgrades aide arpwatch logwatch clamav-freshclam libpam-shield -y")
    o("systemctl start clamav-freshclam")


def local_security_policies():
    cls
    #Network sysctl configurationsnot
    #o("echo -e '# Controls IP packet forwarding\nnet.ipv4.ip_forward = 0\n\n# IP Spoofing protection\nnet.ipv4.conf.all.rp_filter = 1\nnet.ipv4.conf.default.rp_filter = 1\n\n# Ignore ICMP broadcast requests\nnet.ipv4.icmp_echo_ignore_broadcasts = 1\n\n# Disable source packet routing\nnet.ipv4.conf.all.accept_source_route = 0\nnet.ipv6.conf.all.accept_source_route = 0\nnet.ipv4.conf.default.accept_source_route = 0\nnet.ipv6.conf.default.accept_source_route = 0\n\n# Ignore send redirects\nnet.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\n\n# Block SYN attacks\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_max_syn_backlog = 2048\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 5\n\n# Log Martians\nnet.ipv4.conf.all.log_martians = 1\nnet.ipv4.icmp_ignore_bogus_error_responses = 1\n\n# Ignore ICMP redirects\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv6.conf.all.accept_redirects = 0\nnet.ipv4.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\n\n# Ignore Directed pings\nnet.ipv4.icmp_echo_ignore_all = 1\n\n# Accept Redirects? No, this is not router\nnet.ipv4.conf.all.secure_redirects = 0\n\n# Log packets with impossible addresses to kernel log? yes\nnet.ipv4.conf.default.secure_redirects = 0\n\n########## IPv6 networking start ##############\n# Number of Router Solicitations to send until assuming no routers are present.\n# This is host and not router\nnet.ipv6.conf.default.router_solicitations = 0\n\n# Accept Router Preference in RA?\nnet.ipv6.conf.default.accept_ra_rtr_pref = 0\n\n# Learn Prefix Information in Router Advertisement\nnet.ipv6.conf.default.accept_ra_pinfo = 0\n\n# Setting controls whether the system will accept Hop Limit settings from a router advertisement\nnet.ipv6.conf.default.accept_ra_defrtr = 0\n\n#router advertisements can cause the system to assign a global unicast address to an interface\nnet.ipv6.conf.default.autoconf = 0\n\n#how many neighbor solicitations to send out per address?\nnet.ipv6.conf.default.dad_transmits = 0\n\n# How many global unicast IPv6 addresses can be assigned to each interface?\nnet.ipv6.conf.default.max_addresses = 1\n\n########## IPv6 networking ends ##############' >> /etc/sysctl.conf")
    #o("sysctl -p")
    #Kernal sysctl
    #cls
    #o("echo -e '#Kernal Hardening\n#Kernal Logs\nkernel.dmesg_restrict = 1\n#Kernal Pointers\nkernel.kptr_restrict = 1\n#ExecShield Protection\nkernel.exec-shield = 2\n#Memory Protections\nkernel.randomize_va_space=2' >> /etc/sysctl.conf")
    o("sysctl -p sysctl-conf.txt")

def vuln_scan():
    cls
    o("apt install nmap git -y")
    o("git clone https://github.com/vulnersCom/nmap-vulners.git")

    ports = input("Enter ports: ")

    o("nmap --script vulners.nse -A -sV 127.0.0.1 -p {}".format(ports))
    input("Continue: ")
    o("lynis audit system | tee lynis_scan.txt")
    o("rkhunter --propupd")
    o("rkhunter --update")
    o("rkhunter --check | tee rkhunter_scan.txt")
    

def logging_auditing():
    cls
    o("apt update")
    o("apt install auditd rsyslog audispd-plugins -y")
    o("systemctl enable rsyslog")
    o("systemctl start rsyslog")
    o("systemctl start auditd")
    o("auditctl -e 1")

def service_mangement():
    cls

def remove_bad_programs():
    o("bash external_scripts/Remove_Bad_Programs.sh")
    cls

def fix_perms():
    cls
    #Ensure permissions on /etc/crontab are configured
    o("chown root:root /etc/crontab")
    o("chmod og-rwx /etc/crontab")
    #Ensure permissions on /etc/cron.hourly are configured
    o("chown root:root /etc/cron.hourly/")
    o("chmod og-rwx /etc/cron.hourly/")
    #Ensure permissions on /etc/cron.daily are configured
    o("chown root:root /etc/cron.daily/")
    o("chmod og-rwx /etc/cron.daily/")
    #Ensure permissions on /etc/cron.weekly are configured
    o("chown root:root /etc/cron.weekly/")
    o("chmod og-rwx /etc/cron.weekly/")
    #Ensure permissions on /etc/cron.monthly are configured
    o("chown root:root /etc/cron.monthly/")
    o("chmod og-rwx /etc/cron.monthly/")
    #Ensure permissions on /etc/cron.d are configured
    o("chown root:root /etc/cron.d/")
    o("chmod og-rwx /etc/cron.d/")

    #Ensure permissions on /etc/ssh/sshd_config are configured
    o("chown root:root /etc/ssh/sshd_config")
    o("chmod og-rwx /etc/ssh/sshd_config")
    #Ensure permissions on SSH private host key files are configured

    #Ensure permissions on /etc/passwd are configured
    o("chown root:root /etc/passwd")
    o("chmod u-x,go-wx /etc/passwd")
    #Ensure permissions on /etc/passwd- are configured
    o("chown root:root /etc/passwd-")
    o("chmod u-x,go-wx /etc/passwd-")
    #Ensure permissions on /etc/group are configured
    o("chown root:root /etc/group")
    o("chmod u-x,go-wx /etc/group")
    #Ensure permissions on /etc/group- are configured
    o("chown root:root /etc/group-")
    o("chmod u-x,go-wx /etc/group-")
    #Ensure permissions on /etc/shadow are configured
    o("chown root:root /etc/shadow")
    #remove excess permissions from /etc/shadow:
    o("chmod u-x,g-wx,o-rwx /etc/shadow")
def remove_malware():
    cls
    o("rkhunter --update")
    o("rkhunter --check")

    service_input = input("Do you have a web server as a critical service?")
    if service_input == "yes":
        o("git clone https://github.com/tinwaninja/Simple-Backdoor-Scanner-PHP.git")
        o("cp Simple-Backoor-Scanner-PHP/scanner.php /var/www/html/")
        o("firefox --new-window 127.0.0.1")

def uncatorigized():
    cls
    print("Removing All User Crontabs: ")
    o("rm /var/spool/cron/crontabs/*")
    #Restricted cron access to root
    o("echo 'root' > /etc/cron.allow")
    o("echo 'root' > /etc/at.allow")
    o("chmod 644 /etc/cron.allow")
    o("chmod 644 /etc/at.allow")
    print("Remove alias commands")
    o("unalias -a")
    o("echo 'unalias -a' >> ~/.bashrc")
    o("echo 'unalias -a' >> /root/.bashrc")
    print("Disable USB's")
    o("echo 'install usb-storage /bin/true' >> /etc/modprobe.d/disable-usb-storage.conf")
    #Disabled thunderbolt and firewire access
    o("echo 'blacklist firewire-core' >> /etc/modprobe.d/firewire.conf")
    o("echo 'blacklist thunderbolt' >> /etc/modprobe.d/thunderbolt.conf")
def root_pass():
    cls
    o("passwd root")

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

1) Backup Files. ("DO FIRST")  7) Logging & Auditing
2) Updates                     8) Service Managment
3) User Auditing               9) Remove Bad Programs
4) Account Policies           10) Fix Permissions
5) Defensive Countermeasures  11) Malware Sus Detection & Removal
6) Local Security Policies    12) Uncatorigized Security Configurations
    """)

while True:
    start_menu()
    option = input("Select Option: ")

    if option == "1":
        backups()
    elif option == "2":
        updates()
    elif option == "3":
        user_auditing()
    elif option == "4":
        account_policies()
    elif option == "5":
        defensive_countermeasures()
    elif option == "6":
        local_security_policies()
    elif option == "7":
        logging_auditing()
    elif option == "8":
        service_mangement()
    elif option == "9":
        remove_bad_programs()
    elif option == "10":
        fix_perms()
    elif option == "11":
        remove_malware()
    elif option == "12":
        uncatorigized()

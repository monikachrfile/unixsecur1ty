import os 
o = os.system

def openssh(o.option):
    op = o.option
    if op == "1":
        backup_folder = "~/.BACKUPS/"
        bkup_exist = os.path.isdir(backup_folder)
        if bkup_exist == False:
                o("mkdir ~/.BACKUPS")
                bkup_exist = os.path.isdir(backup_folder)
        
        if bkup_exist == True:
            o("mkdir ~/.BACKUPS/sshd/")
            o("mkdir ~/.BACKUPS/sshd/confs/")
            o("mkdir ~/.BACKUPS/sshd/logs/")
            o("cp /etc/ssh/sshd {}sshd/confs/".format(backup_folder))
            o("cp /etc/ssh/logs {}sshd/logs/".format(backup_folder))
            o("clear")

    if op == "2":
        o("")

        

def Main_Menu():
    print("What Services are Critical?")
    print("-"*15)
    print("[1] OpenSSH")
    print("[2] VSFTPD")
    print("[3] Samba")
    print("[4] Wordpress\n")
    m = Main_Menu 
    m.choice = input("Enter Your Choice> ")

        #return choice
        #return service
def Option_Menu(service):
        while True:
            o("cls")
            print("="*15+" Chosen: "+str(service)+" "+"="*8)
            print("WHAT DO YOU WANT TO DO:")
            print("[1]--- Backup Service Configurations & Files")
            print("[2]--- Check Service Version & Avaliable Updates")
            print("[3]--- Load Basic Configurations")
            print("[4]--- Add Secure Configurations & Additional Avaliable Security Software")
            print("[0]--- Exit Back to Menu")
            print("="*25)
            o = Option_Menu
            o.option = input("Choice> ")
            openssh(o.option)
            if o.option == "0":
                break

while True:
    Main_Menu()
    m = Main_Menu
    o = Option_Menu

    if m.choice == "1":
        service = "OpenSSH"
        Option_Menu(service)
    elif m.choice == "2":
        service = "VSFTPd"
        Option_Menu(service)
    elif m.choice == "3":
        service = "Samba"
        Option_Menu(service)
    elif m.choice == "4":
        service = "Wordpress"
        Option_Menu(service)
    else:
        print("Wrong Option.")


o("pause")
#!/bin/bash

mkdir .backups
chmod 770 .backups/
mkdir .backups/important/
mkdir .backups/web/
mkdir .backups/logs/
mkdir .backups/home/
chmod 770 -R .backups/
cp /etc/shadow* .backups/important/
cp /etc/passwd* .backups/important/
cp /etc/group .backups/important/
cp /etc/group- .backups/important/
cp -ar /etc/pam.d/ .backups/important/
cp /etc/login.defs .backups/important/
cp /etc/sysctl.conf .backups/important/
cp /etc/cron.allow .backups/important/
cp /etc/cron.deny .backups/important/
cp /etc/at.deny .backups/important/
cp -ar /etc/cron.d/ .backups/important/
cp -ar /var/spool/cron/ .backups/important/
cp /etc/sudoers .backups/important/
cp -r /etc/sudoers.d/ .backups/important/
cp /etc/login.defs .backups/important/
cp -ar /etc/lightdm/ .backups/important/
cp -ar /etc/ .backups/
cp -ar /home/ .backups/home/
cp -ar /var/www/ .backups/web/
cp -ar /srv/ .backups/web/
cp -ar /var/log/ .backups/log/

sudo apt install zip unzip
dnf install zip
sudo yum install zip
sudo pacman -S zip
apk add zip
sudo pkg install zip

zip blackteam.zip .backups/

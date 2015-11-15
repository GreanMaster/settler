#!/usr/bin/env bash

# Update mirror repository
echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> tmp
mv /etc/apt/sources.list ./sources.tmp
cat tmp sources.tmp >> merged.tmp
mv merged.tmp /etc/apt/sources.list
rm -rf *tmp

# Update Package List

apt-get update

# Update Grub Bootloader

echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
apt-get -y remove grub-pc
apt-get -y install grub-pc
grub-install /dev/sda
update-grub

# Upgrade System Packages

apt-get -y upgrade

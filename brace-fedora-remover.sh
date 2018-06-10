#!/bin/bash
#Copyright (c) 2018 Divested Computing, Inc.
#License: GPLv3

if [[ $EUID -ne 0 ]]; then echo 'This script needs to be run as root!'; exit 1; fi;

packages="";

#Personally Installed
packages=$packages" brasero";
#CentOS 7
packages=$packages" empathy";
#Workstation (GNOME)
packages=$packages" rhythmbox gnome-documents gnome-weather";
#KDE
packages=$packages" kmahjongg konqueror amarok k3b";
#LXDE
packages=$packages" gnumeric abiword midori xpad pidgin asunder lxmusic clipit";
#LXQT
packages=$packages" yarock qlipper quassel qupzilla";
#MATE
packages=$packages" xfburn gnote filezilla hexchat exaile gparted";
#XFCE
packages=$packages" clipman xfburn geany pidgin asunder pragha abiword gnumeric gparted xfdashboard";

yum remove $packages;

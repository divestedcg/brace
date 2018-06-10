#!/bin/bash
#Copyright (c) 2018 Divested Computing, Inc.
#License: GPLv3

if [ -f /etc/centos-release ]; then yum install epel-release; fi;

yum install irqbalance nano htop screen p7zip pixz lm_sensors parallel screenfetch java-1.8.0-openjdk @multimedia aspell aspell-en gnome-terminal-nautilus gnome-tweak-tool dconf-editor numix-icon-theme-circle seahorse adobe-source-code-pro-fonts mozilla-fira-mono-fonts mozilla-fira-sans-fonts google-droid-sans-fonts google-droid-sans-mono-fonts google-droid-serif-fonts audacity lynis checksec evolution testdisk smartmontools mediawriter hdparm libreoffice meld pdfmod ecryptfs-utils encfs quadrapassel gnome-2048 gnome-mines aisleriot gimp inkscape darktable pitivi jpegoptim optipng firefox mozilla-https-everywhere mozilla-ublock-origin picard soundconverter sound-juicer lollypop youtube-dl keepassxc pwgen bleachbit srm clamav clamav-data-empty clamav-update clamtk unhide chkrootkit firewall-config tor torsocks tor-arm onionshare torbrowser-launcher transmission whois mtr vdpauinfo stress iotop wavemon tree pv iperf3 bmon powertop ncdu;

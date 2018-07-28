#!/bin/bash
#Copyright (c) 2018 Divested Computing, Inc.
#License: GPLv3

if [[ $EUID -ne 0 ]]; then echo 'This script needs to be run as root!'; exit 1; fi;

if [ -f /etc/centos-release ]; then yum install epel-release; fi;

yum install --skip-broken irqbalance nano htop screen p7zip pixz lm_sensors parallel screenfetch ripgrep java-1.8.0-openjdk @multimedia aspell aspell-en gnome-terminal-nautilus gnome-tweak-tool dconf-editor numix-icon-theme-circle seahorse libva-utils vdpauinfo mesa-dri-drivers libva-intel-driver libvdpau-va-gl gstreamer1-vaapi adobe-source-code-pro-fonts mozilla-fira-mono-fonts mozilla-fira-sans-fonts google-droid-sans-fonts google-droid-sans-mono-fonts google-droid-serif-fonts audacity lynis checksec evolution testdisk smartmontools mediawriter hdparm libreoffice meld pdfmod ecryptfs-utils encfs quadrapassel gnome-2048 gnome-mines aisleriot gimp inkscape darktable pitivi jpegoptim optipng firefox mozilla-https-everywhere mozilla-ublock-origin liferea picard soundconverter sound-juicer lollypop youtube-dl keepassxc pwgen u2f-hidraw-policy bleachbit srm clamav clamav-data-empty clamav-update clamtk unhide chkrootkit firewall-config tor torsocks tor-arm onionshare torbrowser-launcher transmission whois mtr stress iotop wavemon tree pv iperf3 bmon powertop ncdu;

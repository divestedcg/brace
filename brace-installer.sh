#!/bin/bash
#brace
#Copyright (c) 2015-2019 Divested Computing Group
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.

coloroff='\e[0m';
black='\e[0;30m';
blue='\e[0;34m';
cyan='\e[0;36m';
green='\e[0;32m';
purple='\e[0;35m';
red='\e[0;31m';
white='\e[0;37m';
yellow='\e[0;33m';

#
#Start functions
#
whichPackageManager() {
	if type "zypper" &> /dev/null; then
		echo "zypper" && return 0;
	fi;
	if type "dnf" &> /dev/null; then
		echo "dnf" && return 0;
	fi;
	if type "yum" &> /dev/null; then
		echo "yum" && return 0;
	fi;
	if type "pacman" &> /dev/null; then
		echo "pacman" && return 0;
	fi;
	if type "apt" &> /dev/null; then
		echo "apt" && return 0;
	fi;
}

handleInstall() {
	if [ "$packageManager" == "apt" ]; then
		#TODO: maybe call for each individual package? also skip if unavailable?
		$packageManager install --no-install-recommends $packagesDebian $packagesBaseDebian;
	fi;
	if [ "$packageManager" == "dnf" ] || [ "$packageManager" == "yum" ]; then
		$packageManager install --skip-broken $packagesFedora $packagesBaseFedora;
	fi;
	if [ "$packageManager" == "pacman" ]; then
		#TODO: handle AUR?
		$packageManager -S --needed $packagesArch $packagesBaseArch;
	fi;
	if [ "$packageManager" == "zypper" ]; then
		$packageManager install --no-recommends $packagesSuse $packagesBaseSuse;
	fi;
}

handleRemove() {
	if [ "$packageManager" == "apt" ]; then
		$packageManager remove $packagesDebian;
	fi;
	if [ "$packageManager" == "dnf" ] || [ "$packageManager" == "yum" ]; then
		$packageManager remove --skip-broken $packagesFedora;
	fi;
	if [ "$packageManager" == "pacman" ]; then
		#TODO: call for each individual package
		$packageManager -Rsc $packagesArch;
	fi;
	if [ "$packageManager" == "zypper" ]; then
		$packageManager remove $packagesSuse;
	fi;
}

cleanupOperation() {
	unset category baseIncluded packagesArch packagesDebian packagesFedora packagesSuse;
}

handleOperation() {
	if [ "$baseInstall" = true ]; then
		if [ "$baseIncluded" = true ]; then
			echo -e "${green}Including packages from the $category category${coloroff}";
			if [ "$packageManager" == "apt" ]; then
				packagesBaseDebian="$packagesBaseDebian $packagesDebian";
			fi;
			if [ "$packageManager" == "dnf" ] || [ "$packageManager" == "yum" ]; then
				packagesBaseFedora="$packagesBaseFedora $packagesFedora";
			fi;
			if [ "$packageManager" == "pacman" ]; then
				packagesBaseArch="$packagesBaseArch $packagesArch";
			fi;
			if [ "$packageManager" == "zypper" ]; then
				packagesBaseSuse="$packagesBaseSuse $packagesSuse";
			fi;
		else
			echo -e "${yellow}Skipping packages from the $category category${coloroff}";
		fi;
	else
		echo -e "${purple}Do you want packages from the $category category?${coloroff}";
		select yns in "Yes" "No" "Skip"; do
			case $yns in
				Yes )
					handleInstall;
					break;;
				No )
					handleRemove;
					break;;
				Skip )
					#do nothing
					break;;
			esac;
		done;
	fi;
	cleanupOperation;
}

handleCleanup() {
	if [ "$packageManager" == "apt" ]; then
		$packageManager autoremove;
	fi;
	if [ "$packageManager" == "dnf" ] || [ "$packageManager" == "yum" ]; then
		$packageManager autoremove;
	fi;
	if [ "$packageManager" == "pacman" ]; then
		$packageManager -Rns $(pacman -Qttdq);
		paccache -rk0;
	fi;
	if [ "$packageManager" == "zypper" ]; then
		#TODO: handle this, similar to pacman
		true;
	fi;
}
#
#End functions
#

#
#Start glue
#
if [[ $EUID -ne 0 ]]; then echo -e "${red}ERROR: This script needs to be run as root!${coloroff}"; exit 1; fi;
echo -e "${cyan}INFO: This script is fully intended for use on desktop machines, not servers!${coloroff}";
echo -e "${cyan}INFO: This script is geared towards personal use and some packages may not be appropiate for business systems!${coloroff}";
if [ -f /etc/centos-release ]; then yum install epel-release; fi;

packageManager=$(whichPackageManager);
if [ -z ${packageManager} ]; then
	echo -e "${red}ERROR: No package manager found!${coloroff}";
	return 1;
else
	echo -e "${cyan}INFO: Using $packageManager as package manager${coloroff}";
fi;

echo -e "${purple}Would you like to simply install all 'base' packages?${coloroff}";
select yn in "Yes" "No"; do
	case $yn in
		Yes )
			baseInstall=true;
			break;;
		No )
			baseInstall=false;
			break;;
	esac;
done;
#
#End glue
#

#
#Start categories
#
category='Core';
	baseIncluded=true;
	packagesArch='rng-tools irqbalance openssh nano htop wget screen zip p7zip pixz pigz lm_sensors ripgrep dialog crda lostfiles';
	packagesDebian='rng-tools irqbalance openssh nano htop wget screen p7zip pixz lm-sensors ripgrep';
	packagesFedora='rng-tools irqbalance openssh nano htop wget screen p7zip pixz lm_sensors ripgrep zram';
	packagesSuse='';
	handleOperation;
category='Frameworks';
	baseIncluded=true;
	packagesArch='jre8-openjdk python';
	packagesDebian='openjdk-8-jre';
	packagesFedora='java-1.8.0-openjdk';
	packagesSuse='';
	handleOperation;
category='GNOME Extras';
	baseIncluded=false;
	packagesArch='nautilus-terminal gnome-tweak-tool seahorse';
	packagesDebian='gnome-terminal-nautilus gnome-tweak-tool seahorse';
	packagesFedora='gnome-terminal-nautilus gnome-tweak-tool seahorse';
	packagesSuse='';
	handleOperation;
category='OpenCL';
	baseIncluded=false;
	packagesArch='';
	packagesDebian='clinfo mesa-opencl-icd beignet-opencl-icd pocl-opencl-icd';
	packagesFedora='clinfo mesa-libOpenCL beignet pocl';
	packagesSuse='';
	handleOperation;
category='VA-API';
	baseIncluded=true;
	packagesArch='libva-mesa-driver libva-intel-driver intel-media-driver'; #gstreamer-vaapi
	packagesDebian='mesa-dri-drivers libva-utils libva-intel-driver'; #gstreamer1-vaapi
	packagesFedora='mesa-dri-drivers libva-utils libva-intel-driver libva-intel-hybrid-driver'; #gstreamer1-vaapi
	packagesSuse='';
	handleOperation;
category='VDPAU';
	baseIncluded=false;
	packagesArch='vdpauinfo libvdpau libvdpau-va-gl libva-vdpau-driver mesa-vdpau';
	packagesDebian='vdpauinfo libvdpau-va-gl';
	packagesFedora='vdpauinfo libvdpau libvdpau-va-gl libva-vdpau-driver';
	packagesSuse='';
	handleOperation;
category='Theming';
	baseIncluded=false;
	packagesArch='numix-circle-icon-theme arc-gtk-theme';
	packagesDebian='numix-icon-theme-circle arc-theme';
	packagesFedora='numix-icon-theme-circle arc-theme';
	packagesSuse='';
	handleOperation;
category='Fonts';
	baseIncluded=true;
	packagesArch='adobe-source-code-pro-fonts ttf-fira-mono ttf-fira-sans ttf-liberation cantarell-fonts gsfonts noto-fonts noto-fonts-emoji ttf-freefont';
	packagesDebian='adobe-source-code-pro-fonts fonts-firacode';
	packagesFedora='adobe-source-code-pro-fonts mozilla-fira-mono-fonts mozilla-fira-sans-fonts';
	packagesSuse='';
	handleOperation;
category='Audio Manipulation';
	baseIncluded=true;
	packagesArch='audacity';
	packagesDebian='audacity';
	packagesFedora='audacity';
	packagesSuse='';
	handleOperation;
category='Audit';
	baseIncluded=true;
	packagesArch='lynis checksec spectre-meltdown-checker arch-audit';
	packagesDebian='lynis checksec spectre-meltdown-checker';
	packagesFedora='lynis checksec spectre-meltdown-checker';
	packagesSuse='';
	handleOperation;
category='Chat';
	baseIncluded=false;
	packagesArch='hexchat gajim mumble';
	packagesDebian='hexchat dino-im mumble';
	packagesFedora='hexchat dino mumble';
	packagesSuse='';
	handleOperation;
category='Communication';
	baseIncluded=true;
	packagesArch='evolution';
	packagesDebian='evolution';
	packagesFedora='evolution';
	packagesSuse='';
	handleOperation;
category='Cryptocurrency';
	baseIncluded=false;
	packagesArch='electrum';
	packagesDebian='electrum';
	packagesFedora='electrum';
	packagesSuse='';
	handleOperation;
category='Development';
	baseIncluded=false;
	packagesArch='git gitg ghex sqlitebrowser gcc';
	packagesDebian='git gitg ghex sqlitebrowser build-essential';
	packagesFedora='git gitg ghex sqlitebrowser @development-tools';
	packagesSuse='';
	handleOperation;
category='Development - Android';
	baseIncluded=false;
	packagesArch='android-udev android-tools enjarify android-apktool sdat2img android-studio';
	packagesDebian='adb fastboot enjarify';
	packagesFedora='android-tools enjarify';
	packagesSuse='';
	handleOperation;
category='Development - Java';
	baseIncluded=false;
	packagesArch='jdk8-openjdk eclipse-java proguard jd-gui launch4j';
	packagesDebian='openjdk-8-jdk eclipse-jdt proguard';
	packagesFedora='java-1.8.0-openjdk-devel eclipse-jdt proguard';
	packagesSuse='';
	handleOperation;
category='Development - Distro Specific Packaging';
	baseIncluded=false;
	packagesArch='asp';
	packagesDebian='';
	packagesFedora='fedpkg';
	packagesSuse='';
	handleOperation;
category='Disks - Management';
	baseIncluded=true;
	packagesArch='testdisk smartmontools parted gnome-multi-writer';
	packagesDebian='testdisk smartmontools parted gnome-multi-writer';
	packagesFedora='testdisk smartmontools parted gnome-multi-writer mediawriter';
	packagesSuse='';
	handleOperation;
category='Disks - File Systems';
	baseIncluded=true;
	packagesArch='btrfs-progs dosfstools exfat-utils f2fs-tools mtools ntfs-3g udftools xfsprogs';
	packagesDebian='btrfs-progs dosfstools exfat-utils f2fs-tools mtools ntfs-3g udftools xfsprogs';
	packagesFedora='btrfs-progs dosfstools exfat-utils f2fs-tools mtools ntfs-3g ntfsprogs udftools xfsprogs';
	packagesSuse='';
	handleOperation;
category='Files - Backup';
	baseIncluded=true;
	packagesArch='backintime';
	packagesDebian='backintime-qt4';
	packagesFedora='backintime-qt4';
	packagesSuse='';
	handleOperation;
category='Files - Encryption';
	baseIncluded=true;
	packagesArch='ecryptfs-utils encfs cryfs gocryptfs sirikali';
	packagesDebian='ecryptfs-utils encfs cryfs gocryptfs sirikali';
	packagesFedora='ecryptfs-utils encfs cryptsetup-reencrypt sirikali';
	packagesSuse='';
	handleOperation;
category='Files - Sharing';
	baseIncluded=true;
	packagesArch='transmission-gtk'; #magic-wormhole
	packagesDebian='transmission-gtk'; #magic-wormhole
	packagesFedora='transmission'; #magic-wormhole
	packagesSuse='';
	handleOperation;
category='Files - Syncing';
	baseIncluded=false;
	packagesArch='syncthing';
	packagesDebian='syncthing';
	packagesFedora='syncthing';
	packagesSuse='';
	handleOperation;
category='Games - Tiny';
	baseIncluded=true;
	packagesArch='quadrapassel gnome-mines gnome-chess gnome-sudoku aisleriot';
	packagesDebian='quadrapassel gnome-mines gnome-chess gnome-sudoku aisleriot';
	packagesFedora='quadrapassel gnome-mines gnome-chess gnome-sudoku aisleriot';
	packagesSuse='';
	handleOperation;
category='Games - Sandbox';
	baseIncluded=false;
	packagesArch='minetest';
	packagesDebian='minetest';
	packagesFedora='minetest';
	packagesSuse='';
	handleOperation;
category='Games - Arena';
	baseIncluded=false;
	packagesArch='xonotic';
	packagesDebian='xonotic';
	packagesFedora='xonotic';
	packagesSuse='';
	handleOperation;
category='Image Manipulation';
	baseIncluded=true;
	packagesArch='gimp inkscape darktable pitivi jpegoptim optipng';
	packagesDebian='gimp inkscape darktable pitivi jpegoptim optipng';
	packagesFedora='gimp gimpfx-foundry inkscape darktable pitivi jpegoptim optipng';
	packagesSuse='';
	handleOperation;
category='Internet';
	baseIncluded=true;
	packagesArch='firefox firefox-extension-https-everywhere liferea';
	packagesDebian='firefox-esr webext-https-everywhere webext-ublock-origin liferea';
	packagesFedora='firefox mozilla-https-everywhere mozilla-ublock-origin liferea';
	packagesSuse='';
	handleOperation;
category='Media - Consumption';
	baseIncluded=true;
	packagesArch='vlc lollypop gnome-books youtube-dl';
	packagesDebian='multimedia-codecs vlc pragha gnome-books youtube-dl';
	packagesFedora='@multimedia vlc lollypop gnome-books youtube-dl';
	packagesSuse='';
	handleOperation;
category='Media - HTPC';
	baseIncluded=false;
	packagesArch='kodi';
	packagesDebian='kodi';
	packagesFedora='kodi';
	packagesSuse='';
	handleOperation;
category='Media - Music Management';
	baseIncluded=false;
	packagesArch='picard soundconverter sound-juicer';
	packagesDebian='picard soundconverter sound-juicer';
	packagesFedora='picard soundconverter sound-juicer';
	packagesSuse='';
	handleOperation;
category='Office';
	baseIncluded=true;
	packagesArch='libreoffice-fresh meld scribus gnucash dia aspell aspell-en hyphen hyphen-en libmythes mythes-en hunspell hunspell-en';
	packagesDebian='libreoffice meld scribus gnucash dia aspell aspell-en';
	packagesFedora='libreoffice meld scribus gnucash dia aspell aspell-en';
	packagesSuse='';
	handleOperation;
category='Passwords';
	baseIncluded=true;
	packagesArch='keepassxc pwgen';
	packagesDebian='keepassxc pwgen diceware libu2f-udev ssss';
	packagesFedora='keepassxc pwgen diceware u2f-hidraw-policy ssss';
	packagesSuse='';
	handleOperation;
category='Privacy';
	baseIncluded=true;
	packagesArch='bleachbit wipe scrub';
	packagesDebian='bleachbit wipe scrub';
	packagesFedora='bleachbit srm wipe scrub';
	packagesSuse='';
	handleOperation;
category='Screencast';
	baseIncluded=false;
	packagesArch='obs-studio';
	packagesDebian='obs-studio';
	packagesFedora='obs-studio';
	packagesSuse='';
	handleOperation;
category='Security - Malware';
	baseIncluded=true;
	packagesArch='clamav clamtk rkhunter unhide';
	packagesDebian='clamav clamtk chkrootkit unhide';
	packagesFedora='clamav clamav-data-empty clamav-update clamtk chkrootkit unhide'; #rkhunter
	packagesSuse='';
	handleOperation;
category='Security - System';
	baseIncluded=true;
	packagesArch='firejail apparmor linux-hardened';
	packagesDebian='firejail apparmor apparmor-utils';
	packagesFedora='firejail firewall-config setroubleshoot';
	packagesSuse='';
	handleOperation;
category='Tor';
	baseIncluded=true;
	packagesArch='tor torsocks onionshare';
	packagesDebian='tor torsocks obfs4proxy onionshare torbrowser-launcher';
	packagesFedora='tor torsocks obfs4 onionshare torbrowser-launcher';
	packagesSuse='';
	handleOperation;
category='Utility';
	baseIncluded=true;
	packagesArch='dconf-editor whois mtr stress iotop wavemon pv tree iperf3 bmon powertop ncdu';
	packagesDebian='dconf-editor whois mtr stress iotop wavemon pv tree iperf3 bmon powertop ncdu vrms';
	packagesFedora='dconf-editor whois mtr stress iotop wavemon pv tree iperf3 bmon powertop ncdu vrms-rpm';
	packagesSuse='';
	handleOperation;
category='Virtualization';
	baseIncluded=false;
	packagesArch='libvirt virt-manager qemu';
	packagesDebian='';
	packagesFedora='@virtualization';
	packagesSuse='';
	handleOperation;
category='Wine';
	baseIncluded=false;
	packagesArch='wine-staging winetricks';
	packagesDebian='wine winetricks';
	packagesFedora='wine winetricks';
	packagesSuse='';
	handleOperation;
#
#End categories
#

#Queued base install if selected
if [ "$baseInstall" = true ]; then
	handleInstall;
	echo -e "${cyan}INFO: Packages installed${coloroff}";
fi;

#Cleanup
echo -e "${cyan}INFO: Cleaning up${coloroff}";
handleCleanup;

#Finish
echo -e "${cyan}INFO: Installer complete!${coloroff}";
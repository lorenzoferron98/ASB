#!/bin/sh

set -e

clear
cat /proc/asound/cards
echo
read -p "Enter Your Card: "  card
sudo bash -c "cat >> /etc/asound.conf" << EOL
defaults.ctl.card ${card}
defaults.pcm.card ${card}
defaults.timer.card ${card}
EOL

sudo pacman -Syu

# I pacchetti correlati (od opzionali) inserirli sulla stessa linea.
# Se si vuole evitare di installare pacchetti cancellare le righe.
sudo pacman -S \
	       firefox-i18n-it \
               pluma \
               gnome-icon-theme kaffeine kio-extras kio kded \
               vlc libdvdcss mesa-vdpau pulseaudio \
               wicd-gtk xfce4-notifyd python2-notify \
               xdg-utils xdg-user-dirs-gtk \
               ntfs-3g \
               autorandr lxrandr \
               pcmanfm gvfs gvfs-afc usbmuxd \
               screenfetch \
               nano \
               lxdm lxterminal menu-cache lxmenu-data lxhotkey lxinput lxsession lxde-common \
               lxpanel libnotify parcellite \
               lxappearance-obconf gtk-engine-murrine faenza-icon-theme gnome-themes-extra \
               dosfstools mtools \
               htop \
               xf86-video-fbdev xf86-video-vesa  \
               acpid \
               alsa-utils xterm \
               git \
               xorg-xkill \
               evince \
               nvidia-390xx nvidia-390xx-utils lib32-nvidia-390xx-utils nvidia-390xx-settings \
               d-feet python-dbus kshutdown \
               ntp

sudo pacman -S --needed base-devel
sudo nano /etc/makepkg.conf

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ..

yay

yay -S \
	osx-arc-shadow capitaine-cursors \
	lxkb_config-git \
	xorg-xkbprint \
	gksu

#
# Show keyboard geometry/model. https://superuser.com/q/1293956
#
#	e.g.: setxkbmap -model pc104 -layout it -option terminate:ctrl_alt_bksp -print | xkbcomp - - | xkbprint - - | ps2pdf - > pc104_it.pdf
# (vedi sopra, gia' presente)
# yay -S xorg-xkbprint

# https://en.wikipedia.org/wiki/NTP_pool
sudo timedatectl set-timezone Europe/Rome
sudo nano /etc/ntp.conf

#
# Keyboard configuration
#	https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration
#
#	localectl set-x11-keymap \
#		XkbLayout: localectl list-x11-keymap-layouts \
#		XkbModel: localectl list-x11-keymap-models \
#		XkbVariant: se vuoto usa "", localectl list-x11-keymap-variants [layout] \
#		XkbOptions: localectl list-x11-keymap-options
#
localectl set-x11-keymap \
	it \
	pc105 \
	"" \
	terminate:ctrl_alt_bksp

sudo systemctl enable lxdm
sudo systemctl start wicd
sudo systemctl enable wicd
sudo systemctl start usbmuxd.service
sudo systemctl enable usbmuxd.service
sudo systemctl start ntpd
sudo systemctl enable ntpd
sudo systemctl start acpid.service
sudo systemctl enable acpid.service

# Unused service with wicd enabled
sudo systemctl stop dhcpcd.service 
sudo systemctl disable dhcpcd.service

clear
echo "*******************************************"
echo
echo "	- Press F5"
echo "	- Use arrow (->) to move until"
echo "	  hitting the <Auto-Mute> control"
echo "	- use the minus (-) key to switch"
echo "	- hit Esc to exit"
echo
echo "*******************************************"
read -p "Press enter to continue..."
echo
alsamixer
sudo alsactl store

sudo touch /etc/pacman.d/hooks/nvidia.hook

sudo reboot now

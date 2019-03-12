#!/bin/sh

set -e

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
               bash-completion \
               firefox-i18n-it \
               pluma \
               # gnome-icon-theme kaffeine kio-extras kio kded \
               evince \
               libreoffice-fresh-it \
               vlc libdvdcss pulseaudio \
               k3b dvd+rw-tools kinit kparts cdrdao \
               gpicview \
               thunderbird-i18n-it \
               galculator-gtk2 \
               virtualbox linux-headers \
               flashplugin \
               wicd-gtk xfce4-notifyd python2-notify \
               xdg-utils xdg-user-dirs-gtk \
               ntfs-3g \
               gparted \
               autorandr lxrandr \
               pcmanfm gvfs gvfs-afc usbmuxd gvfs-gphoto2 \
               screenfetch \
               nano wpa_supplicant \
               lxdm lxterminal menu-cache lxmenu-data lxhotkey lxinput lxsession lxde-common \
               lxpanel libnotify parcellite \
               lxappearance-obconf gtk-engine-murrine faenza-icon-theme gnome-themes-extra \
               xarchiver zip unzip unrar tar gzip xz \
               dosfstools mtools \
               htop \
               laptop-detect \
               xf86-video-fbdev xf86-video-intel xf86-video-nouveau xf86-video-vesa \
	       # xf86-video-vmware \
               acpid \
               system-config-printer cups \
               alsa-utils xterm \
               gimp \
               git \
               xorg-xkill \
               nvidia-settings \
               gnome-screenshot \
               pinta \
               ntp

sudo pacman -S --needed base-devel
sudo nano /etc/makepkg.conf

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ..

yay

yay -S jre8 
yay -S \
        jdownloader2 \
        osx-arc-shadow capitaine-cursors \
        lxkb_config-git \
        virtualbox-ext-oracle \
        ttf-ms-fonts \
        gksu \
        xorg-xkbprint

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
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service
sudo systemctl start usbmuxd.service
sudo systemctl enable usbmuxd.service
sudo systemctl start ntpd
sudo systemctl enable ntpd

# Unused service with wicd enabled
sudo systemctl stop dhcpcd.service 
sudo systemctl disable dhcpcd.service

alsamixer
sudo alsactl store

sudo reboot now

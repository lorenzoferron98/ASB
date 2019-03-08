#!/bin/sh

set -e

sudo pacman -Syu

# I pacchetti correlati (od opzionali) inserirli sulla stessa linea.
# Se si vuole evitare di installare pacchetti commentare le righe.
sudo pacman -S \
               bash-completion \
               firefox-i18n-it firefox-ublock-origin \
               pluma \
               gnome-icon-theme kaffeine kio-extras kio kded \
               evince \
               libreoffice-fresh-it \
               vlc libdvdcss nvidia-utils pulseaudio \
               k3b dvd+rw-tools kinit kparts \
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
               xf86-video-fbdev xf86-video-vmware xf86-video-vesa  \
               acpid \
               system-config-printer cups \
               alsa-utils xterm \
               gimp \
               git \
               xorg-xkill \
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
        gnome-system-tools

#
# Show keyboard geometry/model. https://superuser.com/q/1293956
#
#	e.g.: setxkbmap -model pc104 -layout it -option terminate:ctrl_alt_bksp -print | xkbcomp - - | xkbprint - - | ps2pdf - > pc104_it.pdf
#
yay -S xorg-xkbprint

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
#localectl set-x11-keymap \
#	it \
#	pc105 \
#	"" \
#	terminate:ctrl_alt_bksp

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

sudo reboot now

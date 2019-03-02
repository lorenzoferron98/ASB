#!/bin/sh

set -e

sudo pacman -Syu

sudo pacman -S bash-completion firefox-i18n-it pluma evince libreoffice-fresh-it vlc k3b gpicview thunderbird-i18n-it galculator-gtk2 virtualbox flashplugin wicd-gtk xdg-utils xdg-user-dirs-gtk ntfs-3g gparted autorandr lxrandr pcmanfm screenfetch nano wpa_supplicant libdvdcss dvd+rw-tools lxdm xarchiver zip unzip unrar tar gzip xz dosfstools htop mtools laptop-detect lxappearance-obconf lxterminal menu-cache lxmenu-data lxpanel lxhotkey lxinput lxsession xf86-video-fbdev xf86-video-vmware xf86-video-vesa acpid firefox-ublock-origin alsa-utils xterm gtk-engine-murrine gnome-themes-extra nvidia-utils python2-notify gvfs libnotify faenza-icon-theme system-config-printer gimp git lxde-common notify-osd cups kinit kparts parcellite linux-headers gvfs-afc usbmuxd ntp

sudo pacman -S --needed base-devel
sudo nano /etc/makepkg.conf

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ..

yay

yay jre8
yay -S jdownloader2
yay -S osx-arc-shadow
yay -S capitaine-cursors
yay -S lxkb_config-git
yay virtualbox-ext-oracle
yay ttf-ms-fonts

#
# Show keyboard geometry/model. https://superuser.com/q/1293956
#
#	e.g.: setxkbmap -model pc104 -layout it -option terminate:ctrl_alt_bksp -print | xkbcomp - - | xkbprint - - | ps2pdf - > pc104_it.pdf
#
yay -S xorg-xkbprint

# www.pool.ntp.it
sudo timedatectl set-timezone Europe/Rome

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


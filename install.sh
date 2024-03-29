#!/bin/bash
#
if sudo pacman -Qs yay > /dev/null ; then
    echo ":: yay is already installed!"
else
    echo ":: yay is not installed. Starting the installation!"
    _installPackagesPacman "base-devel"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    echo $temp_path
    git clone https://aur.archlinux.org/yay-git.git ~/yay-git
    cd ~/yay-git
    makepkg -si
    cd $temp_path
    echo ":: yay has been installed successfully."
fi
echo ""

sudo pacman -S --noconfirm rsync gum figlet python

echo "Install sddm"
yay -S --noconfirm sddm sddm-sugar-candy-git --ask 4

if [ -f /etc/systemd/system/display-manager.service ]; then
    sudo rm /etc/systemd/system/display-manager.service
fi
sudo systemctl enable sddm.service

if [ ! -d /etc/sddm.conf.d/ ]; then
    sudo mkdir /etc/sddm.conf.d
    echo "Folder /etc/sddm.conf.d created."
fi

sudo cp sddm/sddm.conf /etc/sddm.conf.d/
echo "File /etc/sddm.conf.d/sddm.conf updated."

if [ -f /usr/share/sddm/themes/sugar-candy/theme.conf ]; then

    # Cache file for holding the current wallpaper
    sudo cp wallpapers/default.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/current_wallpaper.jpg
    echo "Default wallpaper copied into /usr/share/sddm/themes/sugar-candy/Backgrounds/"

    sudo cp sddm/theme.conf /usr/share/sddm/themes/sugar-candy/
    sudo sed -i 's/CURRENTWALLPAPER/'"current_wallpaper.jpg"'/' /usr/share/sddm/themes/sugar-candy/theme.conf
    echo "File theme.conf updated in /usr/share/sddm/themes/sugar-candy/"
fi

# Remove existing symbolic links
gtk_symlink=0
gtk_overwrite=1
if [ -L ~/.config/gtk-3.0 ]; then
  rm ~/.config/gtk-3.0
  gtk_symlink=1
fi

if [ -L ~/.config/gtk-4.0 ]; then
  rm ~/.config/gtk-4.0
  gtk_symlink=1
fi

if [ -L ~/.gtkrc-2.0 ]; then
  rm ~/.gtkrc-2.0
  gtk_symlink=1
fi

if [ -L ~/.Xresources ]; then
  rm ~/.Xresources
  gtk_symlink=1
fi

if [ "$gtk_symlink" == "1" ] ;then
  echo ":: Existing symbolic links to GTK configurations removed"
fi

if [ -d ~/.config/gtk-3.0 ] ;then
  echo "The script has detected an existing GTK configuration."
  if gum confirm "Do you want to overwrite your configuration?" ;then
    gtk_overwrite=1
  else
    gtk_overwrite=0
  fi
fi

if [ "$gtk_overwrite" == "1" ] ;then
  cp -r xdg_config/gtk/gtk-3.0 ~/.config/
  cp -r xdg_config/gtk/gtk-4.0 ~/.config/
  cp -r xdg_config/gtk/xsettingsd ~/.config/
  cp xdg_config/gtk/.gtkrc-2.0 ~/
  cp xdg_config/gtk/.Xresources ~/
  echo ":: GTK Theme installed"
fi

if [ ! -f ~/.cache/wal/colors-hyprland.conf ]; then
    _installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config
    wal -i ~/dotfiles/wallpapers/default.jpg
    echo "Pywal and templates activated."
    echo ""
else
    echo "Pywal already activated."
    echo ""
fi

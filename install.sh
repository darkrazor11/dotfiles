#!/bin/bash

set -e 

echo "Welcome!" && sleep 2

echo "Starting with the system update and adding the required repo"
sudo add-apt-repository ppa:aslatter/ppa
sudo apt update -y && sudo apt upgrade -y

echo "Done..!!!"

echo "Starting the setup of applications"

sudo apt install build-essential wget git meson cmake pkgconf libev-dev

sudo apt install -y rofi feh xorg xinit xinput xmonad

mkdir -p ~/.local/share/fonts

cp -r ./fonts/* ~/.local/share/fonts/
fc-cache -f
clear

sudo apt install -y acpi alacritty wmctrl playerctl dunst libghc-xmonad-contrib-doc jq xclip maim xautolock xscreensaver imagemagick

sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip && chmod 777 greenclip && sudo cp greenclip /bin/

wget https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip -O candy.zip && unzip candy.zip && sudo mv -v candy-icons-master candy-icons && sudo cp -r candy-icons /usr/share/icons/

if ! [ -f /usr/lib/libasan.so.6 ]; then
    sudo ln -s /usr/lib/libasan.so.8 /usr/lib/libasan.so.6
fi

# Installing the configs

mkdir -p ~/.config/

    # Rofi configs

    if [ -d ~/.config/rofi ]; then
        echo "Rofi configs detected, backing up..."
        mkdir ~/.config/rofi.old && mv ~/.config/rofi/* ~/.config/rofi.old/
        cp -r ./config/rofi/* ~/.config/rofi;
    else
        echo "Installing rofi configs..."
        mkdir ~/.config/rofi && cp -r ./config/rofi/* ~/.config/rofi;
    fi

    # Alacrity configs

    if [ -f ~/.config/alacritty.yml ]; then
        echo "Alacritty configs detected, backing up..."
        cp ~/.config/alacritty.yml ~/.config/alacritty.yml.old;
        cp ./config/alacritty.yml ~/.config/alacritty.yml;
    else
        echo "Installing alacritty configs..."
         cp ./config/alacritty.yml ~/.config/alacritty.yml;
    fi

    # Dunst config

    if [ -d ~/.config/dunst ]; then
        echo "Dunst configs detected, backing up..."
        mkdir ~/.config/dunst.old && mv ~/.config/dunst/* ~/.config/dunst.old/
        cp -r ./config/dunst/* ~/.config/dunst;
    else
        echo "Installing dunst configs..."
        mkdir ~/.config/dunst && cp -r ./config/dunst/* ~/.config/dunst;
    fi

    # Tint2 config

    if [ -d ~/.config/tint2 ]; then
        echo "Tint2 configs detected, backing up..."
        mkdir ~/.config/tint2.old && mv ~/.config/tint2/* ~/.config/tint2.old/
        cp -r ./config/tint2/* ~/.config/tint2;
    else
        echo "Installing tint2 configs..."
        mkdir ~/.config/tint2 && cp -r ./config/tint2/* ~/.config/tint2;
    fi

    # Xmonad config

    if [ -d ~/.xmonad ]; then
        echo "XMonad configs detected, backing up..."
        mkdir ~/.xmonad.old && mv ~/.xmonad/* ~/.xmonad.old/
        cp -r ./xmonad/* ~/.xmonad/;
    else
        echo "Installing xmonad configs..."
        mkdir ~/.xmonad && cp -r ./xmonad/* ~/.xmonad;
    fi

    # bin files

    if [ -d ~/bin ]; then
        echo "~/bin detected, backing up..."
        mkdir ~/bin.old && mv ~/bin/* ~/bin.old/
        cp -r ./bin/* ~/bin;
	clear
    else
        echo "Installing bin scripts..."
        mkdir ~/bin && cp -r ./bin/* ~/bin/;
	clear
        SHELLNAME=$(echo $SHELL | grep -o '[^/]*$')
        case $SHELLNAME in
            bash)
                if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
                    echo "Looks like $HOME/bin is not on your PATH, adding it now."
                    echo "export PATH=\$PATH:\$HOME/bin" >> $HOME/.bashrc
                else
                    echo "$HOME/bin is already in your PATH. Proceeding."
                fi
                ;;

            zsh)
                if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
                    echo "Looks like $HOME/bin is not on your PATH, adding it now."
                    echo "export PATH=\$PATH:\$HOME/bin" >> $HOME/.zshrc
                else
                    echo "$HOME/bin is already in your PATH. Proceeding."
                fi
                ;;

            fish)
                echo "I see you use fish. shahab96 likes your choice."
                fish -c fish_add_path -P $HOME/bin
                ;;

            *)
                echo "Please add: export PATH='\$PATH:$HOME/bin' to your .bashrc or whatever shell you use."
                echo "If you know how to add stuff to shells other than bash, zsh and fish please help out here!"
        esac
    fi

    # setting Aliases

    if [ -f ~/.bash_aliases ]; then
        echo "Aliases detected, backing up..."
        mv ~/.bash_aliases ~/.bash_aliases.old
        cp -r ./bash_aliases ~/.bash_aliases;
    else
        echo "Installing aliases..."
        cp -r ./bash_aliases ~/.bash_aliases;
    fi

    # setting uncrustify

    if [ -f ~/uncrustify.cfg ]; then
        echo "Uncrustify detected, backing up..."
        mv ~/uncrustify.cfg ~/uncrustify.cfg.old
        cp -r ./uncrustify.cfg ~/uncrustify.cfg;
    else
        echo "Installing Uncrustify..."
        cp -r ./uncrustify.cfg ~/uncrustify.cfg;
    fi
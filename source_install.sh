#!/bin/bash

set -e

echo "Installing Paru..."

if command -v paru >/dev/null 2>&1; then
    echo "Paru already installed, skipping..."
else
    echo "Cloning paru..."
    git clone https://aur.archlinux.org/paru.git
    cd paru

    echo "Installing paru..."
    makepkg -si

    echo "Cleanup..."
    cd .. && rm -rf paru
fi

echo "Cloning powerlevel10k zsh theme..."

rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo "Cloning zsh-nvm..."

rm -rf ~/.zsh-nvm
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm

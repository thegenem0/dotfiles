#!/bin/bash

set -e

echo "Installing Paru..."

git clone https://aur.archlinux.org/paru.git
cd paru

makepkg -si

cd .. && rm -rf paru

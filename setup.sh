#!/usr/bin/env bash

cd $HOME
apt install zsh -y
curl -fsSL https://raw.githubusercontent.com/Nooodles/public_config/refs/heads/main/.zshrc

apt install git fzf curl unzip -y
curl -s https://ohmyposh.dev/install.sh | bash -s
curl -fsSL https://raw.githubusercontent.com/Nooodles/public_config/refs/heads/main/theme.omp.json
mkdir -p ~/.config/ohmyposh/
mv theme.omp.json ~/.config/ohmyposh/

source .zshrc

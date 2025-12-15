#!/usr/bin/env bash

cd $HOME
apt install zsh -y
wget https://raw.githubusercontent.com/Nooodles/public_config/refs/heads/main/.zshrc

apt install git fzf curl unzip vim -y
curl -s https://ohmyposh.dev/install.sh | bash -s
wget https://raw.githubusercontent.com/Nooodles/public_config/refs/heads/main/theme.omp.json
mkdir -p ~/.config/ohmyposh/
mv theme.omp.json ~/.config/ohmyposh/

usermod -s /bin/zsh root
zsh

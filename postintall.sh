#!/bin/bash
echo "Updating system."
sudo apt update -y
sudo apt upgrade -y
echo "Updating done!"

echo "Setting custom bash configurations."
echo "
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*.conf; do
        if [ -f \"\$rc\" ]; then
            . \"\$rc\"
        fi
    done
fi" >> ~/.bashrc
mkdir -p ~/.bashrc.d
echo "alias ll='ls -lh'" > ~/.bashrc.d/ll.conf 
echo "Settings environment set!"

echo "Installing Docker dependencies."
sudo apt install -y ca-certificates curl wget
curl -fsSL https://get.docker.com/ -o get-docker.sh
sudo sh ./get-docker.sh

getent group docker || sudo groupadd docker

sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
echo "Docker dependencies done!"

echo "Install Google Chrome"
wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y ./chrome.deb
echo "Google Chrome installed!"

echo "Installing VS Code."
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb
echo "VS Code installed!"

echo "Installing Dbeaver."
wget -O dbeaver.deb 'https://dbeaver.io/files/dbeaver-ce-latest-linux-x86_64.deb'
sudo apt install -y ./dbeaver.deb
echo "Dbeaver installed!"

echo "Installing nvm"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
echo "nvm installed!"

echo "System will restart in 20 secs"
echo "Press \"ctrl+c\" to abort."
sleep 20

gnome-session-quit --logout --force --no-prompt

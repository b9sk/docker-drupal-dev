#!/usr/bin/env bash
sudo apt-get update -yqqq;

sudo apt-get install -yqqq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;

sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable";
   
sudo apt-get update;

sudo apt-get install -yqqq docker-ce docker-ce-cli containerd.io;

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;


if [[ $HOME != '/root' ]]; then
  sudo usermod -a -G docker $USER;
fi

sudo reboot;

#!/usr/bin/env bash

cd ~/

echo "##### Update and Install awscli #####"
sudo yum update -y && pip install --upgrade --user awscli pip

echo "##### Configure region to US-WEST-2"
aws configure set region us-west-2

echo "##### Install libunwind #####"
sudo yum -y install libunwind

echo "##### Download dotnet-install #####"
curl -O https://dot.net/v1/dotnet-install.sh

echo "##### Install dotnet #####"
sudo chmod u=rx dotnet-install.sh
./dotnet-install.sh -c Current

echo "##### Insert dotnet path into bashrc #####"
sed -i "s|export PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin|export PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin:\$HOME/.dotnet|g" ~/.bashrc

echo "##### Download and install docker #####"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "##### Install jq #####"
sudo yum -y install jq

echo "##### Cleanup docker images #####"
docker rmi $(docker images -q)




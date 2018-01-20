#!/bin/bash

################################################
# SCRIPT TO INSTALL DOCKER IN UBUNTU MACHINES  #
# Usage: bash install_docker.sh <version>      #
# For ubuntu Version: 17.12.0~ce-0~ubuntu      #
################################################

VERSION=$1

install_docker_ubuntu()
{
	#update the apt package index
	sudo apt-get update
	#Dependnecy packages packages to install docker
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
	#Add docker official GPG key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	#Download docker repository
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	#Update the apt package index
	sudo apt-get update
	#Install docker 
	sudo apt-get install docker-ce=$VERSION -y 
	#Add user to the docker group
	sudo usermod -aG docker $USER
}


init_setup()
{
        if [ `uname` == "Linux" ]
        then
        sudo docker version 2> /dev/null
                if [ $? == '0' ]
                then
                        echo "Docker already installed!"
                else
			install_docker_ubuntu
		fi
	fi
	if [ `uname` == "Darwin" ]
        then
        sudo docker version 2> /dev/null
                if [ $? == '0' ]
                then
                        echo "Docker already installed!"
                else
                        install_docker_mac
                fi
        fi
}

init_setup


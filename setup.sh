#!/bin/bash

#store Current Dir

CWD=$(pwd)

#install build dependencies
sudo apt-get install texinfo gawk chrpath \ 
	build-essential unzip wget gitk -y 

#make build-directory
mkdir build-directory

cd build-directory
#clone yocto and enter directory
git clone https://github.com/altenstef/poky.git yocto
cd yocto

#checkout correct branch
git checkout origin/playground-branch -b playground-branch

#checkout alten-playground layer (Master is OK).
git clone https://github.com/altenstef/meta-alten-playground.git

#Create build dir and copy the local configuration and bblayers configuration there
mkdir build/conf -p
cp ${CWD}/local.conf build/conf/
cp ${CWD}/bblayers.conf build/conf/

cd ${CWD}
echo -e "\
---------------------------------------- \n
Now you can execute the following commands: \n\n\
cd build-directory/yocto; \n\
source oe-init-build-env; \n\
bitbake playground-image; \n\
---------------------------------------\
"

#!/bin/bash
if [ -d /opt/build-directory/yocto/build ]; then
    echo "Build directory already exists, skipping installation"
else
    cd /opt/build-directory/
    git clone --branch zeus-22.0.1 https://github.com/altenstef/poky.git yocto

    #checkout correct branch
    cd /opt/build-directory/yocto
    git checkout -b zeus-altenplayground

    #checkout alten-playground layer revision.
    git clone https://github.com/altenstef/meta-alten-playground.git /opt/build-directory/yocto/meta-alten-playground
    git checkout f710d021c441ce5c890d509f521e8d094e3e61cb -b zeus-altenplayground

    #clone raspberry-pi layer and checkout specific revision
    git clone git://git.yoctoproject.org/meta-raspberrypi /opt/build-directory/yocto/meta-raspberrypi
    cd /opt/build-directory/yocto/meta-raspberrypi
    git checkout d17588fe8673b794b589335a753f4c1c90e12f88 -b zeus-altenplayground

    #Create build dir and copy the local configuration and bblayers configuration there
    mkdir -p /opt/build-directory/yocto/build/conf
    cp /opt/install/local.conf /opt/build-directory/yocto/build/conf -v
    cp /opt/install/bblayers.conf /opt/build-directory/yocto/build/conf -v
    cp /opt/install/conf-notes.txt /opt/build-directory/yocto/meta-poky/conf/conf-notes.txt -v
fi
echo "Startup completed... keep waiting for entering via: [docker-compose exec playground bash]"
#keep hanging here, to enter use bash via docker
tail -f /dev/null

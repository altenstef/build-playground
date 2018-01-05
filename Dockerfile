FROM ubuntu:xenial
#no questions from apt / dpkg
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8

#user and group id; change if yours is different!
ARG USER_ID=1000
ARG GROUP_ID=1000

#install required tools, update locale
RUN apt-get update && apt-get install -y texinfo gawk chrpath diffstat cpio vim \ 
	build-essential unzip wget gitk python python3 locales sudo iptables && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

#create Welcome message
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/issue && cat /etc/motd && cd /opt/build-directory/yocto' \
    >> /etc/bash.bashrc \
    ; echo "\
===================================================================\n\
= Alten Playground Yocto Docker Container                         =\n\
===================================================================\n\
\n\
(c) Stef Boerrigter - Alten (2020)\n\
\n\
Execute:   \n\
$ source oe-init-build-env \n\
$ bitbake playground-image \n"\
    > /etc/motd

#create directories & user
RUN mkdir -p /opt/build-directory/yocto && \
    mkdir -p /opt/install && \
    groupadd -r --gid $GROUP_ID alten && \
    useradd -r -u $USER_ID -g alten alten && \
    chown -R alten:alten /opt/build-directory/ && \
    chown -R alten:alten /opt/install && \
    echo "alten:alten" | chpasswd && adduser alten sudo

#Use this user
USER alten

WORKDIR /opt/build-directory/

COPY --chown=alten:alten local.conf /opt/install/
COPY --chown=alten:alten bblayers.conf /opt/install/
COPY --chown=alten:alten initialize.sh /opt/install/
COPY --chown=alten:alten conf-notes.txt /opt/install/

#make entry point script executable
RUN chmod +x /opt/install/initialize.sh

VOLUME /opt/build-directory/

#dirty entry to keep hanging to allow interactive access to this docker.
ENTRYPOINT ["/opt/install/initialize.sh"]

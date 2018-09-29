#!/bin/bash 
set -ex 

export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure debconf -f noninteractive -p critical

###############
## Instala Java
###############

add-apt-repository ppa:webupd8team/java
apt-get install oracle-java8-installer -y
ENV JAVA_HOME "/usr/bin/java"
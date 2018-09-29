#!/bin/bash 
set -ex 

export DEBIAN_FRONTEND=noninteractive

###############
## Instala Java
###############
apt-get install openjdk-8-jdk -y
export JAVA_HOME="/usr/bin/java"
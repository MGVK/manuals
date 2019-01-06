#!/bin/bash

#if add-apt-repository not installed:
#sudo apt install software-properties-common

#for raspbian
#sudo apt install oracle-java8-jdk

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer


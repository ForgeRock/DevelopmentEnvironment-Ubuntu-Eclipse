#!/bin/bash

echo "homeDir is $HOME"
tmpDir=$HOME/tmp/svninstall
echo "tmpDir is $tmpDir"
mkdir -p $tmpDir

cp /etc/apt/sources.list $tmpDir 

cat $tmpDir/sources.list | sed '$a\deb http://extras.ubuntu.com/ubuntu precise main' > $tmpDir/sources1.list
cat $tmpDir/sources1.list | sed '$a\deb http://de.archive.ubuntu.com/ubuntu/ precise main universe restricted multiverse' > $tmpDir/sources2.list

sudo cp $tmpDir/sources2.list /etc/apt/sources.list
sudo apt-get remove subversion libsvn1
sudo apt-get update 
sudo apt-get install -y subversion libsvn1 libsvn-java

echo subversion hold | sudo dpkg --set-selections
echo libsvn1 hold | sudo dpkg --set-selections
echo libserf1 hold | sudo dpkg --set-selections
echo libsvn-java hold | sudo dpkg --set-selections

sudo cp $tmpDir/sources.list /etc/apt/sources.list

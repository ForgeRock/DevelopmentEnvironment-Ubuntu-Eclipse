#!/bin/bash

echo "homeDir is $HOME"
tmpDir=$HOME/tmp/svninstall
echo "tmpDir is $tmpDir"
mkdir -p $tmpDir

cp /etc/apt/sources.list $tmpDir 

cat $tmpDir/sources.list | sed '$a\deb http://extras.ubuntu.com/ubuntu saucy main' > $tmpDir/sources1.list
cat $tmpDir/sources1.list | sed '$a\deb http://de.archive.ubuntu.com/ubuntu/ saucy main universe restricted multiverse' > $tmpDir/sources2.list

sudo cp $tmpDir/sources2.list /etc/apt/sources.list
sudo apt-get remove subversion libsvn1
sudo apt-get update 
sudo apt-get install subversion=1.7.9-1+nmu6ubuntu3 libsvn1=1.7.9-1+nmu6ubuntu3 libsvn-java=1.7.9-1+nmu6ubuntu3

echo subversion hold | sudo dpkg --set-selections
echo libsvn1 hold | sudo dpkg --set-selections
echo libserf1 hold | sudo dpkg --set-selections
echo libsvn-java hold | sudo dpkg --set-selections

sudo cp $tmpDir/sources.list /etc/apt/sources.list

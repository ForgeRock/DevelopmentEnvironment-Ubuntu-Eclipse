#!/bin/bash
sudo -v
scriptDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "scriptDir is $scriptDir"
envfile="forgerock_env.sh"
sudo apt-get -y install vim
sudo apt-get -y install maven
sudo apt-get -y install openjdk-7-jdk


mkdir -p $HOME/tmp/envfile

pushd $HOME/tmp/envfile
rm $envfile
touch $envfile
echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/' >> $envfile
echo 'export M2_HOME=/usr/share/maven' >> $envfile
echo 'export M2=/usr/share/maven/bin' >> $envfile
echo "export MAVEN_OPTS='-Xmx2g -Xms2g -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512m'" >> $envfile
sudo cp $envfile /etc/profile.d

cd $scriptDir
rm -rf $HOME/tmp

source installSVN1.7onUbuntu14-04.sh 
source installEclipseJunoOnUbuntu.sh

# Set the background image, color and ting.
cp $scriptDir/OpenIdentityPlatform.png $HOME/Pictures/
picDir="file://$HOME/Pictures/OpenIdentityPlatform.png"
echo "picDir is $picDir"
gsettings set org.gnome.desktop.background picture-options "centered"
gsettings set org.gnome.desktop.background picture-uri $picDir
gsettings set org.gnome.desktop.background primary-color "#313435"
# Add the eclipse application to the launcher as a favorite (pinned)
gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'eclipse.desktop' *//g" | sed "s/'eclipse.desktop' *, */    /g" | sed -e "s/]$/, 'eclipse.desktop']/")"

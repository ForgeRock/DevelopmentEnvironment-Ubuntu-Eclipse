#!/bin/bash

scriptDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ ! -f $scriptDir/eclipse.desktop ]; then
	echo "eclipse.desktop not found in $1"
        echo "Usage: installEclipseJunoInUbuntu [scriptDir]"
	echo "Where scriptDir is the directory in which the eclipse.desktop file may be found."
        exit 1
fi

# Download eclipse.
origDir=`pwd`
cd $HOME/Downloads

wget 'http://sourceforge.net/projects/eclipse.mirror/files/Eclipse%204.4.2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz'

cd /opt

sudo tar -zxvf $HOME/Downloads/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz

/opt/eclipse/eclipse \
  -application org.eclipse.equinox.p2.director \
  -noSplash \
  -repository \
http://coderplus.com/m2e-update-sites/maven-dependency-plugin,\
http://ianbrandt.github.io/m2e-maven-depenency-plugin/0.0.4/,\
http://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-buildhelper/0.15.0/N/0.15.0.201207090124/,\
http://subclipse.tigris.org/update_1.8.x,\
http://eclipse.tmatesoft.com/svnkit/1.7.x/\
  -installIUs \
org.sonatype.m2e.buildhelper.feature.feature.group,\
com.ianbrandt.tools.m2e.mdp.feature.feature.group,\
org.tigris.subversion.subclipse.feature.group,\
org.tigris.subversion.subclipse.mylyn.feature.group,\
org.tigris.subversion.subclipse.graph.feature.feature.group,\
org.tigris.subversion.clientadapter.feature.feature.group,\
org.tigris.subversion.clientadapter.javahl.feature.feature.group,\
org.tigris.subversion.clientadapter.svnkit.feature.feature.group,\
com.collabnet.subversion.merge.feature.feature.group,\
org.tmatesoft.svnkit.feature.group,\
net.java.dev.jna.feature.group

sudo cp $scriptDir/eclipse.desktop /usr/share/applications/

cd /opt/eclipse
sudo sed -i 's/-XX:MaxPermSize=256m/-XX:MaxPermSize=512m/g' eclipse.ini
sudo sed -i 's/-Xms40m/-Xms1g/g' eclipse.ini
sudo sed -i 's/-Xmx512m/-Xms3g/g' eclipse.ini





cd $origDir

##DevelopmentEnvironment-Ubuntu-Eclipse

This project contains scripts that will configure a fresh instance of Ubuntu 14.04 LTS (Trusty Tahr) Desktop to be a development environment for the ForgeRock Open Identity Platform.

This has been tested on a virtual machine running in VirtualBox on OS X on mac.

###Environment

The scripts will install the following on your ubuntu image;

* Subversion v1.7.9
* maven v3.0.5
* vim 7.4
* openjdk-7-jdk 
* Eclipse (Luna, Java edition, SR2, 64bit for Linux) with the following plugins;
	* m2e connector for buid-helper-maven-plugin 
	* m2e connector for the Maven Dependency Plugin

	
	The following allow eclipse to work with the version of subversion installed earlier (Subversion 1.7.9);
	
	* Subclipse (1.8.22)
	* Subclipse Integration for Mylyn (3.0.0)
	* Subversion Client Adapter (1.8.6)
	* Subversion JavaHL Native Library Adapter (v 1.7.10)
	* SVNKit Library (1.7.13)
	* SVNKit Client Adapter (1.7.9.2)


The following enviroment variables will be set (in /etc/profile.d/forgerock_env.sh);

``` bash
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
M2_HOME=/usr/share/maven
M2=/usr/share/maven/bin
MAVEN_OPTS='-Xmx2g -Xms2g -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512m'"
```

The eclipse application will be added to the launcher favorites for easy launching.

## Usage

Download the latest Ubuntu 14.04 release (SR2 at the time of writing) from here; <http://www.ubuntu.com/download/desktop>

Download and install VirtualBox from here <https://www.virtualbox.org/wiki/Downloads>

Create a VirtualBox Ubuntu machine using the above image. Suggested settings;

```
Base Memory > 4096
Processor(s) > 1 
Video Memory = 128MB
```

In general, the more resources you can allocate to your virtual machine the better performance will be, but your host and guest OS are sharing resources so if you allocate too many resources you may see a slowdown as your host system will suffer. Try to find a good balance.

Start your virtual box. 

Install the VirtualBox Guest Additions (helps you 
resize ubuntu, go fullscreen etc)

###On Your Guest Ubuntu VM
Install Git from the command line `sudo apt-get install git`

Clone this repository to a temporary location.

From the terminal CD into this repository location and run `./setup.sh`





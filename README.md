##DevelopmentEnvironment-Ubuntu-Eclipse

This project contains scripts that will configure a fresh instance of Ubuntu Desktop to be a development environment for the ForgeRock Open Identity Platform.

There are a number of configurations supported;
* setup2016.sh is best run on a Ubuntu 15.10 image.
* setup2015.sh is best run on a 14.04 LTS (Trusty Tahr) image and works with OpenAM 12.
* setup2014.sh is best run on a 14.04 LTS (Trusty Tahr) image and works with OpenAM 11.

This has been tested using Ubuntu images running in VirtualBox on OS X on mac.

###Environment

The scripts will install the following on your ubuntu image;
## setup2016.sh
Use this script to work with the latest git repositories hosted on ForgeRock's Stash server (e.g. OpenAM 13). This script installs the following on your Ubuntu image;

* No Subversion! Yay! 
* Git v2.5.0
* Maven 3.3.3
* openjdk-8-jdk
* vim  7.4
* Eclipse (Mars.1 release (4.5.1), Java EE edition), with the following plugins;
	* m2e connector for buid-helper-maven-plugin 
	* m2e connector for the Maven Dependency Plugin 
	* 
The following enviroment variables will be set (in /etc/profile.d/forgerock_env.sh);

``` bash
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
M2_HOME=/usr/share/maven
M2=/usr/share/maven/bin
MAVEN_OPTS='-Xmx2g -Xms2g -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512m'"
```

## setup2014-15.sh
Use this script to work with older SVN based releases such as OpenAM 11.0.0 and OpenAM 12.0.0. This script installs the following on your Ubuntu image;

* Subversion v1.6.17
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

Download the required ubuntu image from here; <http://www.ubuntu.com/download/desktop>

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

####Get the configuration files from GitHub

On your Ubuntu VM, install Git from the command line `sudo apt-get install git`

Clone this repository to ~/Documents;

```
cd ~/Documents
git clone https://github.com/ForgeRock/DevelopmentEnvironment-Ubuntu-Eclipse.git
```

From the terminal CD into this repository location and run either `./setup.sh` or `./setup2016.sh` depending on the codebase you wish to work with.

```bash
cd ~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse
./setup.sh
```

or

```bash
cd ~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse
./setup2016.sh.sh
```

This will take a while to run, and you will need to provide your password to sudo at some point. When it's all done you will have maven, subversion and eclipse all installed, and your enviroment configured. 

There are still a couple of steps required to configure eclipse, and as yet I have not found a suitable way of automating these steps. 

First off, eclipse uses a 'LifeCycle Mapping' paradigm to handle m2eclipse plugins. You can read about that here; <https://www.eclipse.org/m2e/documentation/m2e-execution-not-covered.html>. To stop our eclipse workspace being full of `Plugin execution not covered by lifecycle configuration` errors then we need to configure our Open Identity Platform workspaces to use a lifecycle-mapping-metadata.xml file that defines mappings for the maven plugins used by the projects.

This is best explained by demonstration, so hold tight, here we go;

####Configuring Eclipse to work with OpenAM

Open eclipse by clicking on the eclipse icon in the ubuntu launcher.
Create a new workspace in `~/Documents/openam` 
When eclipse has loaded you can configure the workspace to use the lifecycle mapping file;

1. Open the preferences dialog (from the windows menu)
![Imgur](http://i.imgur.com/0g9949x.png)
2. Navigate to the Maven->Lifecycle Mapping preferences;
![Imgur](http://i.imgur.com/gPN5X3x.png)
3. Change the lifecycle mapping file location. Browse to appropriate mapping file for your setup in the git repository you cloned earlier. Either `~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse/lifecycle-mapping-metadata.xml` or `~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse/lifecycle-mapping-metadata-2016.xml` then click Apply and then OK;
![Imgur](http://i.imgur.com/jfwAdh6.png)

With eclipse now ready, lets get hold of our OpenAM code.

## OpenAM 11 & 12 

From the command line change directory to your local copy of this repository where there are scripts get the openam code. The scripts will do a svn checkout of OpenAM to `~/code/fr/openam`;

The first time you build the OpenAM project, maven will need to download many dependencies and plugins. Personally I prefer to my first build on the command line rather than in eclipse as the visibility of what is happening is enhanced. To do this run the following depending on which release of OpenAM you wish to work with;

**OpenAM 11.0.0**

```
cd ~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse
./get_openam_code_11.0.0.sh
cd ~/code/fr/openam
mvn clean install
```
**OpenAM 12.0.0**

```
cd ~/Documents/DevelopmentEnvironment-Ubuntu-Eclipse
./get_openam_code_12.0.0.sh
cd ~/code/fr/openam
mvn clean install
```


You now have time to get a cuppa, glass of someting etc.. 

####Import OpenAM into Eclipse

1. Right click in the 'Package Explorer' area of the workspace and choose Import;
![Imgur](http://i.imgur.com/TH7662S.png)
2. Choose to Import Existing Maven Projects;
![Imgur](http://i.imgur.com/jJSjNKL.png)
3. Select the root folder of your openam project, which is at `~/code/fr/openam`
4. Click OK and import the project!

There's one more thing to set up. You will notice that there are hundreds of errors on the openam-core project. This is because that project is dependent on generated classes that live in the openam-idsvc-schema and openam-mib-schema projects. Let's tell eclipse about that dependency now;

1. If you didn't build OpenAM from the command line earlier (I admire your rebelious spirit, but you didn't really think you'd get away with it did you?) then do it now. Close eclipse, do the build then re-open your Eclipse workspace and wait for the workspace to finish building. 
2. Open the project properties for the openam-core project.
![Imagur](http://i.imgur.com/KyGE2YQ.png)
3. Add openam-idsvcs-schema and openam-mib-schema projects as Project References.
![Imgur](http://i.imgur.com/yTn9wRE.png)
4. On the project's Java Build Path select the libraries tab and choose Add JARs... Navigate to the openam-idsvcs-schema project's target jar and click OK.
![Imgur](http://i.imgur.com/hxgAwHl.png)
5. Do the same for the openam-mib-schema project's target jar. Then click OK. The project workspace will build and **Hey Presto** you have a working environment! 
![Imgur](http://i.imgur.com/t6qFI7A.png)

##Development

If you'd like to contribute to this project please feel free to fork it, improve it an submit a pull request. 

###Some further development suggestions
It would be great to create a fork that configured the environment to use the community version of intelliJ Idea.

Some scripts and instructions for getting started with OpenIDM, OpenDJ and OpenIG would be great.










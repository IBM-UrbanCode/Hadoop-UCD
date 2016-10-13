# IBM UrbanCode Deploy Hadoop Plug-in [![Build Status](https://travis-ci.org/IBM-UrbanCode/Hadoop-UCD.svg?branch=master)](https://travis-ci.org/IBM-UrbanCode/Hadoop-UCD)
---
Note: This is not the plug-in distributable! The full plug-in can be found under the releases tab.

### License
This plug-in is protected under the [Eclipse Public 1.0 License](http://www.eclipse.org/legal/epl-v10.html)

### Compatibility
	This plug-in requires version 6.1.1 or later of IBM UrbanCode Deploy.

### Installation
	No special steps are required for installation.
	See Installing plug-ins in IBM UrbanCode Deploy. Download this zip file if you wish to skip the
	manual build step. Otherwise, download the entire Hadoop-UCD and
	run the "ant" command in the top level folder. This should compile the code and create
	a new distributable zip within the releases folder. Use this command if you wish to make
	your own changes to the plugin.

### History
    Version 2
        Community GitHub Release

### Steps  
    - Create Directory: Creates Directory in DFS
    - Copy Inputs: Copy inputs into DFS
    - Run Jar: Runs Jar file on Hadoop

### Build

    ant

### How to build the plug-in from eclipse client:

1. Expand the Groovy project that you checked-out from example template.
2. Open build.xml file and execute it as an Ant Build operation (Run As -> Ant Build)
3. The built plug-in is located at releases/Hadoop-UCD-vdev.zip

### How to build the plug-in from command line:

1. Navigate to the base folder of the project through command line.
2. Make sure that there is build.xml file there, and then execute 'ant' command.
3. The built plug-in is located at releases/Hadoop-UCD-vdev.zip

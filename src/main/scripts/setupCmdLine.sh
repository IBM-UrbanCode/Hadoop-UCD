#!/bin/sh 
###
#	© Copyright IBM Corporation 2014.  
#	@PLUGIN_NAME@
#	
#   This is licensed under the following license.
#   The Eclipse Public 1.0 License (http://www.eclipse.org/legal/epl-v10.html)
#   U.S. Government Users Restricted Rights:  Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
#	
#	Filename: setupCmdLine.sh
#	
#	
###


bitWidthOverrideDir=""
# determine the operating system to JAVA_HOME correctly
 UNAME=`/bin/uname | sed -e 's/\(CYGWIN\).*/\1/'`
 case $UNAME in
  AIX)
  OS=aix
        OS_TYPE_TEST=`getconf -a | grep KERN | grep 64`
        if [ "${OS_TYPE_TEST}" != "" ]; then
                OS_DIR=aix/PPC64
                bitWidthOverrideDir=aix/PPC32 
        else
                OS_DIR=aix/PPC32
        fi
  EXTSHM=ON
      export EXTSHM 
  ;;
  Linux)
  OS=linux
        OS_TYPE_TEST=`uname -a | grep ia64`
        if [ "${OS_TYPE_TEST}" != "" ]; then
                OS_TYPE_TEST=`${SSH_CALL} uname -a | grep x86_64`
		else
			OS_TYPE_TEST=`uname -a | grep x86_64`
        fi

        OS_TYPE_TEST_390=`uname -a | grep s390`
        if [ "${OS_TYPE_TEST_390}" != "" ]; then        	
    		OS_TYPE_TEST=$OS_TYPE_TEST_390
			if [ "${OS_TYPE_TEST_390}" != "" ]; then
				OS_DIR=linux/s390_64
				bitWidthOverrideDir=linux/s390
				DONE=true
			else
				OS_DIR=linux/s390
				DONE=true
			fi
  		fi	
		
		if [ "${DONE}" == "" ]; then
    	    if [ "${OS_TYPE_TEST}" != "" ]; then
        	        OS_DIR=linux/X64
            	    bitWidthOverrideDir=linux/X32
        	else
            	    OS_DIR=linux/X32
        	fi
        fi
  ;;
  SunOS)
  OS=solaris
  		#TODO need a check for Solaris X64!
  		#32 bit override not supported on AMD/Intel
        OS_TYPE_TEST=`isainfo -v | grep 64`
        if [ "${OS_TYPE_TEST}" != "" ]; then
               OS_TYPE_TEST=`isainfo -v | grep amd64`
               if [ "${OS_TYPE_TEST}" != "" ]; then
                       OS_DIR=solaris/X64
               else
                       OS_DIR=solaris/Sparc64
                       bitWidthOverrideDir=solaris/Sparc               
               fi
        else
                OS_DIR=solaris/Sparc
        fi
  ;;
  HP-UX)
        OS=hpux
        OS_TYPE_TEST=`uname -a | grep ia64`
        if [ "${OS_TYPE_TEST}" != "" ]; then
                OS_DIR=hpux/IA64
                #32 bit override not supported on HP-UX
        else
                OS_DIR=hpux/PaRISC
        fi
        ;;
  OS400)
        OS=os400
        OS_TYPE=64bit
        PLATFORM=iSeries
        ;;
esac

CLASSPATH=""
for jar in ${PLUGIN_HOME}/java/*.jar; do
	CLASSPATH=${CLASSPATH}:${jar};
done

echo $CLASSPATH
PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH PATH OS JAVA_HOME


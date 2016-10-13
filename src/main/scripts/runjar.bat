@echo off
@REM ###
@REM	© Copyright IBM Corporation 2014.  
@REM	@PLUGIN_NAME@
@REM	
@REM    This is licensed under the following license.
@REM    The Eclipse Public 1.0 License (http://www.eclipse.org/legal/epl-v10.html)
@REM    U.S. Government Users Restricted Rights:  Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM	
@REM	Filename: runjar.bat
@REM	
@REM
@REM ###
setlocal ENABLEDELAYEDEXPANSION


REM source the shared lib for JAVA_HOME and CLASSPATH variables
call "%~dp0setupCmdLine.bat"

set HADOOP=%1
set COMMAND=%2
set JAR_NAME=%3
set JAR_PARAMETERS=%4

if exist "%JAVA_HOME%\bin\java.exe" goto RUN_COMMAND
goto PRINT_ERROR

:PRINT_ERROR
echo HadoopPlugin does not have a correctly installed version of Java. Please review the installation instructions to ensure the product has been installed and configured correctly.
goto END


:RUN_COMMAND
call java.exe "-Dfile.encoding=UTF8" com.ibm.rational.deploy.Hadoop.ParseParameters "%HADOOP%" "%COMMAND%" "%JAR_NAME%" "%JAR_PARAMETERS%"
goto END

:END
endlocal & exit /b %ERRORLEVEL%

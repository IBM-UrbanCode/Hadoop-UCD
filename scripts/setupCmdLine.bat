@echo off
@REM ###
@REM	© Copyright IBM Corporation 2014.  
@REM	@PLUGIN_NAME@
@REM	
@REM    This is licensed under the following license.
@REM    The Eclipse Public 1.0 License (http://www.eclipse.org/legal/epl-v10.html)
@REM    U.S. Government Users Restricted Rights:  Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM	
@REM	Filename: setupCmdLine.bat
@REM	
@REM
@REM ###

SET BIT_OVERRIDE_DIR=""

if "%PROCESSOR_ARCHITECTURE%" == "x86" (
	if "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
		SET PLATFORM=X64
		SET BIT_OVERRIDE_DIR=X32
	) else (
		SET PLATFORM=X32
	)
) else (
	SET PLATFORM=X64
	SET BIT_OVERRIDE_DIR=X32
) 


SET CLASSPATH=

for %%J in ("%PLUGIN_HOME%\java\*.jar") do (
	SET CLASSPATH=!CLASSPATH!;%%J
)

SET PATH=%JAVA_HOME%\bin;%PATH%
SET OS=windows

REM java -version 2>&1 | findstr 1\.6 | findstr IBM > nul
REM if %errorlevel% NEQ 0 (
REM echo    WARNING: About to run with a non-IBM 1.6 JRE, results will be unpredictable
REM )
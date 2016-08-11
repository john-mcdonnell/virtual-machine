#!/bin/sh

setScriptFilename() {
	SCRIPT_FILE=`basename $0`
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		echo "ERR: $RESULT: Error encountered while determining the name of the current script."
		return $RESULT;
	fi

	#echo SCRIPT_FILE:$SCRIPT_FILE.

	return 0
}

setScriptFolderName() {
	SCRIPT_FOLDER=`dirname $0`;
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		echo "ERR: $RESULT: Error encountered while determining the name of the folder containing the current script."
		return $RESULT;
	fi
	
	if [ "$SCRIPT_FOLDER" = "" ] || [ "$SCRIPT_FOLDER" = "." ] || [ -z "$SCRIPT_FOLDER" ]; then
		SCRIPT_FOLDER=`pwd`
	fi
	
	#echo SCRIPT_FOLDER:$SCRIPT_FOLDER.
	
	return 0
}

initialiseEnvironment() {	
	setScriptFilename
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		return $RESULT
	fi
	
	setScriptFolderName
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		return $RESULT
	fi
	
	return 0
}

main() {
	initialiseEnvironment
	RESULT=$?
	if [ $RESULT -ne 0 ]; then
		return $RESULT
	fi
	
	return 0
}

main
RESULT=$?
if [ $RESULT -ne 0 ]; then
	return $RESULT
fi

ENVIRONMENT_VARIABLE_NAME=$1
ENVIRONMENT_VARIABLE_VALUE=$2
ENVIRONMENT_VALIABLE_SYSTEM_WIDE_FILENAME=/etc/environment

#echo ENVIRONMENT_VARIABLE_NAME:$ENVIRONMENT_VARIABLE_NAME.
#echo ENVIRONMENT_VARIABLE_VALUE:$ENVIRONMENT_VARIABLE_VALUE.
#echo ENVIRONMENT_VALIABLE_SYSTEM_WIDE_FILENAME:$ENVIRONMENT_VALIABLE_SYSTEM_WIDE_FILENAME.

echo "Creating the $ENVIRONMENT_VARIABLE_NAME environment variable in the file \"$ENVIRONMENT_VARIABLE_VALUE\"..."
sudo sh -c "echo $ENVIRONMENT_VARIABLE_NAME=$ENVIRONMENT_VARIABLE_VALUE >> \"$ENVIRONMENT_VALIABLE_SYSTEM_WIDE_FILENAME\""
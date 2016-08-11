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


SOFTWARE_NAME=$1
INSTALL_FOLDER=$2
REPOSITORY_SOFTWARE_ARCHIVE=$SCRIPT_FOLDER/repository/$SOFTWARE_NAME/$SOFTWARE_NAME
UTILITY_CREATE_FOLDER=$SCRIPT_FOLDER/create-folder.sh
UTILITY_DELETE_FOLDER=$SCRIPT_FOLDER/delete-folder.sh

#echo SOFTWARE_NAME:$SOFTWARE_NAME.
#echo INSTALL_FOLDER:$INSTALL_FOLDER.
#echo REPOSITORY_SOFTWARE_ARCHIVE:$REPOSITORY_SOFTWARE_ARCHIVE.
#echo UTILITY_CREATE_FOLDER:$UTILITY_CREATE_FOLDER.
#echo UTILITY_DELETE_FOLDER:$UTILITY_DELETE_FOLDER.
#echo UTILITY_UNPACK_FOLDER:$UTILITY_UNPACK_FOLDER.
#echo
#echo
#echo

"$UTILITY_DELETE_FOLDER" "$INSTALL_FOLDER" 
"$UTILITY_CREATE_FOLDER" "$INSTALL_FOLDER"

cd "$INSTALL_FOLDER"
echo "Unpacking the archive \"$REPOSITORY_SOFTWARE_ARCHIVE\" to the installation folder \"$INSTALL_FOLDER\"..."
sudo tar zxf "$REPOSITORY_SOFTWARE_ARCHIVE"
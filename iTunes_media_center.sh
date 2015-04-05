#!/bin/bash

# Arguments:
#	$1: Library's location. Defined underneath
#	$2: Path to local iTunes library
#	$3: Mounting point (optional)
#	$4: Username for remote location
#	$5: Password for remote location
#	$6: IP for remote location

ITUNES_APP_PATH=/Applications/iTunes.app

#Possible locations
LIB_NAS="NAS"
LIB_LOCAL="LOCAL"
LIB_INSTALL="INSTALL"

LIB_LOC=$1
ITUNES_FOLDER_PATH=$2

#Remote storage
MOUNTING_POINT=$3
USERNAME=$4
PASSWORD=$5
NAS_IP=$6
NAS_MEDIA_PATH=$7

if [ "$LIB_LOC" == $LIB_LOCAL ]
then
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_local.itl $ITUNES_FOLDER_PATH/iTunes\ Library.itl
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_local.xml $ITUNES_FOLDER_PATH/iTunes\ Library.xml
	ln -s -f $ITUNES_FOLDER_PATH/itunes_music_library_local.xml $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_extras_local.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_genius_local.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb
	ln -s -f $ITUNES_FOLDER_PATH/sentinel_local $ITUNES_FOLDER_PATH/sentinel

	echo -n "Loaded: Local iTunes Library.";
elif [ "$LIB_LOC" == $LIB_NAS ]
then
	NAS_LIBS=$MOUNTING_POINT/iTunes

	if [ ! -d "$MOUNTING_POINT" ]
	then
		mkdir $MOUNTING_POINT
	fi

	if [ ! -d "$NAS_LIBS" ]
	then
		mount -t afp afp://$USERNAME:$PASSWORD@$NAS_IP/$NAS_MEDIA_PATH $MOUNTING_POINT
	fi

	ln -s -f $NAS_LIBS/itunes_library_nas.itl $ITUNES_FOLDER_PATH/iTunes\ Library.itl
	ln -s -f $NAS_LIBS/itunes_library_nas.xml $ITUNES_FOLDER_PATH/iTunes\ Library.xml
	ln -s -f $NAS_LIBS/itunes_music_library_nas.xml $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml
	ln -s -f $NAS_LIBS/itunes_library_extras_nas.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb
	ln -s -f $NAS_LIBS/itunes_library_genius_nas.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb
	ln -s -f $NAS_LIBS/sentinel_nas $ITUNES_FOLDER_PATH/sentinel
	
	echo -n "Loaded: NAS iTunes Library."
elif [ "$SLIB_LOC" == $LIB_INSTALL]
then
	if [ ! -d "$MOUNTING_POINT" ]
	then
		mkdir $MOUNTING_POINT
	fi

	if [ ! -d "$MOUNTING_POINT/$NAS_MEDIA_PATH" ]
	then
		mount -t afp afp://$USERNAME:$PASSWORD@$NAS_IP/$NAS_MEDIA_PATH $MOUNTING_POINT
		echo -n "Mounted: NAS";
	fi

	mv $ITUNES_FOLDER_PATH/sentinel $ITUNES_FOLDER_PATH/sentinel_local
	mv $ITUNES_FOLDER_PATH/iTunes\ Library.itl $ITUNES_FOLDER_PATH/itunes_library_local.itl
	mv $ITUNES_FOLDER_PATH/iTunes\ Library.xml $ITUNES_FOLDER_PATH/itunes_library_local.xml
	mv $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml $ITUNES_FOLDER_PATH/itunes_music_library_local.xml
	mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb $ITUNES_FOLDER_PATH/itunes_library_extras_local.itdb
	mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb $ITUNES_FOLDER_PATH/itunes_library_genius_local.itdb

	echo -n "Installed: Flexible iTunes Library";
fi

open $ITUNES_APP_PATH

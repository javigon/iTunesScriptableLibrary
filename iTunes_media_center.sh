#!/bin/bash
#
# Copyright (C) Javier González (javier@javigon.com)
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation
#
# Arguments:
#	$1: Action - possibilities underneath
#	$2: Path to local iTunes library
#	$3: Mounting point (optional)
#	$4: Username for remote location
#	$5: Password for remote location
#	$6: IP for remote location
#	$7: Path to media library in remote location
#
# Example use:
# Load library in NAS:
#	./iTunes_media_center.sh NAS ~/Music/iTunes /Volumes/media itunes_user itunes_password 192.168.1.5 media
# Load local library:
#	./iTunes_media_center.sh LOCAL ~/Music/iTunes

ITUNES_APP_PATH=/Applications/iTunes.app

#Actions
LIB_NAS="NAS"
LIB_LOCAL="LOCAL"
LIB_INSTALL="INSTALL"
LIB_LOAD="LOAD"

ACTION=$1
ITUNES_FOLDER_PATH=$2

#Remote storage
MOUNTING_POINT=$3
USERNAME=$4
PASSWORD=$5
NAS_IP=$6
NAS_MEDIA_PATH=$7

if [ "$ACTION" == $LIB_LOCAL ]
then
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_local.itl $ITUNES_FOLDER_PATH/iTunes\ Library.itl
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_local.xml $ITUNES_FOLDER_PATH/iTunes\ Library.xml
	ln -s -f $ITUNES_FOLDER_PATH/itunes_music_library_local.xml $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_extras_local.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb
	ln -s -f $ITUNES_FOLDER_PATH/itunes_library_genius_local.itdb $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb
	ln -s -f $ITUNES_FOLDER_PATH/sentinel_local $ITUNES_FOLDER_PATH/sentinel

	echo -n "Loaded: Local iTunes Library.";
elif [ "$ACTION" == $LIB_NAS ]
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
elif [ "$ACTION" == $LIB_INSTALL ]
then
	mv $ITUNES_FOLDER_PATH/sentinel $ITUNES_FOLDER_PATH/sentinel_local
	mv $ITUNES_FOLDER_PATH/iTunes\ Library.itl $ITUNES_FOLDER_PATH/itunes_library_local.itl
	mv $ITUNES_FOLDER_PATH/iTunes\ Library.xml $ITUNES_FOLDER_PATH/itunes_library_local.xml
	mv $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml $ITUNES_FOLDER_PATH/itunes_music_library_local.xml
	mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb $ITUNES_FOLDER_PATH/itunes_library_extras_local.itdb
	mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb $ITUNES_FOLDER_PATH/itunes_library_genius_local.itdb

	#Enable iTunes to load from symbolic link
	defaults write com.apple.iTunes 'alis:1:iTunes Library Location' ''

	echo -n "Installed: Flexible iTunes Library";
elif [ "$ACTION" == $LIB_LOAD ]
then
	NAS_LIBS=$MOUNTING_POINT/iTunes

	if [ ! -d "$MOUNTING_POINT" ]
	then
		mkdir $MOUNTING_POINT
	fi

	if [ ! -d "$MOUNTING_POINT/$NAS_MEDIA_PATH" ]
	then
		mount -t afp afp://$USERNAME:$PASSWORD@$NAS_IP/$NAS_MEDIA_PATH $MOUNTING_POINT
		echo -n "Mounted: NAS";
	fi

	if [ ! -d "$MOUNTING_POINT/iTunes" ]
	then
		mkdir $NAS_LIBS
	fi

	mv $ITUNES_FOLDER_PATH/ $NAS_LIBS/

fi
open $ITUNES_APP_PATH

#!/bin/bash

ITUNES_LOCAL_FOLDER_PATH=$1

mv $ITUNES_LOCAL_FOLDER_PATH/sentinel $ITUNES_LOCAL_FOLDER_PATH/sentinel_local
mv $ITUNES_LOCAL_FOLDER_PATH/iTunes\ Library.itl $ITUNES_LOCAL_FOLDER_PATH/itunes_library_local.itl
mv $ITUNES_LOCAL_FOLDER_PATH/iTunes\ Library.xml $ITUNES_LOCAL_FOLDER_PATH/itunes_library_local.xml
mv $ITUNES_LOCAL_FOLDER_PATH/iTunes\ Music\ Library.xml $ITUNES_LOCAL_FOLDER_PATH/itunes_music_library_local.xml
mv $ITUNES_LOCAL_FOLDER_PATH/iTunes\ Library\ Extras.itdb $ITUNES_LOCAL_FOLDER_PATH/itunes_library_extras_local.itdb
mv $ITUNES_LOCAL_FOLDER_PATH/iTunes\ Library\ Genius.itdb $ITUNES_LOCAL_FOLDER_PATH/itunes_library_genius_local.itdb

#Enable iTunes to load from symbolic link
defaults write com.apple.iTunes 'alis:1:iTunes Library Location' ''

echo -n "Installed: Flexible iTunes Library";



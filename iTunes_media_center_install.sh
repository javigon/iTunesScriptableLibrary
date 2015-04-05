#!/bin/bash

ITUNES_FOLDER_PATH=$1

mv $ITUNES_FOLDER_PATH/sentinel $ITUNES_FOLDER_PATH/sentinel_local
mv $ITUNES_FOLDER_PATH/iTunes\ Library.itl $ITUNES_FOLDER_PATH/itunes_library_local.itl
mv $ITUNES_FOLDER_PATH/iTunes\ Library.xml $ITUNES_FOLDER_PATH/itunes_library_local.xml
mv $ITUNES_FOLDER_PATH/iTunes\ Music\ Library.xml $ITUNES_FOLDER_PATH/itunes_music_library_local.xml
mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Extras.itdb $ITUNES_FOLDER_PATH/itunes_library_extras_local.itdb
mv $ITUNES_FOLDER_PATH/iTunes\ Library\ Genius.itdb $ITUNES_FOLDER_PATH/itunes_library_genius_local.itdb


echo -n "Installed: Flexible iTunes Library";



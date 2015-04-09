Having separated iTunes libraries for different setups (e.g., media center, local music, remote playlists) is a powerful way to organize your media library and share resources among different devices (e.g., iPhone synchronization), but it can be painful. While it is possible to load a different iTunes library by opening iTunes and pressing "Alt" at the same time, this is not optimal. Ideally, we would write a script to pass iTunes the library it should load at launch time (e.g., open /Applications/iTunes.app --load-library=$LIBRARY_PATH). However, to the best of my knowledge, the iTunes API does not expose this - which I honestly do not understand. Googling for a workaround I could not find a good/complete solution, so I made my own. Here you have the setup and the scripts that implement it.

Full description: http://javigon.com/2015/04/06/loading-itunes-library-from-command-line/

# Example uses:
- Loading NAS iTunes library: 

./iTunes_media_center.sh NAS ~/Music/iTunes /Volumes/media $USERNAME $PASSWORD $NAS_IP $NAS_DIR

- Loading local iTunes library:

./iTunes_media_center.sh LOCAL ~/Music/iTunes

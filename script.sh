#!/bin/bash
## That script search for mp3 with high bitrate (greater than 192) and copy it to another directory
## and keep the original file structure
mp3_path="./music"
copy_path="./toconvert"

while read FILENAME
do

    f=$FILENAME
    path=${f%/*}
    xfile=${f##*/}
    title=${xfile%.*}
    ext=${xfile##*.}
    directory=$(dirname "${FILENAME}")

    bitrate="$(mp3info -r m -p "%r\n" "${FILENAME}")"
    # cut "/home/user/Musique/"" from the full path to not recreate it
    path_to_create=$(echo ${directory:19})
    copy_path_to_create=$(echo "$copy_path$path_to_create")

    if [[ "$bitrate" -gt '192' ]] ; then

        echo "$bitrate - $FILENAME" >> ./results.txt
        mkdir -p "$copy_path_to_create"
        cp "$FILENAME" "$copy_path_to_create"
    fi

done < <(find "$mp3_path" -type f -name "*.mp3")

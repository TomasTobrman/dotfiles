#!/bin/bash

echo "Retrieving album information..."
jsondata=`yt-dlp -j --playlist-items 1 $1`

jq_release_year_1=`echo $jsondata | jq -r '.release_year'`
jq_release_date=`echo $jsondata | jq -r '.release_date'`
if [ $jq_release_date != 'null' ]; then
        jq_release_year_2=${jq_release_date::-4};
        year=$((jq_release_year_1<jq_release_year_2?jq_release_year_1:jq_release_year_2));
else
        year=$jq_release_year_1;
fi

jq_artist=`echo $jsondata | jq -r '.artist'`
artist=${jq_artist%%,*}

echo "Album information retrieved..."
yt-dlp  --ignore-errors \
        --format "(bestaudio[acodec^=opus]/bestaudio)/best" \
        --extract-audio \
        --audio-format m4a \
        --audio-quality 0 \
        --parse-metadata "playlist_index:%(track_number)s" \
        --parse-metadata ":(?P<webpage_url>)" \
        --parse-metadata ":(?P<synopsis>)" \
        --parse-metadata ":(?P<description>)" \
        --add-metadata \
        --postprocessor-args "-metadata date='${year}' -metadata artist=\"${artist}\" -metadata album_artist=\"${artist}\"" \
        --embed-thumbnail \
        --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" \
        -o "$artist/%(album)s/%(playlist_index)s - %(title)s.%(ext)s" "$1"

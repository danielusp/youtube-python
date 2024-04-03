#!/bin/bash

### Options
PS3="Selecione uma das opções: "
OP=(
	"Download Video"
    "Download Just Audio"
	"Download Streaming m3u8 [Low Quality]"
	"Download Streaming m3u8 [High Quality]"
	"Shell"
	"Quit"
)

select OPT in "${OP[@]}"
do
	case $OPT in
        "Download Video")
            echo "Insert YT video's id"
			read yt_id

			docker run -it \
				--net=host \
				-v "${PWD}:/usr/src/app" \
				--name youtube-dev \
				--rm youtube:dev \
				yt-dlp -f 'bv[ext=mp4]+ba[ext=m4a]' --merge-output-format mp4 "https://www.youtube.com/watch?v=$yt_id" -o "/usr/src/app/downloads/%(title)s.mp4"

			break
		    ;;
        "Download Just Audio")
			echo "Insert YT video's id"
			read yt_id

            docker run -it \
				--net=host \
				-v "${PWD}:/usr/src/app" \
				--name youtube-dev \
				--rm youtube:dev \
				yt-dlp -f 'ba' -x --audio-format mp3 "https://www.youtube.com/watch?v=$yt_id" -o "/usr/src/app/downloads/%(title)s.mp3"

			break
		    ;;
		"Download Streaming m3u8 [Low Quality]")
			echo "Insert m3u8 URL"
			read url
			echo "Insert a name for the .mp4 file"
			read file_name

            docker run -it \
				--net=host \
				-v "${PWD}:/usr/src/app" \
				--name youtube-dev \
				--rm youtube:dev \
				ffmpeg -protocol_whitelist "file,http,https,tcp,tls" -i "$url" -c:v libx264 -crf 23 -preset medium -c:a copy -bsf:a aac_adtstoasc downloads/$file_name.mp4

			break
		    ;;
		"Download Streaming m3u8 [High Quality]")
			echo "Insert m3u8 URL"
			read url
			echo "Insert a name for the .mp4 file"
			read file_name

            docker run -it \
				--net=host \
				-v "${PWD}:/usr/src/app" \
				--name youtube-dev \
				--rm youtube:dev \
				ffmpeg -protocol_whitelist "file,http,https,tcp,tls" -i "$url" -c copy -bsf:a aac_adtstoasc downloads/$file_name.mp4

			break
		    ;;
		"Shell")
			docker run -it \
				--net=host \
				-v "${PWD}:/usr/src/app" \
				--name youtube-dev \
				--rm youtube:dev \
				/bin/bash
			break
		    ;;
		"Quit")
			break
			;;

	    *) echo "Invalid $REPLY";;
	esac
done

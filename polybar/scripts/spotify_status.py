import subprocess as subp
import sys

# Configuration:
song_color = "#88c0d0"
pause_prefix = "Paused:"
pause_color = "#5e6779"
output_length = 30

status = subp.getoutput("spotifycli --status")

try:
    if status != "Spotify is off":
        artist = subp.getoutput("spotifycli --artist")
        song = subp.getoutput("spotifycli --song")

        if "Traceback" in artist:
            sys.exit()

        playback_status = subp.getoutput("spotifycli --playbackstatus")

        output = ""
        prefix_color_len = 0

        if playback_status == "▶":
            output = "{} - {}".format(artist, song)

        else:
            prefix = "%{F" + pause_color + "}" + pause_prefix + "%{F-}"
            output = "{} {} - {}".format(prefix, artist, song)

            prefix_color_len = len(prefix) - len(pause_prefix)

        if len(output) > output_length + prefix_color_len:
            output = output[:output_length + prefix_color_len]
            output = output.strip()
            output = output + "..."

        if " - " in output:
            split_index = output.find(" - ") + 2
            colored_output = output[:split_index] + "%{F" + song_color + "}" + output[split_index:] + "%{F-}"

            print(colored_output)

        else:
            print(output)

    else:
        print("")

except:
    print("Error")

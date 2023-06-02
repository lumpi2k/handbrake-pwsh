# Handbrake-Pwsh

This is a small script I put together because I'm currently ripping my old DVD collection, encoding all movies in the shiny new AV1 format to save space.
The script looks for folders and files in the "Source" folder. It then replicates the folder structure in the "Encoded" folder, naming files exactly like the folder, appending the previous filename to prevent overwriting files if more than one file was present in the input folder.

The script uses a custom preset from handbrake that uses the nvidia nvenc_av1 codec.

## What you need

- Nvidia RTX 40xx GPU with nvenc_av1 hardware encoder
- Handbrake CLI version that supports nvenc_av1 (I had to download one from here: https://github.com/HandBrake/handbrake-snapshots/releases/tag/win) --> dropped in the same folder
- Powershell

## Using the Script

1. `git clone https://github.com/lumpi2k/handbrake-pwsh`
2. copy your ripped DVD folders in the "Source" Folder
3. run `./encode.ps1` from Powershell

## Encoding Specs

- nvenc_av1
- slow preset (still gives me ~1000fps encoding speed for 1080p BluRays)
- Constant Quality 34
- up to 1080p output
- Keeps only German and English Soundtracks and subtitles

These settings aren't really quality-oriented, but since DVD quality is 💩 anyways, it works for me. I rather wanted to encode as quickly as possible.
If you want to use your own preset, you can export your favorite one from the Handbrake GUI (Presets --> Export to File) and drop it in this folder.
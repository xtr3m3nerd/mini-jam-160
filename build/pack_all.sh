#!/bin/bash

ITCH_USER="cranberryninja"
ITCH_PAGE="dungeon-light"
GAMENAME="dungeon_light"

declare -A html

html[dir]="./html"
html[build]="Web"
html[exe]="./build/html/index.html"
html[zip]="${GAMENAME}_html.zip"
html[deploy]="${ITCH_USER}/${ITCH_PAGE}:html5"

declare -A linux

linux[dir]="./linux"
linux[build]="Linux/X11"
linux[exe]="./build/linux/${GAMENAME}.x86-64"
linux[zip]="${GAMENAME}_linux.zip"
linux[deploy]="${ITCH_USER}/${ITCH_PAGE}:linux"

declare -A windows

linux[dir]="./windows"
linux[build]="Windows Desktop"
linux[exe]="./build/windows/${GAMENAME}.exe"
linux[zip]="${GAMENAME}_windows.zip"
linux[deploy]="${ITCH_USER}/${ITCH_PAGE}:win"

builds=(html linux windows)

rm ./*.zip
for build_type in "${builds[@]}"
do
	echo "Clean directory ${build_type[dir]}"
	mkdir -p "${build_type[dir]}"
	rm "${build_type[dir]}/*"
	cat << EOF > "${build_type[dir]}/.gitignore"
# Ignore everything in this directory
*
# Except this file
!.gitignore
EOF
	echo "Build"
	cd ..
	godot --headless --export-debug "${build_type[build]}" "${build_type[exe]}"
	cd build

	echo "Zip"
	cd "${build_type[dir]}"
	zip -r "../${build_type[zip]}" ./* -x "./.gitignore"
	cd ..

	echo "Deploy"
	butler push "${build_type[zip]}" "${build_type[deploy]}"
done

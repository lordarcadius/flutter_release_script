#!/bin/bash

#
# Copyright © 2023, "Vipul Jha" aka "lordarcadius" <vipuljha08@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

## Clean build or Dirty build
clean_or_dirty() {
    echo "Do you want to do a clean build?"
    echo
    PS3=$'\n'"Please enter your choice: "
    options=("Yes" "No" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "Yes")
            flutter clean
            flutter pub get
            echo
            echo "Everything is cleaned!"
            clear
            select_platform
            ;;
        "No")
            clear
            select_platform
            ;;
        "Quit")
            echo
            echo "Exiting the script...."
            exit 0
            ;;
        *)
            clear
            echo "$REPLY is not a valid option! Please choose again"
            echo
            clean_or_dirty
            ;;
        esac
    done
}

## Select a platform to build for
select_platform() {
    echo "What platform are you building for?"
    echo
    PS3=$'\n'"Please enter your choice: "
    options=("Android" "Web" "Linux" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "Android")
            clear
            build_for_android
            ;;
        "Web")
            clear
            build_for_web
            ;;
        "Linux")
            clear
            build_for_linux
            ;;
        "Quit")
            echo
            echo "Exiting the script...."
            exit 0
            ;;
        *)
            clear
            echo "$REPLY is not a valid option! Please choose again"
            echo
            select_platform
            ;;
        esac
    done
}

## Build type selection for Android

build_for_android() {
    echo "Please choose a variant"
    echo
    PS3=$'\n'"Please enter your choice: "
    options=("Split" "Fat" "AAB" "arm" "arm64" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "Split")
            clear
            flutter build apk --split-per-abi
            echo
            echo "Build finished!"
            exit 0
            ;;
        "Fat")
            clear
            flutter build apk
            echo
            echo "Build finished!"
            exit 0
            ;;
        "AAB")
            clear
            flutter build appbundle
            echo
            echo "Build finished!"
            exit 0
            ;;
        "arm")
            clear
            flutter build apk --release --target-platform=android-arm
            echo
            echo "Build finished!"
            exit 0
            ;;
        "arm64")
            clear
            flutter build apk --release --target-platform=android-arm64
            echo
            echo "Build finished!"
            exit 0
            ;;
        "Quit")
            echo
            echo "Exiting the script...."
            exit 0
            ;;
        *)
            clear
            echo "$REPLY is not a valid option! Please choose again"
            echo
            build_for_android
            ;;
        esac
    done

}

## Build type selection for web
build_for_web() {
    echo "Please choose a renderer"
    echo
    PS3=$'\n'"Please enter your choice: "
    options=("CanvasKit" "HTML" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "CanvasKit")
            clear
            flutter build web --web-renderer canvaskit --release
            echo
            echo "Build finished!"
            exit 0
            ;;
        "HTML")
            clear
            flutter build web --web-renderer html --release
            echo
            echo "Build finished!"
            exit 0
            ;;
        "Quit")
            echo
            echo "Exiting the script...."
            exit 0
            ;;
        *)
            clear
            echo "$REPLY is not a valid option! Please choose again"
            echo
            build_for_web
            ;;
        esac
    done

}

## Build for Linux
build_for_linux() {
    echo "Linux build support coming soon!"
    exit 0
}

clear
echo "================================"
echo "===== Flutter Build Script ====="
echo "============ By ================"
echo "=== Vipul Jha (@lordarcadius) =="
echo "================================"
echo
echo

clean_or_dirty
echo

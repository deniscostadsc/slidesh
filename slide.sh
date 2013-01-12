#!/bin/bash

pattern=".txt"

current=1
previous=0
next=2

next_key="."
previous_key=","
quit_key="q"

function help () {
    echo "usage: $(basename $0) [ -n | --next KEY ] [ -p | --previous KEY ] [ -q | --quit KEY ] [ -P | --pattern FILE-PATTERN ]"
    echo "       $(basename $0) --help"
    echo
    echo "  --next     set up a key to next key. Default is \".\""
    echo "  --previous set up a key to previous key. Default is \",\""
    echo "  --quit set up a key to quit key. Default is \"q\""
    echo "  --pattern  set up file pattern name. Default is \".txt\""
    echo
    echo "  --help     show help message."
    echo
    exit 1
}

while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            help
            exit 0
        ;;
        -p|--previous)
            shift
            previous_key=$1
            shift
        ;;
        -n|--next)
            shift
            next_key=$1
            shift
        ;;
        -q|--quit)
            shift
            quit_key=$1
            shift
        ;;
        -P|--pattern)
            shift
            pattern=$1
            shift
        ;;
        *)
            echo "$1 is an invalid option."
            exit 1
        ;;
    esac
done

clear
cat "$current$pattern"

while :; do
    read -s -n 1 KEY
    case $KEY in
        "$previous_key")
            if [ "$current" -ge 2 ]; then
                clear
                cat "$previous$pattern"
                next=$(($next - 1))
                current=$(($current - 1))
                previous=$(($previous - 1))
            fi
        ;;
        "$next_key")
            if [ -f "$next$pattern" ]; then
                clear
                cat "$next$pattern"
                next=$(($next + 1))
                current=$(($current + 1))
                previous=$(($previous + 1))
            fi
        ;;
        "$quit_key")
            exit 0
        ;;
    esac
done

#!/usr/bin/env zsh

fail=0

if [ $# -eq 0 ] && [ -z ${filename:+z} ]
then
    echo No parameters
    trap cleanup EXIT
    fail=1
else
    if [ ! $# -eq 0 ]
    then
        # filename=$1

        if [ ! -f $1 ]
        then
            echo No such file called $1
            fail=1
        fi

        [ $fail -eq 0 ] && export filename=$1

        [[ $(dirname $filename) == "." ]] && export filename=$(pwd)/$(basename $filename)
    fi
    
    cat $filename | pbcopy
fi
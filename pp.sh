#!/usr/bin/env sh

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

        if [[ ! $1 == *.py ]]
        then
            echo $1 is not a Python file
            fail=1
        fi

        [ $fail -eq 0 ] && export filename=$1

        [[ $(dirname $filename) == "." ]] && export filename=$(pwd)/$(basename $filename)
    fi

    if [ $fail -eq 0 ]
    then
        if [[ $filename == *.cpp ]]
        then
            echo \> Referring to bb
            echo

            bb
        fi

        clockit py $filename
    fi
fi
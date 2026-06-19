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

        if [[ ! $1 == *.cpp ]]
        then
            echo $1 is not a CPP file
            fail=1
        fi

        [ $fail -eq 0 ] && export filename=$1

        [[ $(dirname $filename) == "." ]] && export filename=$(pwd)/$(basename $filename)
    fi

    if [ $fail -eq 0 ]
    then
        echo \> Building $filename

        g++ --std=c++20 $filename -o ${filename/.cpp/.o} -O2 -g

        if [ $? -eq 0 ]
        then
            echo \> Finished.
            echo

            echo \[ Running command $filename \]

            start=$(date +"%s.%N")

            ${filename/.cpp/.o}

            end=$(date +"%s.%N")

            formated=$[ $end - $start ]

            which rg &>/dev/null && formated=`echo $formated | rg '^\d+(\.\d{0,3})?' -or '$0'`

            echo \[ $formated seconds \]

            echo \[ Progess Return $? \]
        fi
    fi
fi
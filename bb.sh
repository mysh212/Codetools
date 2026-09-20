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
        if [[ $filename == *.py ]]
        then
            echo \> Referring to pp
            echo

            pp
        else

            echo \> Building $filename

            g++ --std=c++20 $GPP_ARGS $filename -o ${filename/.cpp/.o} -O2 -DLOCAL # -g

            if [ $? -eq 0 ]
            then
                echo \> Finished.
                echo

                clockit ${filename/.cpp/.o}
            fi
        fi
    fi
fi
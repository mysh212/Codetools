#!/usr/bin/env bash

if (( $# < 1 ))
then
    echo No parameters.
else
    if [ ! -z $2 ] && [[ $2 == 'o' ]] || [[ $2 == 'out' ]]
    then
        target=out
    else
        target=in
    fi
    echo \> Making $1.$target
    echo

    cat - > $1.$target
fi
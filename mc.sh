#!/usr/bin/env sh

if [ $# -eq 0 ]
then
    echo Parameter needed.
else
    filename=$1
    url=$2

    [[ ${@: -1} == 'S' ]] && safe=1 && url= || safe=0

    if [ $# -gt 2 ]
    then
        p=-1
        [ $safe -eq 1 ] && p=-2
        for i in ${@:2:$p}
        do
            filename=$filename-$i
        done
        (( $p == -1 )) && url=${@: -1} || url=${@: -2: -1}
    fi

    if [ ! -z $url ] && ! [[ $url == http* ]]
    then
        filename=$filename-$url
        url=
    fi

    if [[ $filename == *.cpp ]]
    then
        filename=${filename/.cpp/}
    fi

    if [[ $(dirname $filename) == '.' ]]
    then
        filename=$(pwd)/$(basename $filename)
    fi

    filename=$filename.cpp

    if ([ -f $filename ] || [ -d $filename ]) && (( $safe == 0 ))
    then
        echo File existed.
    else
        # echo filename=$filename
        # echo url=$url
        # echo safe=$safe

        header=$(codeheader // $url)

        echo $header >! $filename
        [ -f $codebase/template.cpp ] && cat $codebase/template.cpp >> $filename
    fi
fi
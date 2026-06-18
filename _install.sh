#! /usr/bin/env sh

echo \> Installing script to shell rc

me=$0

if [[ ! $me == /* ]]
then
    me=$(pwd)/$0
fi

t=$(dirname $me)/_init.sh
me=$t

if [ ! -f $me ]
then
    echo \> Install Failed, cannot find the exact path.
else
    for i in ~/.*shrc
    do
        echo Installing to $i

        [[ `tail -c 1 $i` == '' ]] || echo >> $i

        grep ". $me" $i &>/dev/null && echo Skipping $i && continue

        echo ". $me" >> $i
    done
fi
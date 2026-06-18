#! /usr/bin/env sh

SELF_INDICATE=false

codebase=$0

if [[ ! $codebase == /* ]]
then
    codebase=$(pwd)/$0
fi

t=$(dirname $codebase)
codebase=$t

for i in $codebase/*.sh
do
    i=$(basename $i)
    i=${i/.sh/}

    if [[ ! $i == "_*" ]] || $SELF_INDICATE
    then
        chmod +x $codebase/$i.sh
        alias $i="$codebase/$i.sh"
    fi
done
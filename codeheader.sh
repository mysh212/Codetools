#!/usr/bin/env zsh

if [ $# -eq 0 ]
then
    prefix='//'
else
    prefix=$1
fi

if [ $# -eq 2 ] && [[ $2 == "c" ]]
then
    pre=1
    title="Pre-compiled : "
else
    pre=0
    title=""
fi


echo $prefix Author : ysh
echo $prefix $title$(date +"%Y/%m/%d %a %H:%M:%S")
if [ $# -gt 1 ] && [[ ! $2 == "c" ]]
then
    echo $prefix $2
fi
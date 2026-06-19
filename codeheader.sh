#!/usr/bin/env sh

if [ $# -eq 0 ]
then
    prefix='//'
else
    prefix=$1
fi

echo $prefix Author : ysh
echo $prefix $(date +"%Y/%m/%d %a %H:%M:%S")
if [ $# -gt 1 ]
then
    echo $prefix $2
fi
#!/usr/bin/env zsh

command=$*

echo \[ Running command $command \]
echo

start=$(date +"%s.%N")

# ${@: 1: 1} ${@: 2}
eval $command

end=$(date +"%s.%N")

formated=$[ $end - $start ]

which rg &>/dev/null && formated=`echo $formated | rg '^\d+(\.\d{0,3})?' -or '$0'`

echo

echo \[ $formated seconds \]
echo \[ Progess Return $? \]
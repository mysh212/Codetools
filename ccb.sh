#!/usr/bin/env zsh

fail=0

if [ $# -eq 0 ] && [ -z ${filename:+z} ]
then
    echo No parameters
    trap cleanup EXIT
    fail=1
else
    if [ ! $# -eq 0 ] && [[ ! $1 == "c" ]]
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
            cc
        else
            code=`sed 's/#include<bits\/stdc++.h>//g' $filename | sed 's/#include<bits\/extc++.h>//g' | g++ -E $GPP_ARGS -`
            grep '#include<bits/extc++.h' $filename &>/dev/null && code="#include<bits/extc++.h>\n$code"
            code="#include<bits/stdc++.h>\n$code"

            code="`codeheader // c`\n\n$code"
            (( $# >= 1 )) && [[ $1 == "c" ]] && code="$code\n/*\n$(cat $filename)\n*/"

            echo $code | pbcopy
            echo \> Finished.
        fi
    fi
fi
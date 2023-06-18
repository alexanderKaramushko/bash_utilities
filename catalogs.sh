#!/usr/bin/env bash

catalogs=$1
files=$2
shoud_reset=$3

create_files () {
    for (( file=1; file <= $files; file++ ))
    do
        touch "$1/${file}"
    done
}

for (( catalog=1; catalog <= $catalogs; catalog++ ))
do
    if [ $shoud_reset = "true" ]
    then
        rm -r $catalog
    fi
    
    if [ -d $catalog ]
    then
        create_files $catalog
    else
        mkdir $catalog
        create_files $catalog
    fi
done
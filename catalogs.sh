#!/usr/bin/env bash

catalogs=$1
files=$2
make_archive=$3
shoud_reset=$4

create_files () {
    for (( file=1; file <= $files; file++ ))
    do
        path="$1/${file}"
        touch $path
        echo $path
    done
}

create_catalogs () {
    for (( catalog=1; catalog <= $catalogs; catalog++ ))
    do
        if [ $shoud_reset = "true" ]
        then
            rm -r $catalog
        fi
        
        if ! [ -d $catalog ]
        then
            mkdir $catalog
        fi
        
        create_files $catalog
    done
}

create_archive () {
    for file in $files
    do
        if [ -e "archive.tar.gz" ]
        then
            tar -cvf archive.tar.gz $file
        else
            tar -rvf archive.tar.gz $file
        fi
    done
}

files=$(create_catalogs)

if [ $make_archive = "true" ]
then
    create_archive $files
fi

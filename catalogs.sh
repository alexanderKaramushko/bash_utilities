#!/usr/bin/env bash

archive="false"
clear_dirs="false"

while [ -n "$1" ]
do
    case "$1" in
        -ar) archive="true" ;;
        -cd) clear_dirs="true" ;;
        --) shift
        break ;;
        *) echo "$1 is not an option";;
    esac
    shift
done

catalogs=$1
files=$2

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
        if [ $clear_dirs = "true" ]
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

if [ $archive = "true" ]
then
    create_archive $files
fi

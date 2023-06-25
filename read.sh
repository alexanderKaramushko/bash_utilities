#!/usr/bin/env bash

count=1

read dir

cat $dir | while read line
do
    echo "Line $count: $line"
    count=$(( $count + 1 ))
done
echo "Finished"
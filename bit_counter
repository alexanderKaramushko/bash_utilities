#!/usr/bin/env bash

size="kb"

while [ -n "$1" ]; do
  case "$1" in
  -size)
    size=$2
    shift
    ;;
  --)
    shift
    break
    ;;
  *) echo "$1 is not an option" ;;
  esac
  shift
done

# 1 символ закодирован в 1 байте ASCII
symbols=$(wc -c <$1)

if [ $size = "kb" ]; then
  echo $(($symbols / 1000))
elif [ $size = "mb" ]; then
  echo $(($symbols / 1000000))
fi

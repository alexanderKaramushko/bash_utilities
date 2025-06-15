#!/usr/bin/env bash

# https://gist.githubusercontent.com/Semionn/bdcb66640cc070450817686f6c818897/raw/f9e8c888a771dd96f54562a9b050acd1138cc7a9/war_and_peace.ru.txt

url=$1
loaded=$2
converted=$3

if ! [ -x "$(command -v enca)" ]; then
  echo 'Error: enca is not installed.' >&2
  exit 1
fi

wget -O $loaded $url

count_lines () {
  count=0
  # Перенаправить STDIN на дескриптор 3
  exec 3<&0
  # Перенаправить STDIN из файла на дескриптор STDIN(0)
  exec 0<"$1"
  while read -r line
  do
    count=$(( $count + 1 ))
  done
  # Вернуть стандартный дескриптор
  exec 0<&3
  echo "Lines count: $count"
}

encoding=$(enca -L ru -e $0)

if [ $encoding = "UTF-8" ]; then
echo "encoding is UTF-8"
count_lines $loaded
else
echo "converting into UTF-8..."
cat $loaded | iconv -f $encoding -t UTF-8 > $converted
count_lines $converted
fi

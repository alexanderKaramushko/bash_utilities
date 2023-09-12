get_int() {
  echo $1 | sed 's/^\./0\./' | sed 's/\.[0-9]*//g'
}

convert_ints_to_null() {
  echo $1 | sed 's/^[0-9]*/0/g'
}

convert_ints_to_null() {
  echo $1 | sed 's/^[0-9]*/0/g'
}

trim() {
  echo $1 | sed 's/ //g'
}

from_10 () {
  strNumber=$1
  base=$2
  length=`expr "$strNumber" : '.*'`

  integer=$(get_int $(trim $strNumber))

  quatient_integer=$integer
  float=$(bc -l <<<"${strNumber}-${quatient_integer}")

  value=""

  while [ $quatient_integer -ne 0 ]
  do
    rest=$(($quatient_integer % 2))
    quatient_integer=$(($quatient_integer / 2))

    value="$rest $value"
  done

  max_count=5

  while [[ $max_count -ne 0 ]]
  do
    result=$(bc -l <<<"${float}*2")
    float=$(convert_ints_to_null $result)
    binary_float=$(get_int $result)

    if [[ $value =~ \. ]]
    then
      value="$value$binary_float"
    else
      value="$value.$binary_float"
    fi

    max_count=$(($max_count-1))
  done

  echo $(trim "${value}")
}

from_10 $1

base_10_converter () {
  strNumber=$(echo $1 | sed 's/ //g')
  base=$2
  length=`expr "$strNumber" : '.*'`

  value=0

  for (( power=$(($length-1)); power >= 0; power-- ))
  do
    digit=$(($length-$power-1))
    eight_power=$(($base**$power))
    number=`expr ${strNumber:digit:1}`
    value=$(($value+$number*$eight_power))
  done

  echo $value
}

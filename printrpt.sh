#! /bin/bash

read -p 'Enter state: ' state 
read -p 'Total Electric Industry Category: ' industry

grep -i ${state} generation_monthly.csv | grep -i "${industry}" | grep "Total Electric Power Industry" | sed 's|[a-ZA-Z]||g' | cut -d"," -f2- | sed 's/,/ /' | sed 's|[",]||g' |  sed 's/  */ /g' > /tmp/$USER$$.tmp

monthNames=("" January February March April May June July August September October November December)

total=0
month=1
while read line;
do  
  number=$(echo $line | cut -d" " -f2)  
  total=$(( total + number ))
  printf "%10s:%10d\n" ${monthNames[$month]} $number    
  month=$(( $month + 1 ))
done < /tmp/$USER$$.tmp

printf "\n%10s:%10d\n" "Total" $total

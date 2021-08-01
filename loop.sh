#!/bin/sh  
while true  
do  
  echo "Run ./bs.sh"
  ./bs.sh
  echo "Sleep"
  sleep 15
  echo "Remove"
  rm backup.txt
  rm bs.sh
  echo "Sleep"
  sleep 15
done

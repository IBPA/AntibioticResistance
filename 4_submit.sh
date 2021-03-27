#!/bin/bash
# no need to pass $1
while read strain file_name

do
  if [[ $strain == *$1* ]]; then
  sed -i "s/strain=.*/strain=${strain}/g" 4_var_call.sh
  sbatch  4_var_call.sh $1
  #echo 4_var_call.sh
  fi

done < ./meta.txt

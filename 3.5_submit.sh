#!/bin/bash
# no need to pass $1
while read strain file_name

do
  if [[ $strain == *$1* ]]; then
  sed -i "s/strain=.*/strain=${strain}/g" 3.5_bam_summary.sh
  sbatch  3.5_bam_summary.sh $1
  #echo 3.5_bam_summary.sh
  fi

done < ./meta.txt

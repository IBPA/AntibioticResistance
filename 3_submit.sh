#!/bin/bash
# no need to pass $1
while read f1 f2 sample

do
  sed -i "s/strain=.*/strain=${sample}/g" 3_sort.sh
  sbatch  3_sort.sh $1
  # cat 3_sort.sh
  echo $sample

done < ../meta/list

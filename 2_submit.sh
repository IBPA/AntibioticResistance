#!/bin/bash
while read f1 f2 sample

do
  sbatch  2_bowtie2.sh $f1 $f2 $sample

done < ../meta/list_miss

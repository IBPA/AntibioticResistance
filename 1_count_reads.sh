#!/bin/bash
while read f1 f2
do
   wc -l ../raw_seq/$f1

done < ../meta/list

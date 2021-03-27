#!/bin/bash
#SBATCH -p high
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem-per-cpu 5000
#SBATCH -t 9:00:00
#SBATCH -o output/%j.out
#SBATCH -e output/%j.err

source 0_setpath.sh $1
source ~/.bashrc
strain=Population4

# sort
srun samtools flagstat $rm_dup_bam_p/${strain}.bam | sed -n '1p;4p;5p' |cut -d"+" -f1  > $bam_sum_p/${strain}
srun samtools depth $rm_dup_bam_p/${strain}.bam  |awk '{c++;s+=$3}END{print s/c}' >> $bam_sum_p/${strain}

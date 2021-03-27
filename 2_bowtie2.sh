#!/bin/bash
#SBATCH -p low
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem-per-cpu 5000
#SBATCH -t 9:00:00
#SBATCH -o output/$3.out
#SBATCH -e output/$3.err

source 0_setpath.sh 
srun bowtie2 -x $index_bowtie2 -1 $single_p/$1 -2 $single_p/$2  -S $sam_p/$3.sam
srun samtools view -bS $sam_p/$3.sam > $bam_p/$3.bam

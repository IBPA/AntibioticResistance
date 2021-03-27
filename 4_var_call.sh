#!/bin/bash
#SBATCH -p high
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem-per-cpu 12000
#SBATCH -t 9:00:00
#SBATCH -o output/%j.out
#SBATCH -e output/%j.err

source 0_setpath.sh $1
source ~/.bashrc
strain=Parental



/home/wxk/software/gatk-4.0.12.0/gatk Mutect2 -I $rg_bam_p/${strain}.bam -I $rg_bam_p/Parental.bam -tumor Parental -normal  ${strain}  -O $mutect_vcf_p/Parental_vs_${strain}.vcf -R $ref

/home/wxk/software/gatk-4.0.12.0/gatk Mutect2 -I $rg_bam_p/${strain}.bam -I $rg_bam_p/Parental.bam -tumor ${strain} -normal  Parental  -O $mutect_vcf_p/${strain}_vs_Parental.vcf -R $ref
~                    
~                    

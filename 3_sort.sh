#!/bin/bash
#SBATCH -p high
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem-per-cpu 40000
#SBATCH -t 9:00:00
#SBATCH -o output/%j.out
#SBATCH -e output/%j.err

source 0_setpath.sh $1
source ~/.bashrc
strain=XF

#samtools sort $bam_p/${strain}.bam > $sort_p/${strain}.bam

#java -jar /home/wxk/software/picard.jar MarkDuplicates VALIDATION_STRINGENCY=SILENT I=$sort_p/${strain}.bam O=$rm_dup_bam_p/${strain}.bam M=$rm_dup_bam_p/metrics/${strain}.txt

# testing no removal duplicates; add read group
#java -jar /home/wxk/software/picard.jar AddOrReplaceReadGroups VALIDATION_STRINGENCY=SILENT I=$rm_dup_bam_p/${strain}.bam O=$rg_bam_p/${strain}.bam SO=coordinate RGID=$strain RGLB=$strain RGPL=illumina RGPU=$strain RGSM=$strain CREATE_INDEX=true

# pileup
#samtools mpileup -q 1 -Q 20 -f $ref $rg_bam_p/${strain}.bam > ${pileup_p}/${strain}.pileup


java -jar /home/wxk/software/VarScan.v2.4.3.jar pileup2snp  ${pileup_p}/${strain}.pileup --p-value 0.1 > ${vcf_varscan_p}/${strain}.snp
java -jar /home/wxk/software/VarScan.v2.4.3.jar pileup2indel  ${pileup_p}/${strain}.pileup --p-value 0.1 > ${vcf_varscan_p}/${strain}.indel

/home/wxk/software/gatk-4.0.12.0/gatk HaplotypeCaller -R $ref -I $rg_bam_p/${strain}.bam  -O $vcf_gatk_p/${strain}.vcf 

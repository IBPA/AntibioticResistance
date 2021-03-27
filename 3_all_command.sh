#!/bin/bash
#SBATCH -p high
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mem-per-cpu 20000
#SBATCH -t 9:00:00
#SBATCH -o output/%j.out
#SBATCH -e output/%j.err

source 0_setpath.sh $1
strain=Final16

# sort
#srun java -jar /home/wxk/software/picard.jar SortSam INPUT=$bam_p/${strain}.bam OUTPUT=$sort_p/${strain}.bam SORT_ORDER=coordinate
srun samtools sort $bam_p/${strain}.bam > $sort_p/${strain}.bam 

# remove PCR duplicates
srun java -jar /home/wxk/software/picard.jar MarkDuplicates VALIDATION_STRINGENCY=SILENT I=$sort_p/${strain}.bam O=$rm_dup_bam_p/${strain}.bam M=$rm_dup_bam_p/metrics/${strain}.txt



# add read group info if the aligner does not add read group
# and buid index
srun java -jar /home/wxk/software/picard.jar AddOrReplaceReadGroups VALIDATION_STRINGENCY=SILENT I=$rm_dup_bam_p/${strain}.bam O=$rg_bam_p/${strain}.bam SO=coordinate RGID=$strain RGLB=$strain RGPL=illumina RGPU=$strain RGSM=$strain CREATE_INDEX=true

# pileup
samtools mpileup -q 1 -Q 20 -f $ref $rg_bam_p/${strain}.bam > ${pileup_p}/${strain}.pileup 

# varscan
java -jar /home/wxk/software/VarScan.v2.4.3.jar somatic ${pileup_p}/Parental.pileup ${pileup_p}/${strain}.pileup ${varscan_vcf_p}/${strain}

# realign: no need for GATK4
# add your path for java8 to the PATH
source ~/.bashrc
#srun /home/wxk/software/gatk-4.0.12.0/gatk RealignerTargetCreator -R $ref -I $rg_bam_p/${strain}.bam -o ${rg_bam_p}/${strain}_realign.list
#srun /home/wxk/software/gatk-4.0.12.0/gatk  IndelRealigner -R $ref -I $rg_bam_p/${strain}.bam -targetIntervals ${rg_bam_p}/${strain}_realign.list -o $realign_bam/${strain}.bam
#srun /home/wxk/software/gatk-4.0.12.0/gatk HaplotypeCaller -R $ref -I $rg_bam_p/${strain}.bam -O $vcf1_p/${strain}.vcf

# Mutect
# remove the strain=Final16
#srun /home/wxk/software/gatk-4.0.12.0/gatk Mutect2 -I:$rg_bam_p/Parental.bam -I:$rg_bam_p/${strain}.bam -O $mutect_vcf_p/${strain}.vcf -R $ref

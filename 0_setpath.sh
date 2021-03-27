#!/bin/bash

bowtie2=/usr/bin/bowtie2
index_bowtie2=/home/wxk/ref/atsumi/index/ecoli
ref=/home/wxk/ref/atsumi/U00096.3.fasta

home_p=$(dirname $PWD)
single_p=$home_p/raw_seq
sam_p=$home_p/sam
bam_p=$home_p/bam
sort_p=$home_p/sort_bam
rm_dup_bam_p=$home_p/rm_dup_bam
rg_bam_p=$home_p/rg_bam
pileup_p=$home_p/pileup
vcf_varscan_p=$home_p/vcf_varscan
vcf_gatk_p=$home_p/vcf_gatk
depth_p=$home_p/depth
samtools_s=/usr/bin/samtools 
summary_p=$home_p/summary
bam_sum_p=$home_p/bam_summary

#!/bin/bash
home_p=$(dirname $PWD)
cd $home_p
mkdir raw_seq
mkdir sam
mkdir bam
mkdir sort_bam
mkdir rm_dup_bam
mkdir ./rm_dup_bam/metrics
mkdir rg_bam
mkdir vcf_gatk
mkdir vcf_varscan




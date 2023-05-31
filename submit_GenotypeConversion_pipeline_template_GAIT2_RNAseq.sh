#!/bin/bash
#$ -cwd
#$ -jc long
#$ -pe smp 1
#$ -adds l_hard h_vmem 5G
#$ -adds l_hard m_mem_free 5G
#$ -N ConvertVcf2Hdf5
#$ -M 2395453@dundee.ac.uk
#$ -m beas

# These are needed modules in UT HPC to get Singularity and Nextflow running.
# Replace with appropriate ones for your HPC.
# module load java-1.8.0_40
# module load singularity/3.5.3
# module load squashfs/4.4

# If you follow the eQTLGen phase II cookbook and analysis folder structure,
# some of the following paths are pre-filled.
# https://github.com/eQTLGen/eQTLGen-phase-2-cookbook/wiki/eQTLGen-phase-II-cookbook

# We set the following variables for nextflow to prevent writing to your home directory (and potentially filling it completely)
# Feel free to change these as you wish.
export SINGULARITY_CACHEDIR=../../singularitycache
export NXF_HOME=../../nextflowcache

nextflow_path=../../tools/  # Path to Nextflow executable, no need to adjust if folder structure is same as recommended in cookbook.

cohortname="GAIT2"
genopath=../../2_Imputation/output/postimpute   # Folder with input genotype files in .vcf.gz format
outputpath=../output/ # Path to output folder, no need to adjust if the folder structure is same as recommended in cookbook.

NXF_VER=21.10.6 ${nextflow_path}/nextflow run ConvertVcf2Hdf5.nf \
--vcf ${genopath} \
--outdir ${outputpath} \
--cohort_name ${cohortname} \
-profile sge,singularity \
-resume

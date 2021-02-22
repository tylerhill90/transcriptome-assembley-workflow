#!/usr/bin/env bash

# This program sorts the SAM files generated in align_reads_gmap.sh and
# converts them into the BAM format for the assembler via samtools

# Initialize variable to contain the path to the SAM files
samPath="sam/"

# Initialize variable for output path and output directory
bamOutPath="bam/"
mkdir -p $bamOutPath

# Iterate over all SAM files in $samPath
function sortAll {
    for samFile in $samPath*".sam"
    do
        # Remove the path and .sam filetype to obtain just the sample name
        pathRemoved="${samFile/$samPath}"
        sampleName="${pathRemoved/.sam}"
        # Run samtools to create a sorted bam file in the bam directory
        samtools sort \
        $samFile \
        -o $bamOutPath$sampleName".sorted.bam" 
    done
}
sortAll 1>sortAll.log 2>sortAll.err &

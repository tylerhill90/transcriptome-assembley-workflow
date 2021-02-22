#!/usr/bin/env bash

# This program takes the sorted BAM files created in sortAll.sh and indexes
# them via samtools

# Initialize variable to contain the path to the sorted BAM files
bamPath="bam/"

# Iterate over all sorted BAM files in $bamPath
function indexAll {
    for bamFile in $bamPath*".sorted.bam"
    do
        # Remove the path and .sorted.bam file type to obtain just the sample name
        # pathRemoved="${bamFile/$bamPath}"
        # sampleName="${pathRemoved/.sorted.bam}"
        # Run samtools index on the sorted bam file
        samtools index \
        $bamFile 
    done
}
indexAll 1>indexAll.log 2>indexAll.err &

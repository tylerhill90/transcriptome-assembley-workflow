#!/usr/bin/env bash

# This program aligns all the samples (previously trimmed in trim_reads.sh)
# against the GMAP database in "AiptaisGmapDb" and using the index of intron
# splice sites in AiptasiaGmapIIT.iit via GSNAP. Output is in the SAM format

# Initialize variables to contain path to paired reads, left and right files
pairedOutPath="Paired/"
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"

# Initialize variable for output path and output directory
samOutPath="sam/"
mkdir -p $samOutPath

# Iterate over all left-read fastq files in $pairedOutPath
function alignAll {
    for leftPairedOut in $pairedOutPath*$leftSuffix
    do
        # Remove the path from the filename
        pathRemoved="${leftPairedOut/$pairedOutPath/}"
        # Remove the left-read suffix
        sampleName="${pathRemoved/$leftSuffix/}"
        # Print $sampleName
        echo $sampleName
        nice -n19 gsnap \
        -A sam \
        -D . \
        -d AiptasiaGmapDb \
        -s AiptasiaGmapIIT.iit \
        $pairedOutPath$sampleName$leftSuffix \
        $pairedOutPath$sampleName$rightSuffix \
        1>$samOutPath$sampleName".sam"
    done
}
alignAll 1>alignAll.log 2>alignAll.err &

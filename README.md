# Reference Guided and De Novo Transcriptome Assembly

This work flow comes from a school project. For purposes of academic honesty I will not mention the class or where the data that was used specifically came from. 

## Methods

Reads were obtained from a subset of an RNA-Seq experiment studying immune response and symbiosis in *Aiptasia pallida*. The data used in this exercise is a subset QC sequencing  run of the full data set obtained from Illumina paired-end reads of 100 bp read length.

Reads were quality trimmed using Trimmomatic [1] with the following parameters selected:

```
HEADCROP:0 ILLUMINACLIP:../Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 /
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 
```

A GMAP database for the *Aiptasia* genome was built as well as an index of intron splice sites with GSNAP. [2] Reads were then aligned with GSNAP and alignments were sorted and indexed with samtools. [3]

Sorted BAM files from left and right read pairs were merged into a single BAM file via the command samtools merge [3]. This merged BAM file was passed into the open source transcriptome assembler Trinity [4] utilizing a genome-guided assembly strategy.

The assembled transcriptome file was statistically analyzed via the built in Trinity utility TrinityStats [4].

A de-novo assembly method was also conducted via Trinity. A shell script was created to pass into Trinity two comma-separated lists of files for the left and right reads to be analyzed.

The de-novo assembled transcriptome file were also statistically analyzed via the built in Trinity utility TrinityStats.

## Workflow

To execute the workflow the following scripts were run in this order.

1. trim_reads.sh
2. build_gmap_db.sh
3. intron_index.sh
4. align_reads_gmap.sh
5. sort_sam.sh
6. index_bam.sh
7. merge_bam.sh
8. run_trinity_guided.sh
9. analyze_guided.sh
10. run_trinity_denovo.sh
11. analyze_trinity_denovo.sh

## References

1. Bolger, Anthony M., Marc Lohse, and Bjoern Usadel. "Trimmomatic: A Flexible  Trimmer for Illumina Sequence Data." Bioinformatics 30.15 (2014): 2114-120. Web.

2. Wu, Thomas D, Jens Reeder, Michael Lawrence, Gabe Becker, and Matthew J 
Brauer. "GMAP and GSNAP for Genomic Sequence Alignment: Enhancements to Speed, Accuracy, and Functionality." Methods in Molecular Biology (Clifton, N.J.) 1418 (2016): 283-334. Web.

3. Li, Heng, Bob Handsaker, Alec Wysoker, Tim Fennell, Jue Ruan, Nils Homer, Gabor Marth, Goncalo Abecasis, and Richard Durbin. "The Sequence Alignment/Map Format and SAMtools." Bioinformatics 25.16 (2009): 2078-079. Web.

4. Fan, Lin, Nusbaum, Chad, Haas, Brian J, Chen, Zehua, Lindblad-Toh, Kerstin, Raychowdhury, Raktima, . . . Levin, Joshua Z. (2011). Full-length transcriptome assembly from RNA-Seq data without a reference genome. Nature Biotechnology, 29(7), 644-652.

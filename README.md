# bash-scripts

## align_reads.sh
- Uses bowtie2 v2.5.3 to align paired-ends reads to specified database
- Input: $1 = path to directory containing all paired reads, $2 = path to directory containing database index files build with bowtie2
- NAMING CONVENTIONS: Paired end fastq files need to be distinguishedd with R1 and R2 within names, names must be long enough that R1 or R2 occurs after the first 6 characters in name (this can be changed)
  

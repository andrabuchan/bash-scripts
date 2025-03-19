#!/bin/bash
#USAGE: ./filter_rrna.sh path/to/pairedend_data path/to/bt2_index
module load bowtie2

#creates array of all file paths
declare -a filearr
for file in $1/*; do
filearr+=("$file")
done

#Matches pairs in paired end data
for file_a in "${filearr[@]}"; do
for file_b in "${filearr[@]}"; do
file_a_trimmed=$(basename $file_a)
file_b_trimmed=$(basename $file_b)
if [ "$file_a" != "$file_b" ] && [ "${file_a_trimmed:0:6}" == "${file_b_trimmed:0:6}" ] && [[ "$file_a_trimmed" == *R1* ]]; then

#produces output sam file
output_sam=$(echo "$file_a_trimmed" | sed 's/_R[12].*$//g').sam
#unzips pairs
if [[ "$file_a" == *.gz ]]; then
gunzip $file_a
unzipped1=$(echo $file_a | sed 's/\.gz//g')
else unzipped1=$file_a
fi

if [[ "$file_b" == *.gz ]]; then
gunzip $file_b
unzipped2=$(echo $file_b | sed 's/\.gz//g')
else unzipped2=$file_b
fi

#aligns paired ends to reference db specified in first argument
bowtie2 -x $2 -1 $unzipped1 -2 $unzipped2 > $output_sam

gzip $unzipped1 $unzipped2

fi
done
done

#!/bin/bash
#$ -cwd
#$ -j y
#$ -q all.q
#$ -o /dev/null
#$ -e /dev/null

N=${SGE_TASK_ID}
cd ../data/
info=`head NRL_combinations.txt -n ${N} | tail -n -1`
pair=($info)
tf=${pair[0]}
q=${pair[1]}
CHR=${pair[2]}

perl /storage/projects/teif/nuctools.1.0/nucleosome_repeat_length.pl --input=${CHR}.${tf}_${q}.bed --output=NRL_${CHR}.${tf}_${q}.txt --delta=1000 --apply_filter

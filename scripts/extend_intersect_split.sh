#!/bin/bash
#$ -cwd
#$ -q all.q
#$ -j y
#$ -S /bin/bash


N=${SGE_TASK_ID}

info=`head combinations.txt -n ${N} | tail -n -1`
cd quintiles_ralph/

pair=($info)
TF=${pair[0]}
i=${pair[1]}



bedtools slop -l -100 -r 2000 -i quintile_${i}_${TF}_sites.bed -g /storage/projects/teif/mm9_generic_data/mm9.genome > quintile_${i}_${TF}_sites_extended.bed
sortBed -i quintile_${i}_${TF}_sites_extended.bed > quintile_${i}_${TF}_sites_extended_sorted.bed
intersectBed -a /storage/projects/teif/mESC/nucleosome_positioning_datasets/chemical_mapping_mnase/chemical_mnase_formatted_sorted_Chemical_mapping_MNase_WT.bed -b quintile_${i}_${TF}_sites_extended_sorted.bed -u > mnase_intersect_quintile_${i}_${TF}_sites_extended_sorted.bed
#rm ${TF}_binding_sites_extended.bed
perl /storage/projects/teif/nuctools.3.0/extract_chr_bed.pl --output=${TF}_${i} --input=mnase_intersect_quintile_${i}_${TF}_sites_extended_sorted.bed -p all
rm mnase_intersect_quintile_${i}_${TF}_sites_extended_sorted.bed


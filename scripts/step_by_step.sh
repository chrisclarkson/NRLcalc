qsub download_and_map_MNase.sh #wait for this to finish
qrsh
Rscript TF_binding_site_affinity.R

Rscript quantiles.R CTCF 6 #specify TF to split quantiles and column to use for affinity metric
exit

qsub -t 1-45 -tc 10 NRL_all_combinations.sh

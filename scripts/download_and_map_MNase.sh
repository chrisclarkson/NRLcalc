wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR361/001/SRR3618561/SRR3618561_1.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR361/001/SRR3618561/SRR3618561_2.fastq.gz
gunzip SRR3618561_1.fastq.gz
gunzip SRR3618561_2.fastq.gz

bowtie -t -v 2 -p 7 -m 1 mm9 -1 SRR3618561_1.fastq -2 SRR3618561_2.fastq SRR3618555.map
perl -w /storage/projects/teif/___perl_scripts_2012/bowtie2bed.pl SRR3618561.map SRR3618561.bed
perl -w /storage/projects/teif/nuctools.1.0/extend_PE_reads.pl SRR3618561.bed MNase.bed


library(TFBSTools)
library(JASPAR2018)
library("BSgenome.Mmusculus.UCSC.mm9") 
library(GenomicRanges)
library(tRap)
jaspar <- function (collection = "CORE", ...)
{
  opts <- list()
  opts["tax_group"] <- "vertebrates"
  opts["collection"] <- collection
  opts <- c(opts, list(...))
  out <- TFBSTools::getMatrixSet(JASPAR2018::JASPAR2018, opts)
  if (!isTRUE(all.equal(TFBSTools::name(out), names(out)))) 
    names(out) <- paste(names(out), TFBSTools::name(out), 
                        sep = "_")
  return(out)
}
pfms <- jaspar()

#chrom_sizes=read.table('/storage/projects/teif/mm9_generic_data/mm9.genome_21',header=F,stringsAsFactors=F)
chrom_sizes=data.frame(names(seq),width(seq))[1:21,]
tf_names=c()
for(number in 1:length(pfms)){
  pfm=pfms_sub[[number]]
  tf=name(pfm)
  pwm=PWMatrix(ID="Unknown", name=tf, matrixClass="Unknown", strand="+", 
    bg=c(A=0.25, C=0.25, G=0.25, T=0.25), tags=list(), profileMatrix=as.matrix(pfm))
  peaks = searchSeq(pwm, seq, min.score = "80%",mc.cores=10L)
  peaks_bed = as(peaks, "GRanges")
  peaks_bed=peaks_bed[seqnames(peaks_bed)%in%paste0('chr',c(1:19,'X','Y'))]
  start(peaks_bed) <- start(peaks_bed) - 30
  end(peaks_bed) <- end(peaks_bed) + 30
  for(chr in 1:nrow(chrom_sizes)){sub=peaks_bed[seqnames(peaks_bed)==chrom_sizes[chr,1]]; end(sub)[end(sub)>chrom_sizes[chr,2]]=chrom_sizes[chr,2]; peaks_bed[seqnames(peaks_bed)==chrom_sizes[chr,1]]=sub}
  start(peaks_bed)[start(peaks_bed)<=0]=1
  extended_seqs <- getSeq(Mmusculus, peaks_bed)
  pwm=as.matrix(pfm)
  af_ext=affinity(pwm,as.data.frame(extended_seqs)$x)
  peaks_df=data.frame(as.data.frame(peaks_bed),affinities=af_ext)
  write.table(peaks_df[,c(1,2,3,5,9,14)],paste0(tf,'_binding_sites_80pc_affinity.bed'),sep='\t',col.names=F,row.names=F,quote=F)
  print(tf)
 print(number)
tf_names=c(tf_names,tf)
}
tf_names=c(tf_names,tf)
tf_names=tf_names[-grep(tf_names,pattern='::')]
write.table(tf_names,'pfms',col.names=F,row.names=F,quote=F)

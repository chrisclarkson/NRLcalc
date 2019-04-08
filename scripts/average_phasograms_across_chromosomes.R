files=list.files(pattern='NRL*CTCF*txt')

for(j in 1:5){
        quints=files[grep(files,pattern=paste0('_',j,'.txt'))]
        chrs<-lapply(quints, read.table, header=FALSE, fill=T)
        x1<-Reduce('+', chrs)/length(chrs)
        write.table(x1,paste0('NRL_CTCF_',j,'_aggregate.txt'),col.names=F,row.names=F,quote=F)

}
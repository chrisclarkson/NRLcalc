args = commandArgs(trailingOnly=TRUE)
sites=read.table(paste0('../data/',args[1],'_binding_sites_80pc_affinity.bed'), sep='\t',header=F,stringsAsFactors=F)
sites_rearranged=sites[order(sites[,as.integer(args[3])],decreasing=F),]
print(head(sites_rearranged))
partitions=seq(1,nrow(sites_rearranged),round(nrow(sites_rearranged)/5))
partitions=c(partitions,nrow(sites_rearranged))
to=length(partitions)-1
for(i in c(1:to)){
    sub=sites_rearranged[partitions[i]:partitions[i+1],]
    print(head(sub))
    write.table(sub, paste0('../data/quintile_',i,'_',args[1],'_',args[2],'.bed'),sep='\t',
                col.names=F,row.names=F,quote=F)
}

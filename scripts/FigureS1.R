df=read.table('NRLs_main-2.txt',header=F,stringsAsFactors=F,sep='\t')
colnames(df)=c('Source','TF','NRL','Error')
df$TF=gsub('NRL_','',df$TF)
df$TF=gsub('_aggregate.txt','',df$TF,)
#df=df[-which(df$Error=='NaN'),]
df$Error=as.integer(df$Error)
parse_tf_name=function(tf_name){
      half_extracted=strsplit(tf_name, "_")[[1]]
      return(half_extracted)
}
df_tmp=as.data.frame(t(data.frame(lapply(df$TF,parse_tf_name),stringsAsFactors=F)))
colnames(df_tmp)=c('TF','quintile')
df2=data.frame(df_tmp,df,stringsAsFactors=F)
#df2=df2[df2$Error<3,]
#df2=df2[grep(df$TF,pattern='SOX',ignore.case=T),]
library(ggplot2)
library(ggthemes)
library(cowplot)

pdf('CTCF_split_Experimental_vs_predicted_split_loess.pdf')
p<- ggplot(df2, aes(x=quintile, y=NRL, group=Source, color=Source)) + 
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 1), se = FALSE) +
  geom_point()+scale_fill_discrete(guide=FALSE)+guides(fill=FALSE,color=FALSE)+
  geom_errorbar(aes(ymin=NRL-Error, ymax=NRL+Error), width=.2,
                 position=position_dodge(0.2)) + theme_cowplot(font_size = 15)+facet_wrap(~Source)+theme(legend.position="none",panel.grid.minor = element_blank(),      
  panel.grid.major = element_blank(), strip.text = element_text(size=9))
p
dev.off()
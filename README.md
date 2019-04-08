# Nucleosome_repeat_length_near_transcription_factors

# Paper Title
What determines the decrease in nucleosome repeat length near bound CTCF?

# Abstract
'Nucleosome repeat length (NRL) defines the average distance between adjacent nucleosomes. When calculated for specific
genomic regions, NRL reflects the local nucleosome ordering and characterises its changes e.g. during cell differentiation. 
One of the strongest nucleosome positioning signals is provided by CTCF, the architectural protein that sets a decreased NRL 
for up to 20 nucleosomes in its vicinity (thus affecting up to 10% of the mouse or human genome). We show here that upon 
differentiation of mouse embryonic stem cells (ESCs) to neural progenitor cells (NPCs) and mouse embryonic fibroblasts (MEFs), 
a subset of “common” CTCF sites preserved in all three cell types tends to keep small NRL despite genome-wide NRL increase 
upon differentiation. This suggests a new role of differential CTCF binding: not only it changes 3D genome architecture, but 
also it defines regions which do not change (or change minimally) their nucleosome positioning. In order to clarify the 
molecular determinants of the NRL decrease near CTCF we systematically screened available experimental datasets in ESCs. This 
analysis showed that CTCF is unique in that the NRL decrease near its binding sites is correlated to its binding strength. The 
latter effect holds true both for the CTCF binding strength predicted from the DNA sequence and for its experimentally 
observed binding site occupancy in ESCs. Stronger CTCF binding leads to more efficient recruitment of chromatin remodellers 
Smarca4, Chd4, EP400, Chd8 and BRG1. Importantly, we show that Chd8 alone can bring about the NRL decrease near CTCF.'


# Prerequisites

```
git clone https://github.com/arq5x/bedtools2
git https://github.com/homeveg/nuctools
git clone https://github.com/chrisclarkson/nuctools_shiny # got to page for prerequisite installations and instructions

R
BiocManager::install("GenomicRanges")
BiocManager::install("AnnotationHub")
BiocManager::install("TFBSTools")
BiocManager::install("JASPAR2018")
BiocManager::install("TFBSTools")
BiocManager::install("BSgenome.Mmusculus.UCSC.mm9") 
install.packages("devtools")
devtools::install_github("matthuska/tRap")
```

![embed](https://github.com/chrisclarkson/pics/blob/master/FigureS1.png)

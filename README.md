# NRLcalc: calculation of the Nucleosome Repeat Length

The NRLcalc app provides a visual interface for the bulk calculation of the Nucleosome Repeat Length (NRL) based on multiple phasograms computed with NucTools (https://github.com/homeveg/nuctools)

# Description

Nucleosomes are positioned along the genome in a non-random and non-homogeneous way, which is critical for determining the DNA accessibility and maintaining fluid 3D genome organisation. A classical parameter characterising the nucleosome spacing is the nucleosome repeat length (NRL), defined as the average distance between the centres of adjacent nucleosomes. NRL can be defined genome-wide, locally for an individual genomic region or for a set of regions. The local NRL is particularly important, since it reflects different structures of chromatin fibers and characterises their changes e.g. during cell differentiation. 

Our analysis is based on the “phasogram” type of NRL calculation with [NucTools](https://github.com/homeveg/nuctools). The idea of this method is to consider all mapped nucleosome reads within the genomic region of interest and calculate the distribution of the frequencies of the distances between nucleosome dyads (so-called phasogram). This distribution typically shows peaks corresponding to the prevailing distance between two nearest neighbour nucleosomes followed by the distances between next neighbours. The slope of the line resulting from the linear fit of the positions of the peaks then gives the NRL. When the analysis requires calculating just one or few NRLs the procedure described above can be easily done with a number of applications performing simple linear regression. The situation becomes more tricky if we have to perform a bulk calculation of many NRLs. 

The applet 'NRLcalc.R' solves this problem by providing a visual interface to load multiple phasograms and calculating NRLs for each of them in an interactive, user-friendly way. NLcalc is based on the R package [shiny](https://shiny.rstudio.com). It allows one to load multiple phasograms, adjust the smoothing of the signal, perform interactive peak calling for each plot, switch between different phasograms by using the 'Next' and 'Back' buttons, etc. The animated gif below demonstrates how the applet works.

# NRLcalc.R
```
ls data/*aggregate.txt > data/files #list all files with phasogram data in 'files'

#the Rscript will read 'files' and can then the app can be run

R
install.packages('shiny')

install.packages('zoo')

install.packages('plyr')

Rscript NRLcalc.R #returns a url ID- "http://127.0.0.1:XXXX" which can be copied and pasted into your browser to use app.

###NOTE can also be run from RStudio- with the provided 'RunApp' button
```

# Data and scripts

I have provided example scripts and data as listed below:

`data`
Directory contains example phasogram text files used in NRL calculations for CTCF predicted binding sites.

`scripts`
Directory contains code the codes used in our manuscript preparation. These can be run sequentially from 'step_by_step.sh'. The prerequisites required for the applet are specified in 'prerequisites_scripts.sh'.

# Citation
Christopher T. Clarkson, Emma A. Deeks, Ralph Samarista, Victor B. Zhurkin and Vladimir B. Teif (2019) "CTCF-dependent chromatin boundaries formed by asymmetric nucleosome arrays with decreased linker length" ([link](https://academic.oup.com/nar/article/47/21/11181/5609524)) 

# Demonstration
![](https://github.com/chrisclarkson/pics/blob/master/ezgif.com-video-to-gif-3.gif)
